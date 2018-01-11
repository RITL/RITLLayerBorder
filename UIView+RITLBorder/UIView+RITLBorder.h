//
//  UIView+RITLBorder.h
//  RITLBorder
//
//  Created by YueWen on 2018/1/11.
//  Copyright © 2018年 YueWen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSInteger, RITLBorderDirection){
    
    RITLBorderDirectionLeft = 1 << 1,
    RITLBorderDirectionTop = 1 << 2,
    RITLBorderDirectionRight = 1 << 3,
    RITLBorderDirectionBottom = 1 << 4,
    
};

/// 单边设置border
@interface UIView (RITLBorder)

#pragma mark - 追加边框,使用默认前请优先设置默认使用的属性

/// 使用layer的borderWidth统一设置
- (void)ritl_addBorderWithInset:(UIEdgeInsets)inset
                          Color:(UIColor *)borderColor
                      direction:(RITLBorderDirection)directions;

/// 使用layer的borderColor统一设置
- (void)ritl_addBorderWithInset:(UIEdgeInsets)inset
                     BorderWidth:(CGFloat)borderWidth
                      direction:(RITLBorderDirection)directions;


/// 各项的间距为UIEdgeInsetsZero
- (void)ritl_addBorderWithColor:(UIColor *)borderColor
                     BodrerWidth:(CGFloat)borderWidth
                      direction:(RITLBorderDirection)directions;

/// 自定义的layer设置
- (void)ritl_addBorderWithInset:(UIEdgeInsets)inset
                          Color:(UIColor *)borderColor
                     BorderWidth:(CGFloat)borderWidth
                      direction:(RITLBorderDirection)directions;

/// 移除当前边框
- (void)ritl_removeBorders:(RITLBorderDirection)directions;

/// 移除所有追加的边框
- (void)ritl_removeAllBorders;

@end

NS_ASSUME_NONNULL_END
