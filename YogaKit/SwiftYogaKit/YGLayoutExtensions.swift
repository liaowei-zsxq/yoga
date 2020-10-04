/*
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

@_exported import Yoga

postfix operator %

extension Int {

    public static postfix func %(value: Int) -> YGValue {
        return YGValue(value: YGFloat(value), unit: .percent)
    }
}

extension Float {

    public static postfix func %(value: Float) -> YGValue {
        return YGValue(value: YGFloat(value), unit: .percent)
    }
}

extension CGFloat {

    public static postfix func %(value: CGFloat) -> YGValue {
        return YGValue(value: YGFloat(value), unit: .percent)
    }
}

extension YGValue: ExpressibleByIntegerLiteral, ExpressibleByFloatLiteral {

    public init(integerLiteral value: Int) {
        self = YGValue(value: YGFloat(value), unit: .point)
    }

    public init(floatLiteral value: Float) {
        self = YGValue(value: YGFloat(value), unit: .point)
    }

    public init(_ value: Int) {
        self = YGValue(value: YGFloat(value), unit: .point)
    }

    public init(_ value: Float) {
        self = YGValue(value: YGFloat(value), unit: .point)
    }

    public init(_ value: Double) {
        self = YGValue(value: YGFloat(value), unit: .point)
    }

    public init(_ value: CGFloat) {
        self = YGValue(value: YGFloat(value), unit: .point)
    }
}

extension YGValue {

    public static var zero: YGValue {
        get {
            return YGValue(value: 0, unit: .point)
        }
    }

    public static var auto: YGValue {
        get {
            return YGValue(value: YGUndefined, unit: .auto)
        }
    }

    public static var undefined: YGValue {
        get {
            return YGValue(value: YGUndefined, unit: .undefined)
        }
    }

    public static func point(_ value: CGFloat) -> YGValue {
        return YGValue(value: YGFloat(value), unit: .point)
    }

    public static func point(_ value: Double) -> YGValue {
        return YGValue(value: YGFloat(value), unit: .point)
    }

    public static func point(_ value: Float) -> YGValue {
        return YGValue(value: YGFloat(value), unit: .point)
    }

    public static func point(_ value: Int) -> YGValue {
        return YGValue(value: YGFloat(value), unit: .point)
    }

    public static func percent(_ value: CGFloat) -> YGValue {
        return YGValue(value: YGFloat(value), unit: .percent)
    }

    public static func percent(_ value: Double) -> YGValue {
        return YGValue(value: YGFloat(value), unit: .percent)
    }

    public static func percent(_ value: Float) -> YGValue {
        return YGValue(value: YGFloat(value), unit: .percent)
    }

    public static func percent(_ value: Int) -> YGValue {
        return YGValue(value: YGFloat(value), unit: .percent)
    }
}

extension YGSize {

    public static var zero: YGSize {
        get {
            return YGSize(width: 0, height: 0)
        }
    }
}
