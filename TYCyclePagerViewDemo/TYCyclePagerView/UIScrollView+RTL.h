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
@property (nonatomic, assign) UIEdgeInsets wlRTLContentInset;
@property (nonatomic, assign) CGPoint wlRTLContentOffset;

- (void)wlRTLSetContentOffset:(CGPoint)contentOffset animated:(BOOL)animated;
- (CGFloat)wlRTLValueFromSelf:(CGFloat)v;
- (CGPoint)wlRTLContentOffset:(CGPoint)offset;

@end

@interface UIView (RTL)


@property (nonatomic, assign) CGFloat wlRTLRefWidth;

- (void)setWlRTLFrame:(CGRect)wlRTLFrame;
- (CGRect)wlRTLFrame;

@property (nonatomic, assign) CGPoint wlRTLCenter;

@property (nonatomic, assign) CGFloat wlRTLX;

@property (nonatomic, readonly) CGFloat wlRTLMidX;
@property (nonatomic, readonly) CGFloat wlRTLMaxX;

- (CGFloat)wlRTLValueFromSelf:(CGFloat)v;
- (CGFloat)wlRTLValueFromRef:(CGFloat)v;

@end

NS_ASSUME_NONNULL_END
