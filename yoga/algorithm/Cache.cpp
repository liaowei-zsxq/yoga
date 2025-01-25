/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#include <yoga/algorithm/Cache.h>
#include <yoga/algorithm/PixelGrid.h>
#include <yoga/numeric/Comparison.h>

namespace facebook::yoga {

static inline bool sizeIsExactAndMatchesOldMeasuredSize(
    SizingMode sizeMode,
    double size,
    double lastComputedSize) {
  return sizeMode == SizingMode::StretchFit &&
      yoga::inexactEquals(size, lastComputedSize);
}

static inline bool oldSizeIsMaxContentAndStillFits(
    SizingMode sizeMode,
    double size,
    SizingMode lastSizeMode,
    double lastComputedSize) {
  return sizeMode == SizingMode::FitContent &&
      lastSizeMode == SizingMode::MaxContent &&
      (size >= lastComputedSize || yoga::inexactEquals(size, lastComputedSize));
}

static inline bool newSizeIsStricterAndStillValid(
    SizingMode sizeMode,
    double size,
    SizingMode lastSizeMode,
    double lastSize,
    double lastComputedSize) {
  return lastSizeMode == SizingMode::FitContent &&
      sizeMode == SizingMode::FitContent && yoga::isDefined(lastSize) &&
      yoga::isDefined(size) && yoga::isDefined(lastComputedSize) &&
      lastSize > size &&
      (lastComputedSize <= size || yoga::inexactEquals(size, lastComputedSize));
}

bool canUseCachedMeasurement(
    const SizingMode widthMode,
    const double availableWidth,
    const SizingMode heightMode,
    const double availableHeight,
    const SizingMode lastWidthMode,
    const double lastAvailableWidth,
    const SizingMode lastHeightMode,
    const double lastAvailableHeight,
    const double lastComputedWidth,
    const double lastComputedHeight,
    const double marginRow,
    const double marginColumn,
    const yoga::Config* const config) {
  if ((yoga::isDefined(lastComputedHeight) && lastComputedHeight < 0) ||
      ((yoga::isDefined(lastComputedWidth)) && lastComputedWidth < 0)) {
    return false;
  }

  const double pointScaleFactor = config->getPointScaleFactor();

  bool useRoundedComparison = config != nullptr && pointScaleFactor != 0;
  const double effectiveWidth = useRoundedComparison
      ? roundValueToPixelGrid(availableWidth, pointScaleFactor, false, false)
      : availableWidth;
  const double effectiveHeight = useRoundedComparison
      ? roundValueToPixelGrid(availableHeight, pointScaleFactor, false, false)
      : availableHeight;
  const double effectiveLastWidth = useRoundedComparison
      ? roundValueToPixelGrid(
            lastAvailableWidth, pointScaleFactor, false, false)
      : lastAvailableWidth;
  const double effectiveLastHeight = useRoundedComparison
      ? roundValueToPixelGrid(
            lastAvailableHeight, pointScaleFactor, false, false)
      : lastAvailableHeight;

  const bool hasSameWidthSpec = lastWidthMode == widthMode &&
      yoga::inexactEquals(effectiveLastWidth, effectiveWidth);
  const bool hasSameHeightSpec = lastHeightMode == heightMode &&
      yoga::inexactEquals(effectiveLastHeight, effectiveHeight);

  const bool widthIsCompatible =
      hasSameWidthSpec ||
      sizeIsExactAndMatchesOldMeasuredSize(
          widthMode, availableWidth - marginRow, lastComputedWidth) ||
      oldSizeIsMaxContentAndStillFits(
          widthMode,
          availableWidth - marginRow,
          lastWidthMode,
          lastComputedWidth) ||
      newSizeIsStricterAndStillValid(
          widthMode,
          availableWidth - marginRow,
          lastWidthMode,
          lastAvailableWidth,
          lastComputedWidth);

  const bool heightIsCompatible = hasSameHeightSpec ||
      sizeIsExactAndMatchesOldMeasuredSize(
                                      heightMode,
                                      availableHeight - marginColumn,
                                      lastComputedHeight) ||
      oldSizeIsMaxContentAndStillFits(heightMode,
                                      availableHeight - marginColumn,
                                      lastHeightMode,
                                      lastComputedHeight) ||
      newSizeIsStricterAndStillValid(heightMode,
                                     availableHeight - marginColumn,
                                     lastHeightMode,
                                     lastAvailableHeight,
                                     lastComputedHeight);

  return widthIsCompatible && heightIsCompatible;
}

} // namespace facebook::yoga
