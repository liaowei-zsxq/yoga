/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#pragma once

#include <stddef.h>

#include <yoga/YGNode.h>
#include <yoga/YGValue.h>

YG_EXTERN_C_BEGIN

YG_EXPORT void YGNodeCopyStyle(YGNodeRef dstNode, YGNodeConstRef srcNode);

YG_EXPORT void YGNodeStyleSetDirection(YGNodeRef node, YGDirection direction);
YG_EXPORT YGDirection YGNodeStyleGetDirection(YGNodeConstRef node);

YG_EXPORT void YGNodeStyleSetFlexDirection(
    YGNodeRef node,
    YGFlexDirection flexDirection);
YG_EXPORT YGFlexDirection YGNodeStyleGetFlexDirection(YGNodeConstRef node);

YG_EXPORT void YGNodeStyleSetJustifyContent(
    YGNodeRef node,
    YGJustify justifyContent);
YG_EXPORT YGJustify YGNodeStyleGetJustifyContent(YGNodeConstRef node);

YG_EXPORT void YGNodeStyleSetAlignContent(YGNodeRef node, YGAlign alignContent);
YG_EXPORT YGAlign YGNodeStyleGetAlignContent(YGNodeConstRef node);

YG_EXPORT void YGNodeStyleSetAlignItems(YGNodeRef node, YGAlign alignItems);
YG_EXPORT YGAlign YGNodeStyleGetAlignItems(YGNodeConstRef node);

YG_EXPORT void YGNodeStyleSetAlignSelf(YGNodeRef node, YGAlign alignSelf);
YG_EXPORT YGAlign YGNodeStyleGetAlignSelf(YGNodeConstRef node);

YG_EXPORT void YGNodeStyleSetPositionType(
    YGNodeRef node,
    YGPositionType positionType);
YG_EXPORT YGPositionType YGNodeStyleGetPositionType(YGNodeConstRef node);

YG_EXPORT void YGNodeStyleSetFlexWrap(YGNodeRef node, YGWrap flexWrap);
YG_EXPORT YGWrap YGNodeStyleGetFlexWrap(YGNodeConstRef node);

YG_EXPORT void YGNodeStyleSetOverflow(YGNodeRef node, YGOverflow overflow);
YG_EXPORT YGOverflow YGNodeStyleGetOverflow(YGNodeConstRef node);

YG_EXPORT void YGNodeStyleSetDisplay(YGNodeRef node, YGDisplay display);
YG_EXPORT YGDisplay YGNodeStyleGetDisplay(YGNodeConstRef node);

YG_EXPORT void YGNodeStyleSetFlex(YGNodeRef node, double flex);
YG_EXPORT double YGNodeStyleGetFlex(YGNodeConstRef node);

YG_EXPORT void YGNodeStyleSetFlexGrow(YGNodeRef node, double flexGrow);
YG_EXPORT double YGNodeStyleGetFlexGrow(YGNodeConstRef node);

YG_EXPORT void YGNodeStyleSetFlexShrink(YGNodeRef node, double flexShrink);
YG_EXPORT double YGNodeStyleGetFlexShrink(YGNodeConstRef node);

YG_EXPORT void YGNodeStyleSetFlexBasis(YGNodeRef node, double flexBasis);
YG_EXPORT void YGNodeStyleSetFlexBasisPercent(YGNodeRef node, double flexBasis);
YG_EXPORT void YGNodeStyleSetFlexBasisAuto(YGNodeRef node);
YG_EXPORT void YGNodeStyleSetFlexBasisMaxContent(YGNodeRef node);
YG_EXPORT void YGNodeStyleSetFlexBasisFitContent(YGNodeRef node);
YG_EXPORT void YGNodeStyleSetFlexBasisStretch(YGNodeRef node);
YG_EXPORT YGValue YGNodeStyleGetFlexBasis(YGNodeConstRef node);

YG_EXPORT void
YGNodeStyleSetPosition(YGNodeRef node, YGEdge edge, double position);
YG_EXPORT void
YGNodeStyleSetPositionPercent(YGNodeRef node, YGEdge edge, double position);
YG_EXPORT YGValue YGNodeStyleGetPosition(YGNodeConstRef node, YGEdge edge);
YG_EXPORT void YGNodeStyleSetPositionAuto(YGNodeRef node, YGEdge edge);

YG_EXPORT
void YGNodeStyleSetMargin(YGNodeRef node, YGEdge edge, double margin);
YG_EXPORT void
YGNodeStyleSetMarginPercent(YGNodeRef node, YGEdge edge, double margin);
YG_EXPORT void YGNodeStyleSetMarginAuto(YGNodeRef node, YGEdge edge);
YG_EXPORT YGValue YGNodeStyleGetMargin(YGNodeConstRef node, YGEdge edge);

YG_EXPORT void
YGNodeStyleSetPadding(YGNodeRef node, YGEdge edge, double padding);
YG_EXPORT void
YGNodeStyleSetPaddingPercent(YGNodeRef node, YGEdge edge, double padding);
YG_EXPORT YGValue YGNodeStyleGetPadding(YGNodeConstRef node, YGEdge edge);

