//
//  UIScrollView+RTL.m
//  will
//
//  Created by 王永刚 on 2023/7/5.
//  Copyright © 2023 maitang. All rights reserved.
//

#import "UIScrollView+RTL.h"
#import <objc/runtime.h>

static char contentRefWidthKey;
static char refWidthKey;

@implementation UIScrollView (RTL)

- (void)setWlContentRefWidth:(CGFloat)wlContentRefWidth {
    objc_setAssociatedObject(self, &contentRefWidthKey, @(wlContentRefWidth), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)wlContentRefWidth {
    NSNumber *value = objc_getAssociatedObject(self, &contentRefWidthKey);
    return value ? value.floatValue : self.contentSize.width;
}

- (void)setTYRTLContentInset:(UIEdgeInsets)TYRTLContentInset {
    if ([UIScrollView isRTL]) {
        self.contentInset = UIEdgeInsetsMake(TYRTLContentInset.top,
                                             TYRTLContentInset.right,
                                             TYRTLContentInset.bottom,
                                             TYRTLContentInset.left);
    } else {
        self.contentInset = TYRTLContentInset;
    }
}

- (UIEdgeInsets)TYRTLContentInset {
    if ([UIScrollView isRTL]) {
        return UIEdgeInsetsMake(self.contentInset.top,
                                self.contentInset.right,
                                self.contentInset.bottom,
                                self.contentInset.left);
    } else {
        return self.contentInset;
    }
}

- (void)setTYRTLContentOffset:(CGPoint)TYRTLContentOffset {
    if ([UIScrollView isRTL]) {
        CGFloat offsetX = self.wlContentRefWidth - self.bounds.size.width - TYRTLContentOffset.x;
        self.contentOffset = CGPointMake(offsetX, TYRTLContentOffset.y);
    } else {
        self.contentOffset = TYRTLContentOffset;
    }
}

- (CGPoint)TYRTLContentOffset {
    if ([UIScrollView isRTL]) {
        CGFloat offsetX = self.wlContentRefWidth - self.bounds.size.width - self.contentOffset.x;
        return CGPointMake(offsetX, self.contentOffset.y);
    } else {
        return self.contentOffset;
    }
}

- (void)TYRTLSetContentOffset:(CGPoint)contentOffset animated:(BOOL)animated {
    CGPoint offset = contentOffset;
    if ([UIScrollView isRTL]) {
        CGFloat offsetX = self.wlContentRefWidth - self.bounds.size.width - contentOffset.x;
        offset = CGPointMake(offsetX, contentOffset.y);
    }
    [self setContentOffset:offset animated:animated];
}

- (CGFloat)TYRTLValueFromSelf:(CGFloat)v {
    return [UIScrollView isRTL] ? (self.wlContentRefWidth - v) : v;
}

- (CGPoint)TYRTLContentOffset:(CGPoint)offset {
    if ([UIScrollView isRTL]) {
        CGFloat offsetX = self.wlContentRefWidth - self.bounds.size.width - offset.x;
        return CGPointMake(offsetX, offset.y);
    } else {
        return offset;
    }
}

+ (BOOL)isRTL {
    NSLocale *locale = [NSLocale currentLocale];
    NSString *languageCode = [locale languageCode];
    if (!languageCode) {
        return NO;
    }
    
    NSLocaleLanguageDirection characterDirection = [NSLocale characterDirectionForLanguage:languageCode];
    return characterDirection == NSLocaleLanguageDirectionRightToLeft;
}

@end



@implementation UIView (RTL)

- (void)setTYRTLRefWidth:(CGFloat)TYRTLRefWidth {
    objc_setAssociatedObject(self, &refWidthKey, @(TYRTLRefWidth), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)TYRTLRefWidth {
    NSNumber *value = objc_getAssociatedObject(self, &refWidthKey);
    return value ? value.floatValue : (self.superview ? CGRectGetMaxX(self.superview.bounds) : 0);
}

- (void)setTYRTLFrame:(CGRect)TYRTLFrame {
    if ([self isRTLLang]) {
        CGFloat x = self.TYRTLRefWidth - CGRectGetMaxX(TYRTLFrame);
        CGRect newFrame = CGRectMake(x, TYRTLFrame.origin.y, TYRTLFrame.size.width, TYRTLFrame.size.height);
        self.frame = newFrame;
    } else {
        self.frame = TYRTLFrame;
    }
}

- (CGRect)TYRTLFrame {
    if ([self isRTLLang]) {
        CGFloat x = self.TYRTLRefWidth - CGRectGetMaxX(self.frame);
        return CGRectMake(x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    } else {
        return self.frame;
    }
}

- (void)setTYRTLCenter:(CGPoint)TYRTLCenter {
    if ([self isRTLLang]) {
        CGFloat centerX = self.TYRTLRefWidth - TYRTLCenter.x;
        self.center = CGPointMake(centerX, TYRTLCenter.y);
    } else {
        self.center = TYRTLCenter;
    }
}

- (CGFloat)TYRTLX {
    if ([self isRTLLang]) {
        CGFloat x = self.TYRTLRefWidth - CGRectGetWidth(self.frame) - self.frame.origin.x;
        return x;
    } else {
        return self.frame.origin.x;
    }
}

- (CGFloat)TYRTLMidX {
    if ([self isRTLLang]) {
        return self.TYRTLRefWidth - CGRectGetMidX(self.frame);
    } else {
        return CGRectGetMidX(self.frame);
    }
}

- (CGFloat)TYRTLMaxX {
    if ([self isRTLLang]) {
        return self.TYRTLRefWidth - self.frame.origin.x;
    } else {
        return CGRectGetMaxX(self.frame);
    }
}

- (CGFloat)TYRTLValueFromSelf:(CGFloat)v {
    return [self isRTLLang] ? (CGRectGetWidth(self.bounds) - v) : v;
}

- (CGFloat)TYRTLValueFromRef:(CGFloat)v {
    return [self isRTLLang] ? (self.TYRTLRefWidth - v) : v;
}

- (BOOL)isRTLLang {
    NSLocale *locale = [NSLocale currentLocale];
    NSString *languageCode = [locale languageCode];
    if (!languageCode) {
        return NO;
    }
    
    NSLocaleLanguageDirection characterDirection = [NSLocale characterDirectionForLanguage:languageCode];
    return characterDirection == NSLocaleLanguageDirectionRightToLeft;
}

@end
