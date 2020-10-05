/*
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

@_exported import Yoga

postfix operator %

extension Int {

    @inlinable public static postfix func %(value: Int) -> YGValue {
        return YGValue(value: YGFloat(value), unit: .percent)
    }
}

extension Float {

    @inlinable public static postfix func %(value: Float) -> YGValue {
        return YGValue(value: YGFloat(value), unit: .percent)
    }
}

extension CGFloat {

    @inlinable public static postfix func %(value: CGFloat) -> YGValue {
        return YGValue(value: YGFloat(value), unit: .percent)
    }
}

extension YGValue: ExpressibleByIntegerLiteral, ExpressibleByFloatLiteral {

    @inlinable public init(integerLiteral value: Int) {
        self = YGValue(value: YGFloat(value), unit: .point)
    }

    @inlinable public init(floatLiteral value: Float) {
        self = YGValue(value: YGFloat(value), unit: .point)
    }

    @inlinable public init(_ value: Int) {
        self = YGValue(value: YGFloat(value), unit: .point)
    }

    @inlinable public init(_ value: Float) {
        self = YGValue(value: YGFloat(value), unit: .point)
    }

    @inlinable public init(_ value: Double) {
        self = YGValue(value: YGFloat(value), unit: .point)
    }

    @inlinable public init(_ value: CGFloat) {
        self = YGValue(value: YGFloat(value), unit: .point)
    }
}

extension YGValue {

    @inlinable public static var zero: YGValue {
        get {
            return YGValue(value: 0, unit: .point)
        }
    }

    @inlinable public static var auto: YGValue {
        get {
            return YGValue(value: YGUndefined, unit: .auto)
        }
    }

    @inlinable public static var undefined: YGValue {
        get {
            return YGValue(value: YGUndefined, unit: .undefined)
        }
    }

    @inlinable public static func point(_ value: CGFloat) -> YGValue {
        return YGValue(value: YGFloat(value), unit: .point)
    }

    @inlinable public static func point(_ value: Double) -> YGValue {
        return YGValue(value: YGFloat(value), unit: .point)
    }

    @inlinable public static func point(_ value: Float) -> YGValue {
        return YGValue(value: YGFloat(value), unit: .point)
    }

    @inlinable public static func point(_ value: Int) -> YGValue {
        return YGValue(value: YGFloat(value), unit: .point)
    }

    @inlinable public static func percent(_ value: CGFloat) -> YGValue {
        return YGValue(value: YGFloat(value), unit: .percent)
    }

    @inlinable public static func percent(_ value: Double) -> YGValue {
        return YGValue(value: YGFloat(value), unit: .percent)
    }

    @inlinable public static func percent(_ value: Float) -> YGValue {
        return YGValue(value: YGFloat(value), unit: .percent)
    }

    @inlinable public static func percent(_ value: Int) -> YGValue {
        return YGValue(value: YGFloat(value), unit: .percent)
    }
}

extension YGSize {

    @inlinable public static var zero: YGSize {
        get {
            return YGSize(width: 0, height: 0)
        }
    }
}

extension YGNodeRef {

    @inlinable var context: UnsafeRawPointer? {
        get {
            return YGNodeGetContext(self)
        }

        set {
            YGNodeSetContext(self, newValue)
        }
    }

    @inlinable var childCount: UInt {
        get {
            return UInt(YGNodeGetChildCount(self))
        }
    }

    @inlinable func getChild(_ index: Int) -> YGNodeRef? {
        return YGNodeGetChild(self, UInt32(index))
    }

    @inlinable func removeAllChildren() {
        YGNodeRemoveAllChildren(self)
    }

    @inlinable var hasMeasureFunc: Bool {
        get {
            return YGNodeHasMeasureFunc(self)
        }
    }

    @inlinable func setMeasureFunc(_ fn: YGMeasureFunc?) {
        YGNodeSetMeasureFunc(self, fn)
    }

    @inlinable func insertChild(_ node: YGNodeRef, at index: Int) {
        YGNodeInsertChild(self, node, UInt32(index))
    }

    @inlinable var isDirty: Bool {
        get {
            return YGNodeIsDirty(self)
        }
    }

    @inlinable func markDirty() {
        YGNodeMarkDirty(self)
    }

    @inlinable var direction: YGDirection {
        get {
            return YGNodeLayoutGetDirection(self)
        }
    }

    @inlinable var top: YGFloat {
        get {
            return YGNodeLayoutGetTop(self)
        }
    }

    @inlinable var left: YGFloat {
        get {
            return YGNodeLayoutGetLeft(self)
        }
    }

    @inlinable var width: YGFloat {
        get {
            return max(YGNodeLayoutGetWidth(self), 0)
        }
    }

    @inlinable var height: YGFloat {
        get {
            return max(YGNodeLayoutGetHeight(self), 0)
        }
    }
}
