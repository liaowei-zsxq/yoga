/*
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import <YogaKit/YGLayout.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Yoga)

/**
 The YGLayout that is attached to this view. It is lazily created.
 */
@property(nonatomic, readonly) YGLayout* yoga;
/**
 Indicates whether or not Yoga is enabled
 */
@property(nonatomic, readonly) BOOL isYogaEnabled;

@end


@interface UIView (YogaKitAutoApplyLayout)

@end

NS_ASSUME_NONNULL_END
