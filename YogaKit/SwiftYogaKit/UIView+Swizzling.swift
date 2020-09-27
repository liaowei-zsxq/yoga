//
//  UIView+Swizzling.swift
//  SwiftYogaKit
//
//  Created by v on 2020/9/27.
//  Copyright © 2020 facebook. All rights reserved.
//

#if os(macOS)
import AppKit
typealias UIView = NSView
typealias UIControl = NSControl
#else
import UIKit
#endif

import ObjectiveC.runtime

private func YogaSwizzleInstanceMethod(_ cls: AnyClass, _ originalSelector: Selector, _ swizzledSelector: Selector) {
    guard let originalMethod = class_getInstanceMethod(cls, originalSelector),
          let swizzledMethod = class_getInstanceMethod(cls, swizzledSelector) else {
        return
    }

    let swizzledIMP = method_getImplementation(swizzledMethod)
    if class_addMethod(cls, originalSelector, swizzledIMP, method_getTypeEncoding(swizzledMethod)) {
        class_replaceMethod(cls,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod))
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }
}

extension UIView {

    @objc public class func SwiftYogaKitSwizzle() {
        struct once {
            static let token = { () -> Bool in
                YogaSwizzleInstanceMethod(UIView.self, #selector(UIView.init(frame:)), #selector(_swift_yoga_init(frame:)))
                YogaSwizzleInstanceMethod(UIView.self, #selector(setter: UIView.frame), #selector(_swift_yoga_set(frame:)))
                YogaSwizzleInstanceMethod(UIView.self, #selector(setter: UIView.bounds), #selector(_swift_yoga_set(bounds:)))
                #if os(macOS)
                YogaSwizzleInstanceMethod(NSView.self, #selector(NSView.setFrameSize(_:)), #selector(_swift_yoga_set(frameSize:)))
                YogaSwizzleInstanceMethod(NSView.self, #selector(NSView.setBoundsSize(_:)), #selector(_swift_yoga_set(boundsSize:)))
                #endif

                return true
            }()
        }

        _ = once.token
    }

    @objc dynamic func _swift_yoga_init(frame: CGRect) -> Any? {
        let instance = _swift_yoga_init(frame: frame)
        _swift_yoga_apply_layout()

        return instance
    }

    @objc dynamic func _swift_yoga_set(frame: CGRect) {
        _swift_yoga_set(frame: frame)
        _swift_yoga_apply_layout()
    }

    @objc dynamic func _swift_yoga_set(bounds: CGRect) {
        _swift_yoga_set(bounds: bounds)
        _swift_yoga_apply_layout()
    }

    #if os(macOS)
    @objc dynamic func _swift_yoga_set(frameSize: CGSize) {
        _swift_yoga_set(frameSize: frameSize)
        _swift_yoga_apply_layout()
    }

    @objc dynamic func _swift_yoga_set(boundsSize: CGSize) {
        _swift_yoga_set(boundsSize: boundsSize)
        _swift_yoga_apply_layout()
    }
    #endif

    func _swift_yoga_apply_layout() {
        let size = bounds.size
        guard size.width > 0, size.height > 0, isYogaEnabled else {
            return
        }

        yoga.applyLayout(preservingOrigin: true)
    }
}
