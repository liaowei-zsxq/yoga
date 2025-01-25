/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#pragma once

#include <array>

#include <yoga/debug/AssertFatal.h>
#include <yoga/enums/Dimension.h>
#include <yoga/enums/Direction.h>
#include <yoga/enums/Edge.h>
#include <yoga/enums/PhysicalEdge.h>
#include <yoga/node/CachedMeasurement.h>
#include <yoga/numeric/FloatOptional.h>

namespace facebook::yoga {

struct LayoutResults {
  // This value was chosen based on empirical data:
  // 98% of analyzed layouts require less than 8 entries.
  static constexpr int32_t MaxCachedMeasurements = 8;

  uint32_t computedFlexBasisGeneration = 0;
  FloatOptional computedFlexBasis = {};

  // Instead of recomputing the entire layout every single time, we cache some
  // information to break early when nothing changed
  uint32_t generationCount = 0;
  uint32_t configVersion = 0;
  Direction lastOwnerDirection = Direction::Inherit;

  uint32_t nextCachedMeasurementsIndex = 0;
  std::array<CachedMeasurement, MaxCachedMeasurements> cachedMeasurements = {};

  CachedMeasurement cachedLayout{};

  Direction direction() const {
    return direction_;
  }

  void setDirection(Direction direction) {
    direction_ = direction;
  }

  bool hadOverflow() const {
    return hadOverflow_;
  }

  void setHadOverflow(bool hadOverflow) {
    hadOverflow_ = hadOverflow;
  }

  double dimension(Dimension axis) const {
    return dimensions_[yoga::to_underlying(axis)];
  }

  void setDimension(Dimension axis, double dimension) {
    dimensions_[yoga::to_underlying(axis)] = dimension;
  }

  double measuredDimension(Dimension axis) const {
    return measuredDimensions_[yoga::to_underlying(axis)];
  }

  void setMeasuredDimension(Dimension axis, double dimension) {
    measuredDimensions_[yoga::to_underlying(axis)] = dimension;
  }

  double position(PhysicalEdge physicalEdge) const {
    return position_[yoga::to_underlying(physicalEdge)];
  }

  void setPosition(PhysicalEdge physicalEdge, double dimension) {
    position_[yoga::to_underlying(physicalEdge)] = dimension;
  }

  double margin(PhysicalEdge physicalEdge) const {
    return margin_[yoga::to_underlying(physicalEdge)];
  }

  void setMargin(PhysicalEdge physicalEdge, double dimension) {
    margin_[yoga::to_underlying(physicalEdge)] = dimension;
  }

  double border(PhysicalEdge physicalEdge) const {
    return border_[yoga::to_underlying(physicalEdge)];
  }

  void setBorder(PhysicalEdge physicalEdge, double dimension) {
    border_[yoga::to_underlying(physicalEdge)] = dimension;
  }

  double padding(PhysicalEdge physicalEdge) const {
    return padding_[yoga::to_underlying(physicalEdge)];
  }

  void setPadding(PhysicalEdge physicalEdge, double dimension) {
    padding_[yoga::to_underlying(physicalEdge)] = dimension;
  }

  bool operator==(LayoutResults layout) const;
  bool operator!=(LayoutResults layout) const {
    return !(*this == layout);
  }

 private:
  Direction direction_ : bitCount<Direction>() = Direction::Inherit;
  bool hadOverflow_ : 1 = false;

  std::array<double, 2> dimensions_ = {{YGUndefined, YGUndefined}};
  std::array<double, 2> measuredDimensions_ = {{YGUndefined, YGUndefined}};
  std::array<double, 4> position_ = {};
  std::array<double, 4> margin_ = {};
  std::array<double, 4> border_ = {};
  std::array<double, 4> padding_ = {};
};

} // namespace facebook::yoga
