/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#include <yoga/Yoga.h>
#include <yoga/debug/AssertFatal.h>
#include <yoga/enums/Edge.h>
#include <yoga/node/Node.h>

using namespace facebook;
using namespace facebook::yoga;

namespace {

template <auto LayoutMember>
double getResolvedLayoutProperty(const YGNodeConstRef nodeRef, const Edge edge) {
  const auto node = resolveRef(nodeRef);
  yoga::assertFatalWithNode(
      node,
      edge <= Edge::End,
      "Cannot get layout properties of multi-edge shorthands");

  if (edge == Edge::Start) {
    if (node->getLayout().direction() == Direction::RTL) {
      return (node->getLayout().*LayoutMember)(PhysicalEdge::Right);
    } else {
      return (node->getLayout().*LayoutMember)(PhysicalEdge::Left);
    }
  }

  if (edge == Edge::End) {
    if (node->getLayout().direction() == Direction::RTL) {
      return (node->getLayout().*LayoutMember)(PhysicalEdge::Left);
    } else {
      return (node->getLayout().*LayoutMember)(PhysicalEdge::Right);
    }
  }

  return (node->getLayout().*LayoutMember)(static_cast<PhysicalEdge>(edge));
}

} // namespace

double YGNodeLayoutGetLeft(const YGNodeConstRef node) {
  return resolveRef(node)->getLayout().position(PhysicalEdge::Left);
}

double YGNodeLayoutGetTop(const YGNodeConstRef node) {
  return resolveRef(node)->getLayout().position(PhysicalEdge::Top);
}

double YGNodeLayoutGetRight(const YGNodeConstRef node) {
  return resolveRef(node)->getLayout().position(PhysicalEdge::Right);
}

double YGNodeLayoutGetBottom(const YGNodeConstRef node) {
  return resolveRef(node)->getLayout().position(PhysicalEdge::Bottom);
}

double YGNodeLayoutGetWidth(const YGNodeConstRef node) {
  return resolveRef(node)->getLayout().dimension(Dimension::Width);
}

double YGNodeLayoutGetHeight(const YGNodeConstRef node) {
  return resolveRef(node)->getLayout().dimension(Dimension::Height);
}

YGDirection YGNodeLayoutGetDirection(const YGNodeConstRef node) {
  return unscopedEnum(resolveRef(node)->getLayout().direction());
}

bool YGNodeLayoutGetHadOverflow(const YGNodeConstRef node) {
  return resolveRef(node)->getLayout().hadOverflow();
}

double YGNodeLayoutGetMargin(YGNodeConstRef node, YGEdge edge) {
  return getResolvedLayoutProperty<&LayoutResults::margin>(
      node, scopedEnum(edge));
}

double YGNodeLayoutGetBorder(YGNodeConstRef node, YGEdge edge) {
  return getResolvedLayoutProperty<&LayoutResults::border>(
      node, scopedEnum(edge));
}

double YGNodeLayoutGetPadding(YGNodeConstRef node, YGEdge edge) {
  return getResolvedLayoutProperty<&LayoutResults::padding>(
      node, scopedEnum(edge));
}
