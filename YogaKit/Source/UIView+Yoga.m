/*
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import <objc/runtime.h>
#import "UIView+Yoga.h"
#import "YGLayout+Private.h"

static const void* kYGYogaAssociatedKey = &kYGYogaAssociatedKey;

@implementation UIView (YogaKit)

- (YGLayout*)yoga {
    YGLayout* yoga = objc_getAssociatedObject(self, kYGYogaAssociatedKey);
    if (!yoga) {
        yoga = [[YGLayout alloc] initWithView:self];
        objc_setAssociatedObject(self, kYGYogaAssociatedKey, yoga, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }

    return yoga;
}

- (BOOL)isYogaEnabled {
    return objc_getAssociatedObject(self, kYGYogaAssociatedKey) != nil;
}

@end

NS_INLINE BOOL CGRectIsStandlized(CGRect rect) {
    CGFloat x = CGRectGetMinX(rect), y = CGRectGetMinY(rect);
    CGFloat w = CGRectGetWidth(rect), h = CGRectGetHeight(rect);

    return !(isnan(x) || isinf(x) ||
             isnan(y) || isinf(y) ||
             isnan(w) || isinf(w) ||
             isnan(h) || isinf(h));
}

NS_INLINE CGRect StandlizedRect(CGRect rect) {
    if (CGRectIsStandlized(rect)) {
        return rect;
    }

    CGFloat x = CGRectGetMinX(rect), y = CGRectGetMinY(rect);
    CGPoint origin = rect.origin;

    origin.x = isnan(x) || isinf(x) ? 0 : x;
    origin.y = isnan(y) || isinf(y) ? 0 : y;

    CGFloat w = CGRectGetWidth(rect), h = CGRectGetHeight(rect);
    CGSize size = rect.size;

    size.width = isnan(w) || isinf(w) ? 0 : w;
    size.height = isnan(h) || isinf(h) ? 0 : h;

    return (CGRect){ origin, size };
}

#if TARGET_OS_OSX
NS_INLINE NSSize StandlizedSize(NSSize size) {
    return StandlizedRect((CGRect){ CGPointZero, size }).size;
}
#endif

static void YogaSwizzleInstanceMethod(Class cls, SEL originalSelector, SEL swizzledSelector);

@implementation UIView (YogaKitAutoApplyLayout)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        YogaSwizzleInstanceMethod(self, @selector(initWithFrame:), @selector(_yoga_initWithFrame:));
        YogaSwizzleInstanceMethod(self, @selector(setFrame:), @selector(_yoga_setFrame:));
        YogaSwizzleInstanceMethod(self, @selector(setBounds:), @selector(_yoga_setBounds:));
        YogaSwizzleInstanceMethod(self, @selector(intrinsicContentSize), @selector(_yoga_intrinsicContentSize));
#if TARGET_OS_OSX
        YogaSwizzleInstanceMethod(self, @selector(setFrameSize:), @selector(_yoga_setFrameSize:));
        YogaSwizzleInstanceMethod(self, @selector(setBoundsSize:), @selector(_yoga_setBoundsSize:));
#endif
    });
}

- (CGFloat)_yoga_maxLayoutWidth {
    NSNumber *maxWidth = objc_getAssociatedObject(self, @selector(_yoga_maxLayoutWidth));

    return maxWidth ? (CGFloat)maxWidth.doubleValue : YGUndefined;
}

- (void)set_yoga_maxLayoutWidth:(CGFloat)newValue {
    CGFloat value = newValue;
    if (value < 0) {
        value = YGUndefined;
    }

    objc_setAssociatedObject(self, @selector(_yoga_maxLayoutWidth),
                             [NSNumber numberWithDouble:value], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (instancetype)_yoga_initWithFrame:(CGRect)frame {
    id _self = [self _yoga_initWithFrame:StandlizedRect(frame)];
    if (_self) {
        [self _yoga_applyLayout];
    }

    return _self;
}

- (void)_yoga_setFrame:(CGRect)frame {
    CGRect rect = StandlizedRect(frame);
    [self _yoga_setFrame:rect];
    [self _yoga_applyLayout];
    
#if TARGET_OS_OSX
    CGFloat width = CGRectGetWidth(rect);
    [self _yoga_updateConstraintsIfNeeded:width];
#endif
}

- (void)_yoga_setBounds:(CGRect)bounds {
    CGRect rect = StandlizedRect(bounds);
    [self _yoga_setBounds:rect];
    [self _yoga_applyLayout];

    CGFloat width = CGRectGetWidth(rect);
    [self _yoga_updateConstraintsIfNeeded:width];
}

- (CGSize)_yoga_intrinsicContentSize {
    CGSize size = [self _yoga_intrinsicContentSize];

    if (self.isYogaEnabled) {
        YGLayout *yoga = self.yoga;
        if (yoga.isIncludedInLayout) {
            CGFloat maxWidth = self._yoga_maxLayoutWidth;
            if (maxWidth == 0) {
                maxWidth = YGUndefined;
            }
            
            size = [yoga calculateLayoutWithSize:CGSizeMake(maxWidth, YGUndefined)];
        }
    }

    self._yoga_maxLayoutWidth = size.width;

    return size;
}

#if TARGET_OS_OSX
- (void)_yoga_setFrameSize:(NSSize)newSize {
    NSSize size = StandlizedSize(newSize);
    [self _yoga_setFrameSize:size];
    [self _yoga_applyLayout];
    [self _yoga_updateConstraintsIfNeeded:size.width];
}

- (void)_yoga_setBoundsSize:(NSSize)newSize {
    NSSize size = StandlizedSize(newSize);
    [self _yoga_setBoundsSize:size];
    [self _yoga_applyLayout];
    [self _yoga_updateConstraintsIfNeeded:size.width];
}
#endif

- (void)_yoga_applyLayout {
    if (self.isYogaEnabled) {
        YGLayout *yoga = self.yoga;
        if (yoga.isIncludedInLayout) {
            [yoga applyLayoutPreservingOrigin:YES];
        }
    }
}

- (void)_yoga_updateConstraintsIfNeeded:(CGFloat)width {
    if (self._yoga_isAutoLayoutEnabled) {
        return;
    }

    CGFloat maxWidth = self._yoga_maxLayoutWidth;
    if (isnan(maxWidth) || maxWidth != width) {
        self._yoga_maxLayoutWidth = width;
        __weak typeof(self) wself = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [wself invalidateIntrinsicContentSize];
        });
    }
}

- (BOOL)_yoga_isAutoLayoutEnabled {
    if (self.translatesAutoresizingMaskIntoConstraints) {
        return NO;
    }

    for (NSLayoutConstraint *constraint in self.constraints) {
        if (@available(macOS 10.0, iOS 8.0, tvOS 8.0, *)) {
            if (constraint.isActive) {
                return YES;
            }
        } else {
            return YES;
        }
    }

    return NO;
}

@end

static void YogaSwizzleInstanceMethod(Class cls, SEL originalSelector, SEL swizzledSelector) {
    if (!cls || !originalSelector || !swizzledSelector) {
        return;
    }

    Method originalMethod = class_getInstanceMethod(cls, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(cls, swizzledSelector);
    if (!originalMethod || !swizzledMethod) {
        return;
    }

    IMP swizzledIMP = method_getImplementation(swizzledMethod);
    if (class_addMethod(cls, originalSelector, swizzledIMP, method_getTypeEncoding(swizzledMethod))) {
        class_replaceMethod(cls,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

