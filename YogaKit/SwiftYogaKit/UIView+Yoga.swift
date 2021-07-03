//
//  UIView+Yoga.swift
//  SwiftYogaKit
//
//  Created by v on 2020/9/26.
//  Copyright © 2020 facebook. All rights reserved.
//

#if os(macOS)
import AppKit
#else
import UIKit
#endif

import ObjectiveC.runtime

private var kYGYogaAssociatedKey: UInt8 = 0

extension UIView {

    public var yoga: YGLayout {
        get {
            guard let yoga = objc_getAssociatedObject(self, &kYGYogaAssociatedKey) as? YGLayout else {
                let yoga = YGLayout(view: self)
                objc_setAssociatedObject(self, &kYGYogaAssociatedKey, yoga, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)

                return yoga
            }

            return yoga
        }
    }

    public var isYogaEnabled: Bool {
        let yoga = objc_getAssociatedObject(self, &kYGYogaAssociatedKey) as? YGLayout

        return yoga != nil
    }
}