YG_EXPORT void YGNodeStyleSetBorder(YGNodeRef node, YGEdge edge, double border);
YG_EXPORT double YGNodeStyleGetBorder(YGNodeConstRef node, YGEdge edge);

YG_EXPORT void
YGNodeStyleSetGap(YGNodeRef node, YGGutter gutter, double gapLength);
YG_EXPORT void
YGNodeStyleSetGapPercent(YGNodeRef node, YGGutter gutter, double gapLength);
YG_EXPORT YGValue YGNodeStyleGetGap(YGNodeConstRef node, YGGutter gutter);

YG_EXPORT void YGNodeStyleSetBoxSizing(YGNodeRef node, YGBoxSizing boxSizing);
YG_EXPORT YGBoxSizing YGNodeStyleGetBoxSizing(YGNodeConstRef node);

YG_EXPORT void YGNodeStyleSetWidth(YGNodeRef node, double width);
YG_EXPORT void YGNodeStyleSetWidthPercent(YGNodeRef node, double width);
YG_EXPORT void YGNodeStyleSetWidthAuto(YGNodeRef node);
YG_EXPORT void YGNodeStyleSetWidthMaxContent(YGNodeRef node);
YG_EXPORT void YGNodeStyleSetWidthFitContent(YGNodeRef node);
YG_EXPORT void YGNodeStyleSetWidthStretch(YGNodeRef node);
YG_EXPORT YGValue YGNodeStyleGetWidth(YGNodeConstRef node);

YG_EXPORT void YGNodeStyleSetHeight(YGNodeRef node, double height);
YG_EXPORT void YGNodeStyleSetHeightPercent(YGNodeRef node, double height);
YG_EXPORT void YGNodeStyleSetHeightAuto(YGNodeRef node);
YG_EXPORT void YGNodeStyleSetHeightMaxContent(YGNodeRef node);
YG_EXPORT void YGNodeStyleSetHeightFitContent(YGNodeRef node);
YG_EXPORT void YGNodeStyleSetHeightStretch(YGNodeRef node);
YG_EXPORT YGValue YGNodeStyleGetHeight(YGNodeConstRef node);

YG_EXPORT void YGNodeStyleSetMinWidth(YGNodeRef node, double minWidth);
YG_EXPORT void YGNodeStyleSetMinWidthPercent(YGNodeRef node, double minWidth);
YG_EXPORT void YGNodeStyleSetMinWidthMaxContent(YGNodeRef node);
YG_EXPORT void YGNodeStyleSetMinWidthFitContent(YGNodeRef node);
YG_EXPORT void YGNodeStyleSetMinWidthStretch(YGNodeRef node);
YG_EXPORT YGValue YGNodeStyleGetMinWidth(YGNodeConstRef node);

YG_EXPORT void YGNodeStyleSetMinHeight(YGNodeRef node, double minHeight);
YG_EXPORT void YGNodeStyleSetMinHeightPercent(YGNodeRef node, double minHeight);
YG_EXPORT void YGNodeStyleSetMinHeightMaxContent(YGNodeRef node);
YG_EXPORT void YGNodeStyleSetMinHeightFitContent(YGNodeRef node);
YG_EXPORT void YGNodeStyleSetMinHeightStretch(YGNodeRef node);
YG_EXPORT YGValue YGNodeStyleGetMinHeight(YGNodeConstRef node);

YG_EXPORT void YGNodeStyleSetMaxWidth(YGNodeRef node, double maxWidth);
YG_EXPORT void YGNodeStyleSetMaxWidthPercent(YGNodeRef node, double maxWidth);
YG_EXPORT void YGNodeStyleSetMaxWidthMaxContent(YGNodeRef node);
YG_EXPORT void YGNodeStyleSetMaxWidthFitContent(YGNodeRef node);
YG_EXPORT void YGNodeStyleSetMaxWidthStretch(YGNodeRef node);
YG_EXPORT YGValue YGNodeStyleGetMaxWidth(YGNodeConstRef node);

YG_EXPORT void YGNodeStyleSetMaxHeight(YGNodeRef node, double maxHeight);
YG_EXPORT void YGNodeStyleSetMaxHeightPercent(YGNodeRef node, double maxHeight);
YG_EXPORT void YGNodeStyleSetMaxHeightMaxContent(YGNodeRef node);
YG_EXPORT void YGNodeStyleSetMaxHeightFitContent(YGNodeRef node);
YG_EXPORT void YGNodeStyleSetMaxHeightStretch(YGNodeRef node);
YG_EXPORT YGValue YGNodeStyleGetMaxHeight(YGNodeConstRef node);

YG_EXPORT void YGNodeStyleSetAspectRatio(YGNodeRef node, double aspectRatio);
YG_EXPORT double YGNodeStyleGetAspectRatio(YGNodeConstRef node);

YG_EXTERN_C_END
