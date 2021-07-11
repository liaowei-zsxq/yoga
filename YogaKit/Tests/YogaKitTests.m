/*
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import <XCTest/XCTest.h>

@import YogaKit;

#if TARGET_OS_OSX

#ifdef UIView
#undef UIView
#endif

#ifdef UIControl
#undef UIControl
#endif

@interface NSView (Exchange)

- (void)exchangeSubviewAtIndex:(NSInteger)index1
            withSubviewAtIndex:(NSInteger)index2;

@end

@implementation NSView (Exchange)

- (void)exchangeSubviewAtIndex:(NSInteger)index1
            withSubviewAtIndex:(NSInteger)index2 {
  NSInteger count = self.subviews.count;
  if (index1 >= count || index2 >= count || index1 == index2) {
    return;;
  }

  NSInteger subview1Index = MIN(index1, index2);
  NSInteger subview2Index = MAX(index1, index2);
  NSView *subview1 = self.subviews[subview1Index];
  NSView *subview2 = self.subviews[subview2Index];
  [self addSubview:subview1 positioned:NSWindowAbove relativeTo:self.subviews[subview2Index - 1]];
  [self addSubview:subview2 positioned:NSWindowBelow relativeTo:self.subviews[subview1Index + 1]];
}

@end

@interface NSFlippedView : NSView

@end

@implementation NSFlippedView

- (BOOL)isFlipped {
  return YES;
}

@end

@interface NSFlippedControl : NSControl

@end

@implementation NSFlippedControl

- (BOOL)isFlipped {
  return YES;
}

@end

#define UIView NSFlippedView
#define UIControl NSFlippedControl
#define kScaleFactor NSScreen.mainScreen.backingScaleFactor
#else
#define kScaleFactor UIScreen.mainScreen.scale
#endif

@interface YogaKitTests : XCTestCase
@end

@implementation YogaKitTests

- (void)testConfigureLayoutIsNoOpWithNilBlock {
  UIView* view = [[UIView alloc] initWithFrame:CGRectZero];
  id block = nil;
  XCTAssertNoThrow([view.yoga configureLayoutWithBlock:block]);
}

- (void)testConfigureLayoutBlockWorksWithValidBlock {
  UIView* view = [[UIView alloc] initWithFrame:CGRectZero];
  [view.yoga configureLayoutWithBlock:^(YGLayout* layout) {
    XCTAssertNotNil(layout);
    layout.width = YGPointValue(25);
  }];

  XCTAssertTrue(view.yoga.isIncludedInLayout);
  XCTAssertEqual(view.yoga.width.value, 25);
}

- (void)testNodesAreDeallocedWithSingleView {
  __weak YGLayout* layoutRef = nil;

  @autoreleasepool {
    UIView* view = [[UIView alloc] initWithFrame:CGRectZero];
    view.yoga.flexBasis = YGPointValue(1);

    layoutRef = view.yoga;
    XCTAssertNotNil(layoutRef);

    view = nil;
  }

  XCTAssertNil(layoutRef);
}

- (void)testNodesAreDeallocedCascade {
  __weak YGLayout* topLayout = nil;
  __weak YGLayout* subviewLayout = nil;

  @autoreleasepool {
    UIView* view = [[UIView alloc] initWithFrame:CGRectZero];
    topLayout = view.yoga;
    topLayout.flexBasis = YGPointValue(1);

    UIView* subview = [[UIView alloc] initWithFrame:CGRectZero];
    subviewLayout = subview.yoga;
    subviewLayout.flexBasis = YGPointValue(1);

    view = nil;
  }

  XCTAssertNil(topLayout);
  XCTAssertNil(subviewLayout);
}

- (void)testIsEnabled {
  UIView* view = [[UIView alloc] initWithFrame:CGRectZero];
  XCTAssertTrue(view.yoga.isIncludedInLayout);

  view.yoga.isIncludedInLayout = NO;
  XCTAssertFalse(view.yoga.isIncludedInLayout);

  view.yoga.isIncludedInLayout = YES;
  XCTAssertTrue(view.yoga.isIncludedInLayout);
}

- (void)testSizeThatFitsAsserts {
  UIView* view = [[UIView alloc] initWithFrame:CGRectZero];
  dispatch_group_t group = dispatch_group_create();
  dispatch_group_async(group, dispatch_queue_create("com.facebook.Yoga.testing", DISPATCH_QUEUE_CONCURRENT), ^(void) {
    XCTAssertThrows(view.yoga.intrinsicSize);
  });
  dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
}

#if !TARGET_OS_OSX
- (void)testSizeThatFitsSmoke {
  UIView* container = [[UIView alloc] initWithFrame:CGRectZero];
  container.yoga.flexDirection = YGFlexDirectionRow;
  container.yoga.alignItems = YGAlignFlexStart;

  UILabel* longTextLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  longTextLabel.text = @"This is a very very very very very very very very long piece of text.";
  longTextLabel.lineBreakMode = NSLineBreakByTruncatingTail;
  longTextLabel.numberOfLines = 1;
  longTextLabel.yoga.flexShrink = 1;
  [container addSubview:longTextLabel];

  UIView* textBadgeView = [[UIView alloc] initWithFrame:CGRectZero];
  textBadgeView.yoga.margin = YGPointValue(0);
  textBadgeView.yoga.width = YGPointValue(10);
  textBadgeView.yoga.height = YGPointValue(10);
  [container addSubview:textBadgeView];

  const CGSize textBadgeViewSize = textBadgeView.yoga.intrinsicSize;
  XCTAssertEqual(textBadgeViewSize.height, 10);
  XCTAssertEqual(textBadgeViewSize.width, 10);

  const CGSize containerSize = container.yoga.intrinsicSize;
  const CGSize longTextLabelSize = longTextLabel.yoga.intrinsicSize;

  XCTAssertEqual(longTextLabelSize.height, containerSize.height);
  XCTAssertEqual(longTextLabelSize.width + textBadgeView.yoga.intrinsicSize.width,
                 containerSize.width);
}
#endif

- (void)testSizeThatFitsEmptyView {
  UIView* view = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 200, 200)];
  view.yoga.isIncludedInLayout = YES;

  const CGSize viewSize = view.yoga.intrinsicSize;
  XCTAssertEqual(viewSize.height, 0);
  XCTAssertEqual(viewSize.width, 0);
}

- (void)testPreservingOrigin {
  UIView* container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 75)];
  container.yoga.isIncludedInLayout = YES;

  UIView* view = [[UIView alloc] initWithFrame:CGRectZero];
  view.yoga.isIncludedInLayout = YES;
  view.yoga.flexBasis = YGPointValue(0);
  view.yoga.flexGrow = 1;
  [container addSubview:view];

  UIView* view2 = [[UIView alloc] initWithFrame:CGRectZero];
  view2.yoga.isIncludedInLayout = YES;
  view2.yoga.marginTop = YGPointValue(25);
  view2.yoga.flexBasis = YGPointValue(0);
  view2.yoga.flexGrow = 1;
  [container addSubview:view2];

  [container.yoga applyLayoutPreservingOrigin:YES];
  XCTAssertEqual(50, view2.frame.origin.y);

  [view2.yoga applyLayoutPreservingOrigin:NO];
  XCTAssertEqual(25, view2.frame.origin.y);
}

- (void)testContainerWithFlexibleWidthGetsCorrectlySized {
  UIView* container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
  container.yoga.isIncludedInLayout = YES;

  UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
  view.yoga.isIncludedInLayout = YES;
  view.yoga.width = YGPointValue(100);
  view.yoga.height = YGPointValue(100);
  [container addSubview:view];

  [container.yoga
   applyLayoutPreservingOrigin:YES
   dimensionFlexibility:YGDimensionFlexibilityFlexibleWidth];
  XCTAssertEqual(100, container.frame.size.width);
  XCTAssertEqual(200, container.frame.size.height);
}

- (void)testContainerWithFlexibleHeightGetsCorrectlySized {
  UIView* container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
  container.yoga.isIncludedInLayout = YES;

  UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
  view.yoga.isIncludedInLayout = YES;
  view.yoga.width = YGPointValue(100);
  view.yoga.height = YGPointValue(100);
  [container addSubview:view];

  [container.yoga
   applyLayoutPreservingOrigin:YES
   dimensionFlexibility:YGDimensionFlexibilityFlexibleHeight];
  XCTAssertEqual(200, container.frame.size.width);
  XCTAssertEqual(100, container.frame.size.height);
}

- (void)testContainerWithFlexibleWidthAndHeightGetsCorrectlySized {
  UIView* container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
  container.yoga.isIncludedInLayout = YES;

  UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
  view.yoga.isIncludedInLayout = YES;
  view.yoga.width = YGPointValue(100);
  view.yoga.height = YGPointValue(100);
  [container addSubview:view];

  [container.yoga
   applyLayoutPreservingOrigin:YES
   dimensionFlexibility:YGDimensionFlexibilityFlexibleWidth |
   YGDimensionFlexibilityFlexibleHeight];
  XCTAssertEqual(100, container.frame.size.width);
  XCTAssertEqual(100, container.frame.size.height);
}

- (void)testMarkingDirtyOnlyWorksOnLeafNodes {
  UIView* container = [[UIView alloc] initWithFrame:CGRectZero];
  container.yoga.isIncludedInLayout = YES;

  UIView* subview = [[UIView alloc] initWithFrame:CGRectZero];
  subview.yoga.isIncludedInLayout = YES;
  [container addSubview:subview];

  XCTAssertFalse(container.yoga.isDirty);
  [container.yoga markDirty];
  XCTAssertFalse(container.yoga.isDirty);

  XCTAssertFalse(subview.yoga.isDirty);
  [subview.yoga markDirty];
  XCTAssertTrue(subview.yoga.isDirty);
}

#if !TARGET_OS_OSX
- (void)testThatMarkingLeafsAsDirtyWillTriggerASizeRecalculation {
  UIView* container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 500, 50)];
  container.yoga.isIncludedInLayout = YES;
  container.yoga.flexDirection = YGFlexDirectionRow;
  container.yoga.alignItems = YGAlignFlexStart;

  UILabel* view = [[UILabel alloc] initWithFrame:CGRectZero];
  view.text = @"This is a short text.";
  view.numberOfLines = 1;
  view.yoga.isIncludedInLayout = YES;
  [container addSubview:view];

  [container.yoga applyLayoutPreservingOrigin:YES];
  CGSize const viewSizeAfterFirstPass = view.frame.size;

  view.text = @"This is a slightly longer text.";
  XCTAssertTrue(CGSizeEqualToSize(view.frame.size, viewSizeAfterFirstPass));

  [view.yoga markDirty];

  [container.yoga applyLayoutPreservingOrigin:YES];
  XCTAssertFalse(CGSizeEqualToSize(view.frame.size, viewSizeAfterFirstPass));
}
#endif

- (void)testFrameAndOriginPlacement {
  const CGSize containerSize = CGSizeMake(330, 50);

  UIView* container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, containerSize.width, containerSize.height)];
  container.yoga.isIncludedInLayout = YES;
  container.yoga.flexDirection = YGFlexDirectionRow;

  UIView* subview1 = [[UIView alloc] initWithFrame:CGRectZero];
  subview1.yoga.isIncludedInLayout = YES;
  subview1.yoga.flexGrow = 1;
  [container addSubview:subview1];

  UIView* subview2 = [[UIView alloc] initWithFrame:CGRectZero];
  subview2.yoga.isIncludedInLayout = YES;
  subview2.yoga.flexGrow = 1;
  [container addSubview:subview2];

  UIView* subview3 = [[UIView alloc] initWithFrame:CGRectZero];
  subview3.yoga.isIncludedInLayout = YES;
  subview3.yoga.flexGrow = 1;
  [container addSubview:subview3];

  [container.yoga applyLayoutPreservingOrigin:YES];

  XCTAssertEqualWithAccuracy(subview2.frame.origin.x, CGRectGetMaxX(subview1.frame), FLT_EPSILON);
  XCTAssertEqualWithAccuracy(subview3.frame.origin.x, CGRectGetMaxX(subview2.frame), FLT_EPSILON);

  CGFloat totalWidth = 0;
  for (UIView* view in container.subviews) {
    totalWidth += view.bounds.size.width;
  }

  XCTAssertEqual(containerSize.width,
                 totalWidth,
                 @"The container's width is %.6f, the subviews take up %.6f",
                 containerSize.width,
                 totalWidth);
}

- (void)testThatLayoutIsCorrectWhenWeSwapViewOrder {
  const CGSize containerSize = CGSizeMake(300, 50);

  UIView* container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, containerSize.width, containerSize.height)];
  container.yoga.isIncludedInLayout = YES;
  container.yoga.flexDirection = YGFlexDirectionRow;

  UIView* subview1 = [[UIView alloc] initWithFrame:CGRectZero];
  subview1.yoga.isIncludedInLayout = YES;
  subview1.yoga.flexGrow = 1;
  [container addSubview:subview1];

  UIView* subview2 = [[UIView alloc] initWithFrame:CGRectZero];
  subview2.yoga.isIncludedInLayout = YES;
  subview2.yoga.flexGrow = 1;
  [container addSubview:subview2];

  UIView* subview3 = [[UIView alloc] initWithFrame:CGRectZero];
  subview3.yoga.isIncludedInLayout = YES;
  subview3.yoga.flexGrow = 1;
  [container addSubview:subview3];

  [container.yoga applyLayoutPreservingOrigin:YES];

  XCTAssertTrue(CGRectEqualToRect(subview1.frame, CGRectMake(0, 0, 100, 50)));
  XCTAssertTrue(CGRectEqualToRect(subview2.frame, CGRectMake(100, 0, 100, 50)));
  XCTAssertTrue(CGRectEqualToRect(subview3.frame, CGRectMake(200, 0, 100, 50)));

  [container exchangeSubviewAtIndex:2 withSubviewAtIndex:0];
  subview2.yoga.isIncludedInLayout = NO;
  [container.yoga applyLayoutPreservingOrigin:YES];

  XCTAssertTrue(CGRectEqualToRect(subview3.frame, CGRectMake(0, 0, 150, 50)));
  XCTAssertTrue(CGRectEqualToRect(subview1.frame, CGRectMake(150, 0, 150, 50)));

  // this frame shouldn't have been modified since last time.
  XCTAssertTrue(CGRectEqualToRect(subview2.frame, CGRectMake(100, 0, 100, 50)));
}

- (void)testThatWeRespectIncludeInLayoutFlag {
  const CGSize containerSize = CGSizeMake(300, 50);

  UIView* container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, containerSize.width, containerSize.height)];
  container.yoga.isIncludedInLayout = YES;
  container.yoga.flexDirection = YGFlexDirectionRow;

  UIView* subview1 = [[UIView alloc] initWithFrame:CGRectZero];
  subview1.yoga.isIncludedInLayout = YES;
  subview1.yoga.flexGrow = 1;
  [container addSubview:subview1];

  UIView* subview2 = [[UIView alloc] initWithFrame:CGRectZero];
  subview2.yoga.isIncludedInLayout = YES;
  subview2.yoga.flexGrow = 1;
  [container addSubview:subview2];

  UIView* subview3 = [[UIView alloc] initWithFrame:CGRectZero];
  subview3.yoga.isIncludedInLayout = YES;
  subview3.yoga.flexGrow = 1;
  [container addSubview:subview3];

  [container.yoga applyLayoutPreservingOrigin:YES];

  for (UIView* subview in container.subviews) {
    XCTAssertEqual(subview.bounds.size.width, 100);
  }

  subview3.yoga.isIncludedInLayout = NO;
  [container.yoga applyLayoutPreservingOrigin:YES];

  XCTAssertEqual(subview1.bounds.size.width, 150);
  XCTAssertEqual(subview2.bounds.size.width, 150);

  // We don't set the frame to zero, so, it should be set to what it was
  // previously at.
  XCTAssertEqual(subview3.bounds.size.width, 100);
}

- (void)testThatNumberOfChildrenIsCorrectWhenWeIgnoreSubviews {
  UIView* container = [[UIView alloc] initWithFrame:CGRectZero];
  container.yoga.isIncludedInLayout = YES;
  container.yoga.flexDirection = YGFlexDirectionRow;

  UIView* subview1 = [[UIView alloc] initWithFrame:CGRectZero];
  subview1.yoga.isIncludedInLayout = NO;
  [container addSubview:subview1];

  UIView* subview2 = [[UIView alloc] initWithFrame:CGRectZero];
  subview2.yoga.isIncludedInLayout = NO;
  [container addSubview:subview2];

  UIView* subview3 = [[UIView alloc] initWithFrame:CGRectZero];
  subview3.yoga.isIncludedInLayout = YES;
  [container addSubview:subview3];

  [container.yoga applyLayoutPreservingOrigin:YES];
  XCTAssertEqual(container.yoga.numberOfChildren, 1);

  subview2.yoga.isIncludedInLayout = YES;
  [container.yoga applyLayoutPreservingOrigin:YES];
  XCTAssertEqual(container.yoga.numberOfChildren, 2);
}

- (void)testThatViewNotIncludedInFirstLayoutPassAreIncludedInSecond {
  UIView* container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
  container.yoga.isIncludedInLayout = YES;
  container.yoga.flexDirection = YGFlexDirectionRow;

  UIView* subview1 = [[UIView alloc] initWithFrame:CGRectZero];
  subview1.yoga.isIncludedInLayout = YES;
  subview1.yoga.flexGrow = 1;
  [container addSubview:subview1];

  UIView* subview2 = [[UIView alloc] initWithFrame:CGRectZero];
  subview2.yoga.isIncludedInLayout = YES;
  subview2.yoga.flexGrow = 1;
  [container addSubview:subview2];

  UIView* subview3 = [[UIView alloc] initWithFrame:CGRectZero];
  subview3.yoga.isIncludedInLayout = YES;
  subview3.yoga.flexGrow = 1;
  subview3.yoga.isIncludedInLayout = NO;
  [container addSubview:subview3];

  [container.yoga applyLayoutPreservingOrigin:YES];

  XCTAssertEqual(subview1.bounds.size.width, 150);
  XCTAssertEqual(subview2.bounds.size.width, 150);
  XCTAssertEqual(subview3.bounds.size.width, 0);

  subview3.yoga.isIncludedInLayout = YES;
  [container.yoga applyLayoutPreservingOrigin:YES];

  XCTAssertEqual(subview1.bounds.size.width, 100);
  XCTAssertEqual(subview2.bounds.size.width, 100);
  XCTAssertEqual(subview3.bounds.size.width, 100);
}

- (void)testIsLeafFlag {
  UIView* view = [[UIView alloc] initWithFrame:CGRectZero];
  XCTAssertTrue(view.yoga.isLeaf);

  for (int i = 0; i < 10; i++) {
    UIView* subview = [[UIView alloc] initWithFrame:CGRectZero];
    [view addSubview:subview];
  }
  XCTAssertTrue(view.yoga.isLeaf);

  view.yoga.isIncludedInLayout = YES;
  view.yoga.width = YGPointValue(50);
  XCTAssertTrue(view.yoga.isLeaf);

  UIView* const subview = view.subviews[0];
  subview.yoga.isIncludedInLayout = YES;
  subview.yoga.width = YGPointValue(50);
  XCTAssertFalse(view.yoga.isLeaf);
}

- (void)testThatWeCorrectlyAttachNestedViews {
  UIView* container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
  container.yoga.isIncludedInLayout = YES;
  container.yoga.flexDirection = YGFlexDirectionColumn;

  UIView* subview1 = [[UIView alloc] initWithFrame:CGRectZero];
  subview1.yoga.isIncludedInLayout = YES;
  subview1.yoga.width = YGPointValue(100);
  subview1.yoga.flexGrow = 1;
  subview1.yoga.flexDirection = YGFlexDirectionColumn;
  [container addSubview:subview1];

  UIView* subview2 = [[UIView alloc] initWithFrame:CGRectZero];
  subview2.yoga.isIncludedInLayout = YES;
  subview2.yoga.width = YGPointValue(150);
  subview2.yoga.flexGrow = 1;
  subview2.yoga.flexDirection = YGFlexDirectionColumn;
  [container addSubview:subview2];

  for (UIView* view in @[ subview1, subview2 ]) {
    UIView* someView = [[UIView alloc] initWithFrame:CGRectZero];
    someView.yoga.isIncludedInLayout = YES;
    someView.yoga.flexGrow = 1;
    [view addSubview:someView];
  }
  [container.yoga applyLayoutPreservingOrigin:YES];

  // Add the same amount of new views, reapply layout.
  for (UIView* view in @[ subview1, subview2 ]) {
    UIView* someView = [[UIView alloc] initWithFrame:CGRectZero];
    someView.yoga.isIncludedInLayout = YES;
    someView.yoga.flexGrow = 1;
    [view addSubview:someView];
  }
  [container.yoga applyLayoutPreservingOrigin:YES];

  XCTAssertEqual(subview1.bounds.size.width, 100);
  XCTAssertEqual(subview1.bounds.size.height, 25);
  for (UIView* subview in subview1.subviews) {
    const CGSize subviewSize = subview.bounds.size;
    XCTAssertNotEqual(subviewSize.width, 0);
    XCTAssertNotEqual(subviewSize.height, 0);
    XCTAssertFalse(isnan(subviewSize.height));
    XCTAssertFalse(isnan(subviewSize.width));
  }

  XCTAssertEqual(subview2.bounds.size.width, 150);
  XCTAssertEqual(subview2.bounds.size.height, 25);
  for (UIView* subview in subview2.subviews) {
    const CGSize subviewSize = subview.bounds.size;
    XCTAssertNotEqual(subviewSize.width, 0);
    XCTAssertNotEqual(subviewSize.height, 0);
    XCTAssertFalse(isnan(subviewSize.height));
    XCTAssertFalse(isnan(subviewSize.width));
  }
}

- (void)testThatANonLeafNodeCanBecomeALeafNode {
  UIView* container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
  container.yoga.isIncludedInLayout = YES;

  UIView* subview1 = [[UIView alloc] initWithFrame:CGRectZero];
  subview1.yoga.isIncludedInLayout = YES;
  [container addSubview:subview1];

  UIView* subview2 = [[UIView alloc] initWithFrame:CGRectZero];
  subview2.yoga.isIncludedInLayout = YES;
  [subview1 addSubview:subview2];

  [container.yoga applyLayoutPreservingOrigin:YES];
  XCTAssertTrue(!subview1.yoga.isLeaf && subview2.yoga.isLeaf);

  [subview2 removeFromSuperview];
  [container.yoga applyLayoutPreservingOrigin:YES];
  XCTAssertTrue(subview1.yoga.isLeaf);
}

- (void)testPointPercent {
  XCTAssertEqual(YGPointValue(1).value, 1);
  XCTAssertEqual(YGPointValue(1).unit, YGUnitPoint);
  XCTAssertEqual(YGPercentValue(2).value, 2);
  XCTAssertEqual(YGPercentValue(2).unit, YGUnitPercent);
}

- (void)testPositionalPropertiesWork {
  UIView* view = [[UIView alloc] initWithFrame:CGRectZero];

  view.yoga.left = YGPointValue(1);
  XCTAssertEqual(view.yoga.left.value, 1);
  XCTAssertEqual(view.yoga.left.unit, YGUnitPoint);
  view.yoga.left = YGPercentValue(2);
  XCTAssertEqual(view.yoga.left.value, 2);
  XCTAssertEqual(view.yoga.left.unit, YGUnitPercent);

  view.yoga.right = YGPointValue(3);
  XCTAssertEqual(view.yoga.right.value, 3);
  XCTAssertEqual(view.yoga.right.unit, YGUnitPoint);
  view.yoga.right = YGPercentValue(4);
  XCTAssertEqual(view.yoga.right.value, 4);
  XCTAssertEqual(view.yoga.right.unit, YGUnitPercent);

  view.yoga.top = YGPointValue(5);
  XCTAssertEqual(view.yoga.top.value, 5);
  XCTAssertEqual(view.yoga.top.unit, YGUnitPoint);
  view.yoga.top = YGPercentValue(6);
  XCTAssertEqual(view.yoga.top.value, 6);
  XCTAssertEqual(view.yoga.top.unit, YGUnitPercent);

  view.yoga.bottom = YGPointValue(7);
  XCTAssertEqual(view.yoga.bottom.value, 7);
  XCTAssertEqual(view.yoga.bottom.unit, YGUnitPoint);
  view.yoga.bottom = YGPercentValue(8);
  XCTAssertEqual(view.yoga.bottom.value, 8);
  XCTAssertEqual(view.yoga.bottom.unit, YGUnitPercent);

  view.yoga.start = YGPointValue(9);
  XCTAssertEqual(view.yoga.start.value, 9);
  XCTAssertEqual(view.yoga.start.unit, YGUnitPoint);
  view.yoga.start = YGPercentValue(10);
  XCTAssertEqual(view.yoga.start.value, 10);
  XCTAssertEqual(view.yoga.start.unit, YGUnitPercent);

  view.yoga.end = YGPointValue(11);
  XCTAssertEqual(view.yoga.end.value, 11);
  XCTAssertEqual(view.yoga.end.unit, YGUnitPoint);
  view.yoga.end = YGPercentValue(12);
  XCTAssertEqual(view.yoga.end.value, 12);
  XCTAssertEqual(view.yoga.end.unit, YGUnitPercent);
}

- (void)testMarginPropertiesWork {
  UIView* view = [[UIView alloc] initWithFrame:CGRectZero];

  view.yoga.margin = YGPointValue(1);
  XCTAssertEqual(view.yoga.margin.value, 1);
  XCTAssertEqual(view.yoga.margin.unit, YGUnitPoint);
  view.yoga.margin = YGPercentValue(2);
  XCTAssertEqual(view.yoga.margin.value, 2);
  XCTAssertEqual(view.yoga.margin.unit, YGUnitPercent);

  view.yoga.marginHorizontal = YGPointValue(3);
  XCTAssertEqual(view.yoga.marginHorizontal.value, 3);
  XCTAssertEqual(view.yoga.marginHorizontal.unit, YGUnitPoint);
  view.yoga.marginHorizontal = YGPercentValue(4);
  XCTAssertEqual(view.yoga.marginHorizontal.value, 4);
  XCTAssertEqual(view.yoga.marginHorizontal.unit, YGUnitPercent);

  view.yoga.marginVertical = YGPointValue(5);
  XCTAssertEqual(view.yoga.marginVertical.value, 5);
  XCTAssertEqual(view.yoga.marginVertical.unit, YGUnitPoint);
  view.yoga.marginVertical = YGPercentValue(6);
  XCTAssertEqual(view.yoga.marginVertical.value, 6);
  XCTAssertEqual(view.yoga.marginVertical.unit, YGUnitPercent);

  view.yoga.marginLeft = YGPointValue(7);
  XCTAssertEqual(view.yoga.marginLeft.value, 7);
  XCTAssertEqual(view.yoga.marginLeft.unit, YGUnitPoint);
  view.yoga.marginLeft = YGPercentValue(8);
  XCTAssertEqual(view.yoga.marginLeft.value, 8);
  XCTAssertEqual(view.yoga.marginLeft.unit, YGUnitPercent);

  view.yoga.marginRight = YGPointValue(9);
  XCTAssertEqual(view.yoga.marginRight.value, 9);
  XCTAssertEqual(view.yoga.marginRight.unit, YGUnitPoint);
  view.yoga.marginRight = YGPercentValue(10);
  XCTAssertEqual(view.yoga.marginRight.value, 10);
  XCTAssertEqual(view.yoga.marginRight.unit, YGUnitPercent);

  view.yoga.marginTop = YGPointValue(11);
  XCTAssertEqual(view.yoga.marginTop.value, 11);
  XCTAssertEqual(view.yoga.marginTop.unit, YGUnitPoint);
  view.yoga.marginTop = YGPercentValue(12);
  XCTAssertEqual(view.yoga.marginTop.value, 12);
  XCTAssertEqual(view.yoga.marginTop.unit, YGUnitPercent);

  view.yoga.marginBottom = YGPointValue(13);
  XCTAssertEqual(view.yoga.marginBottom.value, 13);
  XCTAssertEqual(view.yoga.marginBottom.unit, YGUnitPoint);
  view.yoga.marginBottom = YGPercentValue(14);
  XCTAssertEqual(view.yoga.marginBottom.value, 14);
  XCTAssertEqual(view.yoga.marginBottom.unit, YGUnitPercent);

  view.yoga.marginStart = YGPointValue(15);
  XCTAssertEqual(view.yoga.marginStart.value, 15);
  XCTAssertEqual(view.yoga.marginStart.unit, YGUnitPoint);
  view.yoga.marginStart = YGPercentValue(16);
  XCTAssertEqual(view.yoga.marginStart.value, 16);
  XCTAssertEqual(view.yoga.marginStart.unit, YGUnitPercent);

  view.yoga.marginEnd = YGPointValue(17);
  XCTAssertEqual(view.yoga.marginEnd.value, 17);
  XCTAssertEqual(view.yoga.marginEnd.unit, YGUnitPoint);
  view.yoga.marginEnd = YGPercentValue(18);
  XCTAssertEqual(view.yoga.marginEnd.value, 18);
  XCTAssertEqual(view.yoga.marginEnd.unit, YGUnitPercent);
}

- (void)testPaddingPropertiesWork {
  UIView* view = [[UIView alloc] initWithFrame:CGRectZero];

  view.yoga.padding = YGPointValue(1);
  XCTAssertEqual(view.yoga.padding.value, 1);
  XCTAssertEqual(view.yoga.padding.unit, YGUnitPoint);
  view.yoga.padding = YGPercentValue(2);
  XCTAssertEqual(view.yoga.padding.value, 2);
  XCTAssertEqual(view.yoga.padding.unit, YGUnitPercent);

  view.yoga.paddingHorizontal = YGPointValue(3);
  XCTAssertEqual(view.yoga.paddingHorizontal.value, 3);
  XCTAssertEqual(view.yoga.paddingHorizontal.unit, YGUnitPoint);
  view.yoga.paddingHorizontal = YGPercentValue(4);
  XCTAssertEqual(view.yoga.paddingHorizontal.value, 4);
  XCTAssertEqual(view.yoga.paddingHorizontal.unit, YGUnitPercent);

  view.yoga.paddingVertical = YGPointValue(5);
  XCTAssertEqual(view.yoga.paddingVertical.value, 5);
  XCTAssertEqual(view.yoga.paddingVertical.unit, YGUnitPoint);
  view.yoga.paddingVertical = YGPercentValue(6);
  XCTAssertEqual(view.yoga.paddingVertical.value, 6);
  XCTAssertEqual(view.yoga.paddingVertical.unit, YGUnitPercent);

  view.yoga.paddingLeft = YGPointValue(7);
  XCTAssertEqual(view.yoga.paddingLeft.value, 7);
  XCTAssertEqual(view.yoga.paddingLeft.unit, YGUnitPoint);
  view.yoga.paddingLeft = YGPercentValue(8);
  XCTAssertEqual(view.yoga.paddingLeft.value, 8);
  XCTAssertEqual(view.yoga.paddingLeft.unit, YGUnitPercent);

  view.yoga.paddingRight = YGPointValue(9);
  XCTAssertEqual(view.yoga.paddingRight.value, 9);
  XCTAssertEqual(view.yoga.paddingRight.unit, YGUnitPoint);
  view.yoga.paddingRight = YGPercentValue(10);
  XCTAssertEqual(view.yoga.paddingRight.value, 10);
  XCTAssertEqual(view.yoga.paddingRight.unit, YGUnitPercent);

  view.yoga.paddingTop = YGPointValue(11);
  XCTAssertEqual(view.yoga.paddingTop.value, 11);
  XCTAssertEqual(view.yoga.paddingTop.unit, YGUnitPoint);
  view.yoga.paddingTop = YGPercentValue(12);
  XCTAssertEqual(view.yoga.paddingTop.value, 12);
  XCTAssertEqual(view.yoga.paddingTop.unit, YGUnitPercent);

  view.yoga.paddingBottom = YGPointValue(13);
  XCTAssertEqual(view.yoga.paddingBottom.value, 13);
  XCTAssertEqual(view.yoga.paddingBottom.unit, YGUnitPoint);
  view.yoga.paddingBottom = YGPercentValue(14);
  XCTAssertEqual(view.yoga.paddingBottom.value, 14);
  XCTAssertEqual(view.yoga.paddingBottom.unit, YGUnitPercent);

  view.yoga.paddingStart = YGPointValue(15);
  XCTAssertEqual(view.yoga.paddingStart.value, 15);
  XCTAssertEqual(view.yoga.paddingStart.unit, YGUnitPoint);
  view.yoga.paddingStart = YGPercentValue(16);
  XCTAssertEqual(view.yoga.paddingStart.value, 16);
  XCTAssertEqual(view.yoga.paddingStart.unit, YGUnitPercent);

  view.yoga.paddingEnd = YGPointValue(17);
  XCTAssertEqual(view.yoga.paddingEnd.value, 17);
  XCTAssertEqual(view.yoga.paddingEnd.unit, YGUnitPoint);
  view.yoga.paddingEnd = YGPercentValue(18);
  XCTAssertEqual(view.yoga.paddingEnd.value, 18);
  XCTAssertEqual(view.yoga.paddingEnd.unit, YGUnitPercent);
}

- (void)testBorderWidthPropertiesWork {
  UIView* view = [[UIView alloc] initWithFrame:CGRectZero];

  view.yoga.borderWidth = 1;
  XCTAssertEqual(view.yoga.borderWidth, 1);

  view.yoga.borderLeftWidth = 2;
  XCTAssertEqual(view.yoga.borderLeftWidth, 2);

  view.yoga.borderRightWidth = 3;
  XCTAssertEqual(view.yoga.borderRightWidth, 3);

  view.yoga.borderTopWidth = 4;
  XCTAssertEqual(view.yoga.borderTopWidth, 4);

  view.yoga.borderBottomWidth = 5;
  XCTAssertEqual(view.yoga.borderBottomWidth, 5);

  view.yoga.borderStartWidth = 6;
  XCTAssertEqual(view.yoga.borderStartWidth, 6);

  view.yoga.borderEndWidth = 7;
  XCTAssertEqual(view.yoga.borderEndWidth, 7);
}

#if !TARGET_OS_OSX
- (void)testOverflowPropertiesWork {
  UIView* container = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
  [container.yoga configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
    layout.isIncludedInLayout = YES;
    layout.flexDirection = YGFlexDirectionRow;
    layout.alignItems = YGAlignCenter;
  }];

  UIView* view = [[UIView alloc] initWithFrame:CGRectZero];
  [container addSubview:view];
  [view.yoga configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
    layout.isIncludedInLayout = YES;
    layout.width = YGPointValue(22);
    layout.height = YGPointValue(22);
  }];

  UILabel* label = [[UILabel alloc] init];
  label.text = @"longlonglonglonglonglonglonglonglonglonglonglonglonglonglonglonglonglong";
  [container addSubview:label];
  [label.yoga configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
    layout.isIncludedInLayout = YES;
  }];

  [container.yoga applyLayoutPreservingOrigin:YES];
  XCTAssertEqual(CGRectGetWidth(container.frame), 30);
  XCTAssertEqual(CGRectGetWidth(label.frame), 30);

  container.yoga.overflow = YGOverflowScroll;
  [container.yoga applyLayoutPreservingOrigin:YES];
  XCTAssertEqual(CGRectGetWidth(container.frame), 30);
  XCTAssertGreaterThan(CGRectGetWidth(label.frame), 30);

  container.yoga.overflow = YGOverflowHidden;
  [container.yoga applyLayoutPreservingOrigin:YES];
  XCTAssertEqual(CGRectGetWidth(container.frame), 30);
  XCTAssertEqual(CGRectGetWidth(label.frame), 30);

  container.yoga.overflow = YGOverflowVisible;
  [container.yoga applyLayoutPreservingOrigin:YES];
  XCTAssertEqual(CGRectGetWidth(container.frame), 30);
  XCTAssertEqual(CGRectGetWidth(label.frame), 30);
}
#endif

#if !TARGET_OS_OSX
- (void)testIsIncludedInLayoutWork {
  UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
  [view.yoga configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
    layout.isIncludedInLayout = YES;
    layout.flexDirection = YGFlexDirectionColumn;
  }];

  UIControl* container = [[UIControl alloc] initWithFrame:CGRectZero];
  [view addSubview:container];
  [container.yoga configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
    layout.isIncludedInLayout = YES;
    layout.flexDirection = YGFlexDirectionRow;
  }];

  UILabel* label = [[UILabel alloc] init];
  label.text = @"abcdefgABCDEFG";
  [container addSubview:label];
  label.yoga.isIncludedInLayout = YES;
  [label.yoga markDirty];

  [view.yoga applyLayoutPreservingOrigin:YES];
  XCTAssertGreaterThan(CGRectGetHeight(container.frame), 0);

  label.yoga.isIncludedInLayout = NO;

  [view.yoga applyLayoutPreservingOrigin:YES];
  XCTAssertEqual(CGRectGetHeight(container.frame), 0);
}
#endif

- (void)testOnePixelWork {
  CGFloat onePixel = 1 / kScaleFactor;

  UIView* view = [[UIView alloc] initWithFrame:CGRectZero];
  [view.yoga configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
    layout.isIncludedInLayout = YES;
    layout.flexDirection = YGFlexDirectionColumn;
  }];

  UIView* subView1 = [[UIView alloc] initWithFrame:CGRectZero];
  [view addSubview:subView1];
  [subView1.yoga configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
    layout.isIncludedInLayout = YES;
    layout.width = YGPointValue(320);
    layout.height = YGPointValue(320 + onePixel);
  }];

  UIView* subView2 = [[UIView alloc] initWithFrame:CGRectZero];
  [view addSubview:subView2];
  [subView2.yoga configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
    layout.isIncludedInLayout = YES;
    layout.marginTop = YGPointValue(20);
    layout.width = YGPointValue(320);
    layout.height = YGPointValue(onePixel);
  }];

  CGSize fittingSize = [view.yoga calculateLayoutWithSize:CGSizeMake(320, YGUndefined)];
  view.frame = (CGRect){CGPointZero, fittingSize};
  [view.yoga applyLayoutPreservingOrigin:YES];
  XCTAssertLessThan(fabs(CGRectGetHeight(subView2.frame) - onePixel), FLT_EPSILON);
}

- (void)testBaseViewLeafNodeWork {
  UIView *container = [[UIView alloc] initWithFrame:CGRectZero];
  [container.yoga configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
    layout.isIncludedInLayout = YES;
    layout.width = YGPointValue(300);
    layout.height = YGPointValue(180);
  }];

  UIView *subview1 = [[UIView alloc] initWithFrame:CGRectZero];
  [container addSubview:subview1];
  subview1.yoga.isIncludedInLayout = YES;

  UIView *subview2 = [[UIView alloc] initWithFrame:CGRectZero];
  [subview1 addSubview:subview2];
  [subview2.yoga configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
    layout.isIncludedInLayout = YES;
  }];

  UIView *subview3 = [[UIView alloc] initWithFrame:CGRectZero];
  [subview2 addSubview:subview3];
  [subview3.yoga configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
    layout.isIncludedInLayout = YES;
    layout.width = YGPointValue(80);
    layout.height = YGPointValue(60);
  }];

  [container.yoga applyLayoutPreservingOrigin:YES];

  XCTAssertEqual(subview1.frame.size.height, 60);
  XCTAssertEqual(subview2.frame.size.height, 60);
  XCTAssertEqual(subview3.frame.size.height, 60);

  subview2.yoga.isIncludedInLayout = NO;
  subview2.frame = CGRectZero;
  [container.yoga applyLayoutPreservingOrigin:YES];

  XCTAssertEqual(subview1.frame.size.height, 0);
  XCTAssertEqual(subview2.frame.size.height, 0);
  XCTAssertEqual(subview3.frame.size.height, 60);

  XCTAssertEqual(container.frame.size.width, 300);
  XCTAssertEqual(container.frame.size.height, 180);
}

- (void)testAutoLayoutSupport {
  UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1000, 1000)];

  UIView *container = [[UIView alloc] initWithFrame:CGRectZero];
  [view addSubview:container];
  container.translatesAutoresizingMaskIntoConstraints = NO;
  [NSLayoutConstraint activateConstraints:@[
      [container.topAnchor constraintEqualToAnchor:view.topAnchor constant:24],
      [container.leftAnchor constraintEqualToAnchor:view.leftAnchor constant:24]
  ]];

  [container.yoga configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
      layout.flexDirection = YGFlexDirectionColumn;
  }];

  UIView *subview1 = [[UIView alloc] initWithFrame:CGRectZero];
  [container addSubview:subview1];
  [subview1.yoga configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
      layout.height = YGPointValue(80);
      layout.width = YGPointValue(60);
      layout.marginBottom = YGPointValue(16);
  }];

  UIView *subview2 = [[UIView alloc] initWithFrame:CGRectZero];
  [container addSubview:subview2];
  [subview2.yoga configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
      layout.height = YGPointValue(180);
      layout.width = YGPointValue(200);
  }];

  UIView *subview3 = [[UIView alloc] initWithFrame:CGRectZero];
  [container addSubview:subview3];
  [subview3.yoga configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
      layout.height = YGPointValue(100);
      layout.width = YGPointValue(80);
      layout.marginTop = YGPointValue(24);
  }];

#if TARGET_OS_OSX
  [view layoutSubtreeIfNeeded];
#else
  [view layoutIfNeeded];
#endif

  XCTAssertEqual(container.frame.origin.x, 24);
  XCTAssertEqual(container.frame.origin.y, 24);
  XCTAssertEqual(container.frame.size.width, 200);
  XCTAssertEqual(container.frame.size.height, 80 + 16 + 180 + 24 + 100);
}

@end
