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

- (void)setWlRTLContentInset:(UIEdgeInsets)wlRTLContentInset {
    if ([UIScrollView isRTL]) {
        self.contentInset = UIEdgeInsetsMake(wlRTLContentInset.top,
                                             wlRTLContentInset.right,
                                             wlRTLContentInset.bottom,
                                             wlRTLContentInset.left);
    } else {
        self.contentInset = wlRTLContentInset;
    }
}

- (UIEdgeInsets)wlRTLContentInset {
    if ([UIScrollView isRTL]) {
        return UIEdgeInsetsMake(self.contentInset.top,
                                self.contentInset.right,
                                self.contentInset.bottom,
                                self.contentInset.left);
    } else {
        return self.contentInset;
    }
}

- (void)setWlRTLContentOffset:(CGPoint)wlRTLContentOffset {
    if ([UIScrollView isRTL]) {
        CGFloat offsetX = self.wlContentRefWidth - self.bounds.size.width - wlRTLContentOffset.x;
        self.contentOffset = CGPointMake(offsetX, wlRTLContentOffset.y);
    } else {
        self.contentOffset = wlRTLContentOffset;
    }
}

- (CGPoint)wlRTLContentOffset {
    if ([UIScrollView isRTL]) {
        CGFloat offsetX = self.wlContentRefWidth - self.bounds.size.width - self.contentOffset.x;
        return CGPointMake(offsetX, self.contentOffset.y);
    } else {
        return self.contentOffset;
    }
}

- (void)wlRTLSetContentOffset:(CGPoint)contentOffset animated:(BOOL)animated {
    CGPoint offset = contentOffset;
    if ([UIScrollView isRTL]) {
        CGFloat offsetX = self.wlContentRefWidth - self.bounds.size.width - contentOffset.x;
        offset = CGPointMake(offsetX, contentOffset.y);
    }
    [self setContentOffset:offset animated:animated];
}

- (CGFloat)wlRTLValueFromSelf:(CGFloat)v {
    return [UIScrollView isRTL] ? (self.wlContentRefWidth - v) : v;
}

- (CGPoint)wlRTLContentOffset:(CGPoint)offset {
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

- (void)setWlRTLRefWidth:(CGFloat)wlRTLRefWidth {
    objc_setAssociatedObject(self, &refWidthKey, @(wlRTLRefWidth), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)wlRTLRefWidth {
    NSNumber *value = objc_getAssociatedObject(self, &refWidthKey);
    return value ? value.floatValue : (self.superview ? CGRectGetMaxX(self.superview.bounds) : 0);
}

- (void)setWlRTLFrame:(CGRect)wlRTLFrame {
    if ([self isRTLLang]) {
        CGFloat x = self.wlRTLRefWidth - CGRectGetMaxX(wlRTLFrame);
        CGRect newFrame = CGRectMake(x, wlRTLFrame.origin.y, wlRTLFrame.size.width, wlRTLFrame.size.height);
        self.frame = newFrame;
    } else {
        self.frame = wlRTLFrame;
    }
}

- (CGRect)wlRTLFrame {
    if ([self isRTLLang]) {
        CGFloat x = self.wlRTLRefWidth - CGRectGetMaxX(self.frame);
        return CGRectMake(x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    } else {
        return self.frame;
    }
}

- (void)setWlRTLCenter:(CGPoint)wlRTLCenter {
    if ([self isRTLLang]) {
        CGFloat centerX = self.wlRTLRefWidth - wlRTLCenter.x;
        self.center = CGPointMake(centerX, wlRTLCenter.y);
    } else {
        self.center = wlRTLCenter;
    }
}

- (CGFloat)wlRTLX {
    if ([self isRTLLang]) {
        CGFloat x = self.wlRTLRefWidth - CGRectGetWidth(self.frame) - self.frame.origin.x;
        return x;
    } else {
        return self.frame.origin.x;
    }
}

- (CGFloat)wlRTLMidX {
    if ([self isRTLLang]) {
        return self.wlRTLRefWidth - CGRectGetMidX(self.frame);
    } else {
        return CGRectGetMidX(self.frame);
    }
}

- (CGFloat)wlRTLMaxX {
    if ([self isRTLLang]) {
        return self.wlRTLRefWidth - self.frame.origin.x;
    } else {
        return CGRectGetMaxX(self.frame);
    }
}

- (CGFloat)wlRTLValueFromSelf:(CGFloat)v {
    return [self isRTLLang] ? (CGRectGetWidth(self.bounds) - v) : v;
}

- (CGFloat)wlRTLValueFromRef:(CGFloat)v {
    return [self isRTLLang] ? (self.wlRTLRefWidth - v) : v;
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
