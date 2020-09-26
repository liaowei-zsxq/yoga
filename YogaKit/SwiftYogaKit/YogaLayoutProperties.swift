//
//  YogaLayout+Properties.swift
//  SwiftYogaKit
//
//  Created by v on 2020/9/26.
//  Copyright © 2020 facebook. All rights reserved.
//

import Yoga

public extension YGLayout {

    var direction: YGDirection {
        get {
            return YGNodeStyleGetDirection(node)
        }

        set {
            YGNodeStyleSetDirection(node, newValue)
        }
    }

    var flexDirection: YGFlexDirection {
        get {
            return YGNodeStyleGetFlexDirection(node)
        }

        set {
            YGNodeStyleSetFlexDirection(node, newValue)
        }
    }

    var justifyContent: YGJustify {
        get {
            return YGNodeStyleGetJustifyContent(node)
        }

        set {
            YGNodeStyleSetJustifyContent(node, newValue)
        }
    }

    var alignContent: YGAlign {
        get {
            return YGNodeStyleGetAlignContent(node)
        }

        set {
            YGNodeStyleSetAlignContent(node, newValue)
        }
    }

    var alignItems: YGAlign {
        get {
            return YGNodeStyleGetAlignItems(node)
        }

        set {
            YGNodeStyleSetAlignItems(node, newValue)
        }
    }

    var alignSelf: YGAlign {
        get {
            return YGNodeStyleGetAlignSelf(node)
        }

        set {
            YGNodeStyleSetAlignSelf(node, newValue)
        }
    }

    var position: YGPositionType {
        get {
            return YGNodeStyleGetPositionType(node)
        }

        set {
            YGNodeStyleSetPositionType(node, newValue)
        }
    }

    var flexWrap: YGWrap {
        get {
            return YGNodeStyleGetFlexWrap(node)
        }

        set {
            YGNodeStyleSetFlexWrap(node, newValue)
        }
    }

    var overflow: YGOverflow {
        get {
            return YGNodeStyleGetOverflow(node)
        }

        set {
            YGNodeStyleSetOverflow(node, newValue)
        }
    }

    var display: YGDisplay {
        get {
            YGNodeStyleGetDisplay(node)
        }

        set {
            YGNodeStyleSetDisplay(node, newValue)
        }
    }

    var flex: CGFloat {
        get {
            return CGFloat(YGNodeStyleGetFlex(node))
        }

        set {
            YGNodeStyleSetFlex(node, YGFloat(newValue))
        }
    }

    var flexGrow: CGFloat {
        get {
            return CGFloat(YGNodeStyleGetFlexGrow(node))
        }

        set {
            YGNodeStyleSetFlexGrow(node, YGFloat(newValue))
        }
    }

    var flexShrink: CGFloat {
        get {
            return CGFloat(YGNodeStyleGetFlexShrink(node))
        }

        set {
            YGNodeStyleSetFlexShrink(node, YGFloat(newValue))
        }
    }

    var flexBasis: YGValue {
        get {
            return YGNodeStyleGetFlexBasis(node)
        }

        set {
            switch newValue.unit {
            case .percent:
                YGNodeStyleSetFlexBasisPercent(node, newValue.value)
            case .point:
                YGNodeStyleSetFlexBasis(node, newValue.value)
            case .auto:
                YGNodeStyleSetFlexBasisAuto(node)
            default:
                break
            }
        }
    }

    var left: YGValue {
        get {
            return YGNodeStyleGetPosition(node, .left)
        }

        set {
            switch newValue.unit {
            case .percent:
                YGNodeStyleSetPositionPercent(node, .left, newValue.value)
            case .point:
                YGNodeStyleSetPosition(node, .left, newValue.value)

            default:
                break
            }
        }
    }

    var top: YGValue {
        get {
            return YGNodeStyleGetPosition(node, .top)
        }

        set {
            switch newValue.unit {
            case .percent:
                YGNodeStyleSetPositionPercent(node, .top, newValue.value)
            case .point:
                YGNodeStyleSetPosition(node, .top, newValue.value)

            default:
                break
            }
        }
    }

    var right: YGValue {
        get {
            return YGNodeStyleGetPosition(node, .right)
        }

        set {
            switch newValue.unit {
            case .percent:
                YGNodeStyleSetPositionPercent(node, .right, newValue.value)
            case .point:
                YGNodeStyleSetPosition(node, .right, newValue.value)

            default:
                break
            }
        }
    }

