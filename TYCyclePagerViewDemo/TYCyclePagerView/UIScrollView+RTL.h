//
//  UIScrollView+RTL.h
//  will
//
//  Created by 王永刚 on 2023/7/5.
//  Copyright © 2023 maitang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (RTL)

@property (nonatomic, assign) CGFloat wlContentRefWidth;
@property (nonatomic, assign) UIEdgeInsets TYRTLContentInset;
@property (nonatomic, assign) CGPoint TYRTLContentOffset;

- (void)TYRTLSetContentOffset:(CGPoint)contentOffset animated:(BOOL)animated;
- (CGFloat)TYRTLValueFromSelf:(CGFloat)v;
- (CGPoint)TYRTLContentOffset:(CGPoint)offset;

@end

@interface UIView (RTL)


@property (nonatomic, assign) CGFloat TYRTLRefWidth;

- (void)setTYRTLFrame:(CGRect)TYRTLFrame;
- (CGRect)TYRTLFrame;

@property (nonatomic, assign) CGPoint TYRTLCenter;

@property (nonatomic, assign) CGFloat TYRTLX;

@property (nonatomic, readonly) CGFloat TYRTLMidX;
@property (nonatomic, readonly) CGFloat TYRTLMaxX;

- (CGFloat)TYRTLValueFromSelf:(CGFloat)v;
- (CGFloat)TYRTLValueFromRef:(CGFloat)v;

@end

NS_ASSUME_NONNULL_END
