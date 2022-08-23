/*
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import <objc/runtime.h>
#import <objc/message.h>
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

static void YogaSwizzleInstanceMethod(Class cls, SEL originalSelector, SEL swizzledSelector);

NS_INLINE CGRect AutoCorrectRect(CGRect rect) {
#define AutoCorrectAnchor(x) (isnan(x) ? 0 : x)
#define AutoCorrectDimension(x) (isnan(x) ? 0 : MAX(x, 0))

    CGPoint origin = rect.origin;
    CGSize size = rect.size;

    return CGRectMake(
        AutoCorrectAnchor(origin.x),
        AutoCorrectAnchor(origin.y),
        AutoCorrectDimension(size.width),
        AutoCorrectDimension(size.height)
    );
}

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

#if TARGET_OS_OSX
- (void)set_yoga_isFittingSize:(BOOL)newValue {
    objc_setAssociatedObject(self, @selector(_yoga_isFittingSize), [NSNumber numberWithBool:newValue], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)_yoga_isFittingSize {
    return [objc_getAssociatedObject(self, @selector(_yoga_isFittingSize)) boolValue];
}
#endif

- (instancetype)_yoga_initWithFrame:(CGRect)frame {
    frame = AutoCorrectRect(frame);
    id _self = [self _yoga_initWithFrame:frame];
    if (_self) {
        [self _yoga_applyLayout];
    }

    return _self;
}

- (void)_yoga_setFrame:(CGRect)frame {
    frame = AutoCorrectRect(frame);
    [self _yoga_setFrame:frame];
    [self _yoga_applyLayout];
    
#if TARGET_OS_OSX
    CGFloat width = CGRectGetWidth(frame);
    [self _yoga_updateConstraintsIfNeeded:width];
#endif
}

- (void)_yoga_setBounds:(CGRect)bounds {
    bounds = AutoCorrectRect(bounds);
    [self _yoga_setBounds:bounds];
    [self _yoga_applyLayout];

    CGFloat width = CGRectGetWidth(bounds);
    [self _yoga_updateConstraintsIfNeeded:width];
}

- (CGSize)_yoga_intrinsicContentSize {
    CGSize size = [self _yoga_intrinsicContentSize];

#if TARGET_OS_OSX
    if (self._yoga_isFittingSize) {
        return size;
    }
#endif
    
    if (!self.isYogaEnabled) {
        return size;
    }

    YGLayout *yoga = self.yoga;
    if (yoga.isIncludedInLayout) {
        CGFloat maxWidth = self._yoga_maxLayoutWidth;
        if (maxWidth == 0) {
            maxWidth = YGUndefined;
        }

        size = [yoga calculateLayoutWithSize:CGSizeMake(maxWidth, YGUndefined)];
        self._yoga_maxLayoutWidth = size.width;
    }

    return size;
}

#if TARGET_OS_OSX
- (void)_yoga_setFrameSize:(NSSize)newSize {
    [self _yoga_setFrameSize:newSize];
    [self _yoga_applyLayout];
    [self _yoga_updateConstraintsIfNeeded:newSize.width];
}

- (void)_yoga_setBoundsSize:(NSSize)newSize {
    [self _yoga_setBoundsSize:newSize];
    [self _yoga_applyLayout];
    [self _yoga_updateConstraintsIfNeeded:newSize.width];
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
    if (!self.isYogaEnabled || !self._yoga_isAutoLayoutEnabled) {
        return;
    }

    CGFloat maxWidth = self._yoga_maxLayoutWidth;
    if (maxWidth != width) {
        self._yoga_maxLayoutWidth = width;
        [self invalidateIntrinsicContentSize];
#if !TARGET_OS_OSX
        [self.superview layoutIfNeeded];
#endif
    }
}

- (BOOL)_yoga_isAutoLayoutEnabled {
    if (self.translatesAutoresizingMaskIntoConstraints) {
        return NO;
    }

    for (NSLayoutConstraint *constraint in self.constraints) {
        if (@available(macOS 10.10, iOS 8.0, tvOS 8.0, *)) {
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
    IMP swizzledIMP = class_getMethodImplementation(cls, swizzledSelector);
    if (!originalMethod || !swizzledIMP) {
        return;
    }

    const char *types = method_getTypeEncoding(originalMethod);

#if defined(__arm64__)
    typedef void (*objc_msgSendSuper_t)(struct objc_super *, SEL, ...);
    typedef void (*objc_msgSend_t)(id, SEL, ...);

    // already swizzled
    if (imp_getBlock(swizzledIMP)) {
        return;
    }

    IMP originalIMP = class_replaceMethod(cls, originalSelector, swizzledIMP, types);

    class_replaceMethod(cls, swizzledSelector, imp_implementationWithBlock(^(__unsafe_unretained id self, va_list args) {
        if (!originalIMP) {
            struct objc_super super = { self, class_getSuperclass(cls) };

            return ((objc_msgSendSuper_t)objc_msgSendSuper)(&super, originalSelector, args);
        }

        return ((objc_msgSend_t)originalIMP)(self, originalSelector, args);
    }), types);
#else
    if (class_addMethod(cls, originalSelector, swizzledIMP, types)) {
        class_replaceMethod(cls, swizzledSelector, method_getImplementation(originalMethod), types);
    } else {
        method_exchangeImplementations(originalMethod, class_getInstanceMethod(cls, swizzledSelector));
    }
#endif
}
