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

private extension CGRect {
    @inline(__always) var isStandlized: Bool {
        let x = minX, y = minY, w = width, h = height

        return !(x.isNaN || x.isInfinite ||
                 y.isNaN || y.isInfinite ||
                 w.isNaN || w.isInfinite ||
                 h.isNaN || h.isInfinite)
    }

    @inline(__always) var standlized: CGRect {
        get {
            if isStandlized {
                return self
            }

            let x = minX, y = minY
            var origin = self.origin
            origin.x = x.isNaN || x.isInfinite ? 0 : x
            origin.y = y.isNaN || y.isInfinite ? 0 : y

            let w = width, h = height
            var size = self.size
            size.width = w.isNaN || w.isInfinite ? 0 : w
            size.height = h.isNaN || h.isInfinite ? 0 : h

            return CGRect(origin: origin, size: size)
        }
    }
}

#if os(macOS)
private extension CGSize {
    @inline(__always) var standlized: CGSize {
        get {
            return CGRect(origin: .zero, size: self).standlized.size
        }
    }
}
#endif

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
        let instance = _swift_yoga_init(frame: frame.standlized)
        _swift_yoga_apply_layout()

        return instance
    }

    @objc dynamic func _swift_yoga_set(frame: CGRect) {
        _swift_yoga_set(frame: frame.standlized)
        _swift_yoga_apply_layout()
    }

    @objc dynamic func _swift_yoga_set(bounds: CGRect) {
        _swift_yoga_set(bounds: bounds.standlized)
        _swift_yoga_apply_layout()
    }

    #if os(macOS)
    @objc dynamic func _swift_yoga_set(frameSize: CGSize) {
        _swift_yoga_set(frameSize: frameSize.standlized)
        _swift_yoga_apply_layout()
    }

    @objc dynamic func _swift_yoga_set(boundsSize: CGSize) {
        _swift_yoga_set(boundsSize: boundsSize.standlized)
        _swift_yoga_apply_layout()
    }
    #endif

    func _swift_yoga_apply_layout() {
        guard isYogaEnabled else {
            return
        }

        let yoga = self.yoga
        if yoga.isIncludedInLayout {
            yoga.applyLayout(preservingOrigin: true)
        }
    }
}
