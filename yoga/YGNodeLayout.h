/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#pragma once

#include <stdbool.h>

#include <yoga/YGConfig.h>
#include <yoga/YGEnums.h>
#include <yoga/YGMacros.h>

YG_EXTERN_C_BEGIN

YG_EXPORT double YGNodeLayoutGetLeft(YGNodeConstRef node);
YG_EXPORT double YGNodeLayoutGetTop(YGNodeConstRef node);
YG_EXPORT double YGNodeLayoutGetRight(YGNodeConstRef node);
YG_EXPORT double YGNodeLayoutGetBottom(YGNodeConstRef node);
YG_EXPORT double YGNodeLayoutGetWidth(YGNodeConstRef node);
YG_EXPORT double YGNodeLayoutGetHeight(YGNodeConstRef node);
YG_EXPORT YGDirection YGNodeLayoutGetDirection(YGNodeConstRef node);
YG_EXPORT bool YGNodeLayoutGetHadOverflow(YGNodeConstRef node);

// Get the computed values for these nodes after performing layout. If they were
// set using point values then the returned value will be the same as
// YGNodeStyleGetXXX. However if they were set using a percentage value then the
// returned value is the computed value used during layout.
YG_EXPORT double YGNodeLayoutGetMargin(YGNodeConstRef node, YGEdge edge);
YG_EXPORT double YGNodeLayoutGetBorder(YGNodeConstRef node, YGEdge edge);
YG_EXPORT double YGNodeLayoutGetPadding(YGNodeConstRef node, YGEdge edge);

YG_EXTERN_C_END
