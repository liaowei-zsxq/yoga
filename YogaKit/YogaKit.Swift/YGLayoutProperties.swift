/*
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#if os(macOS)
import AppKit
#else
import UIKit
#endif
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

public extension YGLayout {

    @inlinable @discardableResult func flex(_ value: Int) -> YGLayout {
        flex = CGFloat(value)

        return self
    }

    @inlinable @discardableResult func flexGrow(_ value: Int) -> YGLayout {
        flexGrow = CGFloat(value)

        return self
    }

    @inlinable @discardableResult func flexShrink(_ value: Int) -> YGLayout {
        flexShrink = CGFloat(value)

        return self
    }

    @inlinable @discardableResult func borderLeftWidth(_ value: Int) -> YGLayout {
        borderLeftWidth = CGFloat(value)

        return self
    }

    @inlinable @discardableResult func borderTopWidth(_ value: Int) -> YGLayout {
        borderTopWidth = CGFloat(value)

        return self
    }

    @inlinable @discardableResult func borderRightWidth(_ value: Int) -> YGLayout {
        borderRightWidth = CGFloat(value)

        return self
    }

    @inlinable @discardableResult func borderBottomWidth(_ value: Int) -> YGLayout {
        borderBottomWidth = CGFloat(value)

        return self
    }

    @inlinable @discardableResult func borderStartWidth(_ value: Int) -> YGLayout {
        borderStartWidth = CGFloat(value)

        return self
    }

    @inlinable @discardableResult func borderEndWidth(_ value: Int) -> YGLayout {
        borderEndWidth = CGFloat(value)

        return self
    }

    @inlinable @discardableResult func borderWidth(_ value: Int) -> YGLayout {
        borderWidth = CGFloat(value)

        return self
    }

    @inlinable @discardableResult func aspectRatio(_ value: Int) -> YGLayout {
        aspectRatio = CGFloat(value)

        return self
    }
}

public extension YGLayout {

    @inlinable @discardableResult func flex(_ value: Double) -> YGLayout {
        flex = CGFloat(value)

        return self
    }

    @inlinable @discardableResult func flexGrow(_ value: Double) -> YGLayout {
        flexGrow = CGFloat(value)

        return self
    }

    @inlinable @discardableResult func flexShrink(_ value: Double) -> YGLayout {
        flexShrink = CGFloat(value)

        return self
    }

    @inlinable @discardableResult func borderLeftWidth(_ value: Double) -> YGLayout {
        borderLeftWidth = CGFloat(value)

        return self
    }

    @inlinable @discardableResult func borderTopWidth(_ value: Double) -> YGLayout {
        borderTopWidth = CGFloat(value)

        return self
    }

    @inlinable @discardableResult func borderRightWidth(_ value: Double) -> YGLayout {
        borderRightWidth = CGFloat(value)

        return self
    }

    @inlinable @discardableResult func borderBottomWidth(_ value: Double) -> YGLayout {
        borderBottomWidth = CGFloat(value)

        return self
    }

    @inlinable @discardableResult func borderStartWidth(_ value: Double) -> YGLayout {
        borderStartWidth = CGFloat(value)

        return self
    }

    @inlinable @discardableResult func borderEndWidth(_ value: Double) -> YGLayout {
        borderEndWidth = CGFloat(value)

        return self
    }

    @inlinable @discardableResult func borderWidth(_ value: Double) -> YGLayout {
        borderWidth = CGFloat(value)

        return self
    }

    @inlinable @discardableResult func aspectRatio(_ value: Double) -> YGLayout {
        aspectRatio = CGFloat(value)

        return self
    }
}

public extension YGLayout {

    @inlinable @discardableResult func flexBasis(_ value: CGFloat) -> YGLayout {
        flexBasis = .point(value)

        return self
    }

    @inlinable @discardableResult func left(_ value: CGFloat) -> YGLayout {
        left = .point(value)

        return self
    }

    @inlinable @discardableResult func top(_ value: CGFloat) -> YGLayout {
        top = .point(value)

        return self
    }

    @inlinable @discardableResult func right(_ value: CGFloat) -> YGLayout {
        right = .point(value)

        return self
    }

    @inlinable @discardableResult func bottom(_ value: CGFloat) -> YGLayout {
        bottom = .point(value)

        return self
    }

    @inlinable @discardableResult func start(_ value: CGFloat) -> YGLayout {
        start = .point(value)

        return self
    }

    @inlinable @discardableResult func end(_ value: CGFloat) -> YGLayout {
        end = .point(value)

        return self
    }

    @inlinable @discardableResult func marginLeft(_ value: CGFloat) -> YGLayout {
        marginLeft = .point(value)

        return self
    }

    @inlinable @discardableResult func marginTop(_ value: CGFloat) -> YGLayout {
        marginTop = .point(value)

        return self
    }

    @inlinable @discardableResult func marginRight(_ value: CGFloat) -> YGLayout {
        marginRight = .point(value)

        return self
    }

    @inlinable @discardableResult func marginBottom(_ value: CGFloat) -> YGLayout {
        marginBottom = .point(value)

        return self
    }

    @inlinable @discardableResult func marginStart(_ value: CGFloat) -> YGLayout {
        marginStart = .point(value)

        return self
    }

    @inlinable @discardableResult func marginEnd(_ value: CGFloat) -> YGLayout {
        marginEnd = .point(value)

        return self
    }

    @inlinable @discardableResult func marginHorizontal(_ value: CGFloat) -> YGLayout {
        marginHorizontal = .point(value)

        return self
    }

    @inlinable @discardableResult func marginVertical(_ value: CGFloat) -> YGLayout {
        marginVertical = .point(value)

        return self
    }

    @inlinable @discardableResult func margin(_ value: CGFloat) -> YGLayout {
        margin = .point(value)

        return self
    }

    @inlinable @discardableResult func paddingLeft(_ value: CGFloat) -> YGLayout {
        paddingLeft = .point(value)

        return self
    }

    @inlinable @discardableResult func paddingTop(_ value: CGFloat) -> YGLayout {
        paddingTop = .point(value)

        return self
    }

    @inlinable @discardableResult func paddingRight(_ value: CGFloat) -> YGLayout {
        paddingRight = .point(value)

        return self
    }

    @inlinable @discardableResult func paddingBottom(_ value: CGFloat) -> YGLayout {
        paddingBottom = .point(value)

        return self
    }

    @inlinable @discardableResult func paddingStart(_ value: CGFloat) -> YGLayout {
        paddingStart = .point(value)

        return self
    }

    @inlinable @discardableResult func paddingEnd(_ value: CGFloat) -> YGLayout {
        paddingEnd = .point(value)

        return self
    }

    @inlinable @discardableResult func paddingHorizontal(_ value: CGFloat) -> YGLayout {
        paddingHorizontal = .point(value)

        return self
    }

    @inlinable @discardableResult func paddingVertical(_ value: CGFloat) -> YGLayout {
        paddingVertical = .point(value)

        return self
    }

    @inlinable @discardableResult func padding(_ value: CGFloat) -> YGLayout {
        padding = .point(value)

        return self
    }

    @inlinable @discardableResult func width(_ value: CGFloat) -> YGLayout {
        width = .point(value)

        return self
    }

    @inlinable @discardableResult func height(_ value: CGFloat) -> YGLayout {
        height = .point(value)

        return self
    }

    @inlinable @discardableResult func minWidth(_ value: CGFloat) -> YGLayout {
        minWidth = .point(value)

        return self
    }

    @inlinable @discardableResult func minHeight(_ value: CGFloat) -> YGLayout {
        minHeight = .point(value)

        return self
    }

    @inlinable @discardableResult func maxWidth(_ value: CGFloat) -> YGLayout {
        maxWidth = .point(value)

        return self
    }

    @inlinable @discardableResult func maxHeight(_ value: CGFloat) -> YGLayout {
        maxHeight = .point(value)

        return self
    }
}

public extension YGLayout {

    @inlinable @discardableResult func flexBasis(_ value: Int) -> YGLayout {
        flexBasis = .point(value)

        return self
    }

    @inlinable @discardableResult func left(_ value: Int) -> YGLayout {
        left = .point(value)

        return self
    }

    @inlinable @discardableResult func top(_ value: Int) -> YGLayout {
        top = .point(value)

        return self
    }

    @inlinable @discardableResult func right(_ value: Int) -> YGLayout {
        right = .point(value)

        return self
    }

    @inlinable @discardableResult func bottom(_ value: Int) -> YGLayout {
        bottom = .point(value)

        return self
    }

    @inlinable @discardableResult func start(_ value: Int) -> YGLayout {
        start = .point(value)

        return self
    }

    @inlinable @discardableResult func end(_ value: Int) -> YGLayout {
        end = .point(value)

        return self
    }

    @inlinable @discardableResult func marginLeft(_ value: Int) -> YGLayout {
        marginLeft = .point(value)

        return self
    }

    @inlinable @discardableResult func marginTop(_ value: Int) -> YGLayout {
        marginTop = .point(value)

        return self
    }

    @inlinable @discardableResult func marginRight(_ value: Int) -> YGLayout {
        marginRight = .point(value)

        return self
    }

    @inlinable @discardableResult func marginBottom(_ value: Int) -> YGLayout {
        marginBottom = .point(value)

        return self
    }

    @inlinable @discardableResult func marginStart(_ value: Int) -> YGLayout {
        marginStart = .point(value)

        return self
    }

    @inlinable @discardableResult func marginEnd(_ value: Int) -> YGLayout {
        marginEnd = .point(value)

        return self
    }

    @inlinable @discardableResult func marginHorizontal(_ value: Int) -> YGLayout {
        marginHorizontal = .point(value)

        return self
    }

    @inlinable @discardableResult func marginVertical(_ value: Int) -> YGLayout {
        marginVertical = .point(value)

        return self
    }

    @inlinable @discardableResult func margin(_ value: Int) -> YGLayout {
        margin = .point(value)

        return self
    }

    @inlinable @discardableResult func paddingLeft(_ value: Int) -> YGLayout {
        paddingLeft = .point(value)

        return self
    }

    @inlinable @discardableResult func paddingTop(_ value: Int) -> YGLayout {
        paddingTop = .point(value)

        return self
    }

    @inlinable @discardableResult func paddingRight(_ value: Int) -> YGLayout {
        paddingRight = .point(value)

        return self
    }

    @inlinable @discardableResult func paddingBottom(_ value: Int) -> YGLayout {
        paddingBottom = .point(value)

        return self
    }

    @inlinable @discardableResult func paddingStart(_ value: Int) -> YGLayout {
        paddingStart = .point(value)

        return self
    }

    @inlinable @discardableResult func paddingEnd(_ value: Int) -> YGLayout {
        paddingEnd = .point(value)

        return self
    }

    @inlinable @discardableResult func paddingHorizontal(_ value: Int) -> YGLayout {
        paddingHorizontal = .point(value)

        return self
    }

    @inlinable @discardableResult func paddingVertical(_ value: Int) -> YGLayout {
        paddingVertical = .point(value)

        return self
    }

    @inlinable @discardableResult func padding(_ value: Int) -> YGLayout {
        padding = .point(value)

        return self
    }

    @inlinable @discardableResult func width(_ value: Int) -> YGLayout {
        width = .point(value)

        return self
    }

    @inlinable @discardableResult func height(_ value: Int) -> YGLayout {
        height = .point(value)

        return self
    }

    @inlinable @discardableResult func minWidth(_ value: Int) -> YGLayout {
        minWidth = .point(value)

        return self
    }

    @inlinable @discardableResult func minHeight(_ value: Int) -> YGLayout {
        minHeight = .point(value)

        return self
    }

    @inlinable @discardableResult func maxWidth(_ value: Int) -> YGLayout {
        maxWidth = .point(value)

        return self
    }

    @inlinable @discardableResult func maxHeight(_ value: Int) -> YGLayout {
        maxHeight = .point(value)

        return self
    }
}

public extension YGLayout {

    @inlinable @discardableResult func flexBasis(_ value: Double) -> YGLayout {
        flexBasis = .point(value)

        return self
    }

    @inlinable @discardableResult func left(_ value: Double) -> YGLayout {
        left = .point(value)

        return self
    }

    @inlinable @discardableResult func top(_ value: Double) -> YGLayout {
        top = .point(value)

        return self
    }

    @inlinable @discardableResult func right(_ value: Double) -> YGLayout {
        right = .point(value)

        return self
    }

    @inlinable @discardableResult func bottom(_ value: Double) -> YGLayout {
        bottom = .point(value)

        return self
    }

    @inlinable @discardableResult func start(_ value: Double) -> YGLayout {
        start = .point(value)

        return self
    }

    @inlinable @discardableResult func end(_ value: Double) -> YGLayout {
        end = .point(value)

        return self
    }

    @inlinable @discardableResult func marginLeft(_ value: Double) -> YGLayout {
        marginLeft = .point(value)

        return self
    }

    @inlinable @discardableResult func marginTop(_ value: Double) -> YGLayout {
        marginTop = .point(value)

        return self
    }

    @inlinable @discardableResult func marginRight(_ value: Double) -> YGLayout {
        marginRight = .point(value)

        return self
    }

    @inlinable @discardableResult func marginBottom(_ value: Double) -> YGLayout {
        marginBottom = .point(value)

        return self
    }

    @inlinable @discardableResult func marginStart(_ value: Double) -> YGLayout {
        marginStart = .point(value)

        return self
    }

    @inlinable @discardableResult func marginEnd(_ value: Double) -> YGLayout {
        marginEnd = .point(value)

        return self
    }

    @inlinable @discardableResult func marginHorizontal(_ value: Double) -> YGLayout {
        marginHorizontal = .point(value)

        return self
    }

    @inlinable @discardableResult func marginVertical(_ value: Double) -> YGLayout {
        marginVertical = .point(value)

        return self
    }

    @inlinable @discardableResult func margin(_ value: Double) -> YGLayout {
        margin = .point(value)

        return self
    }

    @inlinable @discardableResult func paddingLeft(_ value: Double) -> YGLayout {
        paddingLeft = .point(value)

        return self
    }

    @inlinable @discardableResult func paddingTop(_ value: Double) -> YGLayout {
        paddingTop = .point(value)

        return self
    }

    @inlinable @discardableResult func paddingRight(_ value: Double) -> YGLayout {
        paddingRight = .point(value)

        return self
    }

    @inlinable @discardableResult func paddingBottom(_ value: Double) -> YGLayout {
        paddingBottom = .point(value)

        return self
    }

    @inlinable @discardableResult func paddingStart(_ value: Double) -> YGLayout {
        paddingStart = .point(value)

        return self
    }

    @inlinable @discardableResult func paddingEnd(_ value: Double) -> YGLayout {
        paddingEnd = .point(value)

        return self
    }

    @inlinable @discardableResult func paddingHorizontal(_ value: Double) -> YGLayout {
        paddingHorizontal = .point(value)

        return self
    }

    @inlinable @discardableResult func paddingVertical(_ value: Double) -> YGLayout {
        paddingVertical = .point(value)

        return self
    }

    @inlinable @discardableResult func padding(_ value: Double) -> YGLayout {
        padding = .point(value)

        return self
    }

    @inlinable @discardableResult func width(_ value: Double) -> YGLayout {
        width = .point(value)

        return self
    }

    @inlinable @discardableResult func height(_ value: Double) -> YGLayout {
        height = .point(value)

        return self
    }

    @inlinable @discardableResult func minWidth(_ value: Double) -> YGLayout {
        minWidth = .point(value)

        return self
    }

    @inlinable @discardableResult func minHeight(_ value: Double) -> YGLayout {
        minHeight = .point(value)

        return self
    }

    @inlinable @discardableResult func maxWidth(_ value: Double) -> YGLayout {
        maxWidth = .point(value)

        return self
    }

    @inlinable @discardableResult func maxHeight(_ value: Double) -> YGLayout {
        maxHeight = .point(value)

        return self
    }
}

public extension YGLayout {

#if os(macOS)
    @inlinable @discardableResult func margins(_ value: NSEdgeInsets) -> YGLayout {
        margins = value

        return self
    }

    @inlinable @discardableResult func paddings(_ value: NSEdgeInsets) -> YGLayout {
        paddings = value

        return self
    }
#else
    @inlinable @discardableResult func margins(_ value: UIEdgeInsets) -> YGLayout {
        margins = value

        return self
    }

    @inlinable @discardableResult func paddings(_ value: UIEdgeInsets) -> YGLayout {
        paddings = value

        return self
    }
#endif

    @inlinable @discardableResult func size(_ value: CGSize) -> YGLayout {
        size = value

        return self
    }
}

public extension YGLayout {
    
    @inlinable @discardableResult func margins(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> YGLayout {
#if os(macOS)
        margins = NSEdgeInsets(top: top, left: left, bottom: bottom, right: right)
#else
        margins = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
#endif
        return self
    }

    @inlinable @discardableResult func paddings(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> YGLayout {
#if os(macOS)
        paddings = NSEdgeInsets(top: top, left: left, bottom: bottom, right: right)
#else
        paddings = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
#endif

        return self
    }

    @inlinable @discardableResult func size(width: CGFloat, height: CGFloat) -> YGLayout {
        size = CGSize(width: width, height: height)

        return self
    }
}