    var bottom: YGValue {
        get {
            return YGNodeStyleGetPosition(node, .bottom)
        }

        set {
            switch newValue.unit {
            case .percent:
                YGNodeStyleSetPositionPercent(node, .bottom, newValue.value)
            case .point:
                YGNodeStyleSetPosition(node, .bottom, newValue.value)

            default:
                break
            }
        }
    }

    var start: YGValue {
        get {
            return YGNodeStyleGetPosition(node, .start)
        }

        set {
            switch newValue.unit {
            case .percent:
                YGNodeStyleSetPositionPercent(node, .start, newValue.value)
            case .point:
                YGNodeStyleSetPosition(node, .start, newValue.value)

            default:
                break
            }
        }
    }

    var end: YGValue {
        get {
            return YGNodeStyleGetPosition(node, .end)
        }

        set {
            switch newValue.unit {
            case .percent:
                YGNodeStyleSetPositionPercent(node, .end, newValue.value)
            case .point:
                YGNodeStyleSetPosition(node, .end, newValue.value)

            default:
                break
            }
        }
    }

    var marginLeft: YGValue {
        get {
            return YGNodeStyleGetMargin(node, .left)
        }

        set {
            switch newValue.unit {
            case .percent:
                YGNodeStyleSetMarginPercent(node, .left, newValue.value)
            case .point:
                YGNodeStyleSetMargin(node, .left, newValue.value)
            case .auto:
                YGNodeStyleSetMarginAuto(node, .left)
            default:
                break
            }
        }
    }

    var marginTop: YGValue {
        get {
            return YGNodeStyleGetMargin(node, .top)
        }

        set {
            switch newValue.unit {
            case .percent:
                YGNodeStyleSetMarginPercent(node, .top, newValue.value)
            case .point:
                YGNodeStyleSetMargin(node, .top, newValue.value)
            case .auto:
                YGNodeStyleSetMarginAuto(node, .top)
            default:
                break
            }
        }
    }

    var marginRight: YGValue {
        get {
            return YGNodeStyleGetMargin(node, .right)
        }

        set {
            switch newValue.unit {
            case .percent:
                YGNodeStyleSetMarginPercent(node, .right, newValue.value)
            case .point:
                YGNodeStyleSetMargin(node, .right, newValue.value)
            case .auto:
                YGNodeStyleSetMarginAuto(node, .right)
            default:
                break
            }
        }
    }

    var marginBottom: YGValue {
        get {
            return YGNodeStyleGetMargin(node, .bottom)
        }

        set {
            switch newValue.unit {
            case .percent:
                YGNodeStyleSetMarginPercent(node, .bottom, newValue.value)
            case .point:
                YGNodeStyleSetMargin(node, .bottom, newValue.value)
            case .auto:
                YGNodeStyleSetMarginAuto(node, .bottom)
            default:
                break
            }
        }
    }

    var marginStart: YGValue {
        get {
            return YGNodeStyleGetMargin(node, .start)
        }

        set {
            switch newValue.unit {
            case .percent:
                YGNodeStyleSetMarginPercent(node, .start, newValue.value)
            case .point:
                YGNodeStyleSetMargin(node, .start, newValue.value)
            case .auto:
                YGNodeStyleSetMarginAuto(node, .start)
            default:
                break
            }
        }
    }

    var marginEnd: YGValue {
        get {
            return YGNodeStyleGetMargin(node, .end)
        }

        set {
            switch newValue.unit {
            case .percent:
                YGNodeStyleSetMarginPercent(node, .end, newValue.value)
            case .point:
                YGNodeStyleSetMargin(node, .end, newValue.value)
            case .auto:
                YGNodeStyleSetMarginAuto(node, .end)
            default:
                break
            }
        }
    }

    var marginHorizontal: YGValue {
        get {
            return YGNodeStyleGetMargin(node, .horizontal)
        }

        set {
            switch newValue.unit {
            case .percent:
                YGNodeStyleSetMarginPercent(node, .horizontal, newValue.value)
            case .point:
                YGNodeStyleSetMargin(node, .horizontal, newValue.value)
            case .auto:
                YGNodeStyleSetMarginAuto(node, .horizontal)
            default:
                break
            }
        }
    }

