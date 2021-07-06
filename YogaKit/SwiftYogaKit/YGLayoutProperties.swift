/*
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

import CoreGraphics
import YogaKit

public extension YGLayout {

    @inlinable @discardableResult func direction(_ value: YGDirection) -> YGLayout {
        direction = value

        return self
    }

    @inlinable @discardableResult func flexDirection(_ value: YGFlexDirection) -> YGLayout {
        flexDirection = value

        return self
    }

    @inlinable @discardableResult func justifyContent(_ value: YGJustify) -> YGLayout {
        justifyContent = value

        return self
    }

    @inlinable @discardableResult func alignContent(_ value: YGAlign) -> YGLayout {
        alignContent = value

        return self
    }

    @inlinable @discardableResult func alignItems(_ value: YGAlign) -> YGLayout {
        alignItems = value

        return self
    }

    @inlinable @discardableResult func alignSelf(_ value: YGAlign) -> YGLayout {
        alignSelf = value

        return self
    }

    @inlinable @discardableResult func position(_ value: YGPositionType) -> YGLayout {
        position = value

        return self
    }

    @inlinable @discardableResult func flexWrap(_ value: YGWrap) -> YGLayout {
        flexWrap = value

        return self
    }

    @inlinable @discardableResult func overflow(_ value: YGOverflow) -> YGLayout {
        overflow = value

        return self
    }

    @inlinable @discardableResult func display(_ value: YGDisplay) -> YGLayout {
        display = value

        return self
    }

    @inlinable @discardableResult func flex(_ value: CGFloat) -> YGLayout {
        flex = value

        return self
    }

    @inlinable @discardableResult func flexGrow(_ value: CGFloat) -> YGLayout {
        flexGrow = value

        return self
    }

    @inlinable @discardableResult func flexShrink(_ value: CGFloat) -> YGLayout {
        flexShrink = value

        return self
    }

    @inlinable @discardableResult func flexBasis(_ value: YGValue) -> YGLayout {
        flexBasis = value

        return self
    }

    @inlinable @discardableResult func left(_ value: YGValue) -> YGLayout {
        left = value

        return self
    }

    @inlinable @discardableResult func top(_ value: YGValue) -> YGLayout {
        top = value

        return self
    }

    @inlinable @discardableResult func right(_ value: YGValue) -> YGLayout {
        right = value

        return self
    }

    @inlinable @discardableResult func bottom(_ value: YGValue) -> YGLayout {
        bottom = value

        return self
    }

    @inlinable @discardableResult func start(_ value: YGValue) -> YGLayout {
        start = value

        return self
    }

    @inlinable @discardableResult func end(_ value: YGValue) -> YGLayout {
        end = value

        return self
    }

    @inlinable @discardableResult func marginLeft(_ value: YGValue) -> YGLayout {
        marginLeft = value

        return self
    }

    @inlinable @discardableResult func marginTop(_ value: YGValue) -> YGLayout {
        marginTop = value

        return self
    }

    @inlinable @discardableResult func marginRight(_ value: YGValue) -> YGLayout {
        marginRight = value

        return self
    }

    @inlinable @discardableResult func marginBottom(_ value: YGValue) -> YGLayout {
        marginBottom = value

        return self
    }

    @inlinable @discardableResult func marginStart(_ value: YGValue) -> YGLayout {
        marginStart = value

        return self
    }

    @inlinable @discardableResult func marginEnd(_ value: YGValue) -> YGLayout {
        marginEnd = value

        return self
    }

    @inlinable @discardableResult func marginHorizontal(_ value: YGValue) -> YGLayout {
        marginHorizontal = value

        return self
    }

    @inlinable @discardableResult func marginVertical(_ value: YGValue) -> YGLayout {
        marginVertical = value

        return self
    }

    @inlinable @discardableResult func margin(_ value: YGValue) -> YGLayout {
        margin = value

        return self
    }

    @inlinable @discardableResult func paddingLeft(_ value: YGValue) -> YGLayout {
        paddingLeft = value

        return self
    }

    @inlinable @discardableResult func paddingTop(_ value: YGValue) -> YGLayout {
        paddingTop = value

        return self
    }

    @inlinable @discardableResult func paddingRight(_ value: YGValue) -> YGLayout {
        paddingRight = value

        return self
    }

    @inlinable @discardableResult func paddingBottom(_ value: YGValue) -> YGLayout {
        paddingBottom = value

        return self
    }

    @inlinable @discardableResult func paddingStart(_ value: YGValue) -> YGLayout {
        paddingStart = value

        return self
    }

    @inlinable @discardableResult func paddingEnd(_ value: YGValue) -> YGLayout {
        paddingEnd = value

        return self
    }

    @inlinable @discardableResult func paddingHorizontal(_ value: YGValue) -> YGLayout {
        paddingHorizontal = value

        return self
    }

    @inlinable @discardableResult func paddingVertical(_ value: YGValue) -> YGLayout {
        paddingVertical = value

        return self
    }

    @inlinable @discardableResult func padding(_ value: YGValue) -> YGLayout {
        padding = value

        return self
    }

    @inlinable @discardableResult func borderLeftWidth(_ value: CGFloat) -> YGLayout {
        borderLeftWidth = value

        return self
    }

    @inlinable @discardableResult func borderTopWidth(_ value: CGFloat) -> YGLayout {
        borderTopWidth = value

        return self
    }

    @inlinable @discardableResult func borderRightWidth(_ value: CGFloat) -> YGLayout {
        borderRightWidth = value

        return self
    }

    @inlinable @discardableResult func borderBottomWidth(_ value: CGFloat) -> YGLayout {
        borderBottomWidth = value

        return self
    }

    @inlinable @discardableResult func borderStartWidth(_ value: CGFloat) -> YGLayout {
        borderStartWidth = value

        return self
    }

    @inlinable @discardableResult func borderEndWidth(_ value: CGFloat) -> YGLayout {
        borderEndWidth = value

        return self
    }

    @inlinable @discardableResult func borderWidth(_ value: CGFloat) -> YGLayout {
        borderWidth = value

        return self
    }

    @inlinable @discardableResult func width(_ value: YGValue) -> YGLayout {
        width = value

        return self
    }

    @inlinable @discardableResult func height(_ value: YGValue) -> YGLayout {
        height = value

        return self
    }

    @inlinable @discardableResult func minWidth(_ value: YGValue) -> YGLayout {
        minWidth = value

        return self
    }

    @inlinable @discardableResult func minHeight(_ value: YGValue) -> YGLayout {
        minHeight = value

        return self
    }

    @inlinable @discardableResult func maxWidth(_ value: YGValue) -> YGLayout {
        maxWidth = value

        return self
    }

    @inlinable @discardableResult func maxHeight(_ value: YGValue) -> YGLayout {
        maxHeight = value

        return self
    }

    // Yoga specific properties, not compatible with flexbox specification
    @inlinable @discardableResult func aspectRatio(_ value: CGFloat) -> YGLayout {
        aspectRatio = value

        return self
    }

    @inlinable @discardableResult func includInLayout(_ value: Bool = true) -> YGLayout {
        isIncludedInLayout = value

        return self
    }
}
