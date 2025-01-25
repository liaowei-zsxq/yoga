/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#pragma once

#include <yoga/algorithm/SizingMode.h>
#include <yoga/config/Config.h>

namespace facebook::yoga {

bool canUseCachedMeasurement(
    SizingMode widthMode,
    double availableWidth,
    SizingMode heightMode,
    double availableHeight,
    SizingMode lastWidthMode,
    double lastAvailableWidth,
    SizingMode lastHeightMode,
    double lastAvailableHeight,
    double lastComputedWidth,
    double lastComputedHeight,
    double marginRow,
    double marginColumn,
    const yoga::Config* config);

} // namespace facebook::yoga