    var marginVertical: YGValue {
        get {
            return YGNodeStyleGetMargin(node, .vertical)
        }

        set {
            switch newValue.unit {
            case .percent:
                YGNodeStyleSetMarginPercent(node, .vertical, newValue.value)
            case .point:
                YGNodeStyleSetMargin(node, .vertical, newValue.value)
            case .auto:
                YGNodeStyleSetMarginAuto(node, .vertical)
            default:
                break
            }
        }
    }

    var margin: YGValue {
        get {
            return YGNodeStyleGetMargin(node, .all)
        }

        set {
            switch newValue.unit {
            case .percent:
                YGNodeStyleSetMarginPercent(node, .all, newValue.value)
            case .point:
                YGNodeStyleSetMargin(node, .all, newValue.value)
            case .auto:
                YGNodeStyleSetMarginAuto(node, .all)
            default:
                break
            }
        }
    }

    var paddingLeft: YGValue {
        get {
            return YGNodeStyleGetPadding(node, .left)
        }

        set {
            switch newValue.unit {
            case .percent:
                YGNodeStyleSetPaddingPercent(node, .left, newValue.value)
            case .point:
                YGNodeStyleSetPadding(node, .left, newValue.value)
            default:
                break
            }
        }
    }

    var paddingTop: YGValue {
        get {
            return YGNodeStyleGetPadding(node, .top)
        }

        set {
            switch newValue.unit {
            case .percent:
                YGNodeStyleSetPaddingPercent(node, .top, newValue.value)
            case .point:
                YGNodeStyleSetPadding(node, .top, newValue.value)
            default:
                break
            }
        }
    }

    var paddingRight: YGValue {
        get {
            return YGNodeStyleGetPadding(node, .right)
        }

        set {
            switch newValue.unit {
            case .percent:
                YGNodeStyleSetPaddingPercent(node, .right, newValue.value)
            case .point:
                YGNodeStyleSetPadding(node, .right, newValue.value)
            default:
                break
            }
        }
    }

    var paddingBottom: YGValue {
        get {
            return YGNodeStyleGetPadding(node, .bottom)
        }

        set {
            switch newValue.unit {
            case .percent:
                YGNodeStyleSetPaddingPercent(node, .bottom, newValue.value)
            case .point:
                YGNodeStyleSetPadding(node, .bottom, newValue.value)
            default:
                break
            }
        }
    }

    var paddingStart: YGValue {
        get {
            return YGNodeStyleGetPadding(node, .start)
        }

        set {
            switch newValue.unit {
            case .percent:
                YGNodeStyleSetPaddingPercent(node, .start, newValue.value)
            case .point:
                YGNodeStyleSetPadding(node, .start, newValue.value)
            default:
                break
            }
        }
    }

    var paddingEnd: YGValue {
        get {
            return YGNodeStyleGetPadding(node, .end)
        }

        set {
            switch newValue.unit {
            case .percent:
                YGNodeStyleSetPaddingPercent(node, .end, newValue.value)
            case .point:
                YGNodeStyleSetPadding(node, .end, newValue.value)
            default:
                break
            }
        }
    }

    var paddingHorizontal: YGValue {
        get {
            return YGNodeStyleGetPadding(node, .horizontal)
        }

        set {
            switch newValue.unit {
            case .percent:
                YGNodeStyleSetPaddingPercent(node, .horizontal, newValue.value)
            case .point:
                YGNodeStyleSetPadding(node, .horizontal, newValue.value)
            default:
                break
            }
        }
    }

    var paddingVertical: YGValue {
        get {
            return YGNodeStyleGetPadding(node, .vertical)
        }

        set {
            switch newValue.unit {
            case .percent:
                YGNodeStyleSetPaddingPercent(node, .vertical, newValue.value)
            case .point:
                YGNodeStyleSetPadding(node, .vertical, newValue.value)
            default:
                break
            }
        }
    }

    var padding: YGValue {
        get {
            return YGNodeStyleGetPadding(node, .all)
        }

        set {
            switch newValue.unit {
            case .percent:
                YGNodeStyleSetPaddingPercent(node, .all, newValue.value)
            case .point:
                YGNodeStyleSetPadding(node, .all, newValue.value)
            default:
                break
            }
        }
    }

    var borderLeftWidth: CGFloat {
        get {
            return CGFloat(YGNodeStyleGetBorder(node, .left))
        }

        set {
            YGNodeStyleSetBorder(node, .left, YGFloat(newValue))
        }
    }

    var borderTopWidth: CGFloat {
        get {
            return CGFloat(YGNodeStyleGetBorder(node, .top))
        }

        set {
            YGNodeStyleSetBorder(node, .top, YGFloat(newValue))
        }
    }

    var borderRightWidth: CGFloat {
        get {
            return CGFloat(YGNodeStyleGetBorder(node, .right))
        }

        set {
            YGNodeStyleSetBorder(node, .right, YGFloat(newValue))
        }
    }

    var borderBottomWidth: CGFloat {
        get {
            return CGFloat(YGNodeStyleGetBorder(node, .bottom))
        }

        set {
            YGNodeStyleSetBorder(node, .bottom, YGFloat(newValue))
        }
    }

    var borderStartWidth: CGFloat {
        get {
            return CGFloat(YGNodeStyleGetBorder(node, .start))
        }

        set {
            YGNodeStyleSetBorder(node, .start, YGFloat(newValue))
        }
    }

    var borderEndWidth: CGFloat {
        get {
            return CGFloat(YGNodeStyleGetBorder(node, .end))
        }

        set {
            YGNodeStyleSetBorder(node, .end, YGFloat(newValue))
        }
    }

    var borderWidth: CGFloat {
        get {
            return CGFloat(YGNodeStyleGetBorder(node, .all))
        }

        set {
            YGNodeStyleSetBorder(node, .all, YGFloat(newValue))
        }
    }

    var width: YGValue {
        get {
            return YGNodeStyleGetWidth(node)
        }

        set {
            switch newValue.unit {
            case .percent:
                YGNodeStyleSetWidthPercent(node, newValue.value)
            case .point:
                YGNodeStyleSetWidth(node, newValue.value)
            case .auto:
                YGNodeStyleSetWidthAuto(node)
            default:
                break
            }
        }
    }

    var height: YGValue {
        get {
            return YGNodeStyleGetHeight(node)
        }

        set {
            switch newValue.unit {
            case .percent:
                YGNodeStyleSetHeightPercent(node, newValue.value)
            case .point:
                YGNodeStyleSetHeight(node, newValue.value)
            case .auto:
                YGNodeStyleSetHeightAuto(node)
            default:
                break
            }
        }
    }

    var minWidth: YGValue {
        get {
            return YGNodeStyleGetMinWidth(node)
        }

        set {
            switch newValue.unit {
            case .percent:
                YGNodeStyleSetMinWidthPercent(node, newValue.value)
            case .point:
                YGNodeStyleSetMinWidth(node, newValue.value)
            default:
                break
            }
        }
    }

    var minHeight: YGValue {
        get {
            return YGNodeStyleGetMinHeight(node)
        }

        set {
            switch newValue.unit {
            case .percent:
                YGNodeStyleSetMinHeightPercent(node, newValue.value)
            case .point:
                YGNodeStyleSetMinHeight(node, newValue.value)
            default:
                break
            }
        }
    }

    var maxWidth: YGValue {
        get {
            return YGNodeStyleGetMaxWidth(node)
        }

        set {
            switch newValue.unit {
            case .percent:
                YGNodeStyleSetMaxWidthPercent(node, newValue.value)
            case .point:
                YGNodeStyleSetMaxWidth(node, newValue.value)
            default:
                break
            }
        }
    }

    var maxHeight: YGValue {
        get {
            return YGNodeStyleGetMaxHeight(node)
        }

        set {
            switch newValue.unit {
            case .percent:
                YGNodeStyleSetMaxHeightPercent(node, newValue.value)
            case .point:
                YGNodeStyleSetMaxHeight(node, newValue.value)
            default:
                break
            }
        }
    }

    // Yoga specific properties, not compatible with flexbox specification
    var aspectRatio: CGFloat {
        get {
            return CGFloat(YGNodeStyleGetAspectRatio(node))
        }

        set {
            YGNodeStyleSetAspectRatio(node, YGFloat(newValue))
        }
    }
}
