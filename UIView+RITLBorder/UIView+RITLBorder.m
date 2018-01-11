//
//  UIView+RITLBorder.m
//  RITLBorder
//
//  Created by YueWen on 2018/1/11.
//  Copyright © 2018年 YueWen. All rights reserved.
//

#import "UIView+RITLBorder.h"
#import <Foundation/Foundation.h>
#import <objc/runtime.h>

#pragma mark - RITLBorderLayer

@interface RITLBorderLayer: CALayer

/// 默认为0.0
@property (nonatomic, assign)CGFloat ritl_borderWidth;
/// 默认为UIEdgeInsetsZero
@property (nonatomic, assign)UIEdgeInsets ritl_borderInset;

@end

@implementation RITLBorderLayer

- (instancetype)init
{
    if (self = [super init]) {
        
        self.anchorPoint = CGPointZero;
        self.ritl_borderWidth = 0.0;
        self.ritl_borderInset = UIEdgeInsetsZero;
    }
    
    return self;
}

@end


#pragma mark - <RITLViewBorderDirection>

@protocol RITLViewBorderDirection <NSObject>

@property (nonatomic, strong) RITLBorderLayer *leftLayer;
@property (nonatomic, strong) RITLBorderLayer *topLayer;
@property (nonatomic, strong) RITLBorderLayer *rightLayer;
@property (nonatomic, strong) RITLBorderLayer *bottomLayer;

@end



#pragma mark - UIView<RITLViewBorderDirection>
@interface UIView (RITLViewBorderDirection)<RITLViewBorderDirection>
@end


#pragma mark - UIView(RITLBorder)
@implementation UIView (RITLBorder)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Method originMethod = class_getInstanceMethod(self, @selector(layoutSubviews));
        Method swizzledMethod = class_getInstanceMethod(self, @selector(ritl_borderlayoutsubViews));
        
        BOOL didAddMethod = class_addMethod(self, @selector(layoutSubviews), method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {//追加成功，进行替换
            
            class_replaceMethod(self,
                                @selector(layoutSubviews),
                                method_getImplementation(swizzledMethod),
                                method_getTypeEncoding(swizzledMethod));
        }else {
            
            method_exchangeImplementations(originMethod, swizzledMethod);
        }
    });
}



- (void)ritl_borderlayoutsubViews
{
    [self ritl_borderlayoutsubViews];

    CGRect generalBound = self.leftLayer.bounds;
    CGPoint generalPoint = CGPointZero;
    UIEdgeInsets generalInset = self.leftLayer.ritl_borderInset;
    
    //left
    generalBound.size.height = self.layer.bounds.size.height - generalInset.top - generalInset.bottom;//高度
    generalBound.size.width = self.leftLayer.ritl_borderWidth;//宽度为border
    self.leftLayer.bounds = generalBound;
    
    generalPoint.x = generalInset.left;
    generalPoint.y = generalInset.top;
    self.leftLayer.position = generalPoint;
    
    generalBound = self.topLayer.bounds;
    generalPoint = self.topLayer.position;
    generalInset = self.topLayer.ritl_borderInset;
    
    //top
    generalBound.size.height = self.topLayer.ritl_borderWidth;
    generalBound.size.width = self.layer.bounds.size.width - generalInset.left - generalInset.right;
    self.topLayer.bounds = generalBound;
    
    generalPoint.x = generalInset.left;
    generalPoint.y = generalInset.top;
    self.topLayer.position = generalPoint;
    
    generalBound = self.rightLayer.bounds;
    generalPoint = self.rightLayer.position;
    generalInset = self.rightLayer.ritl_borderInset;
    
    //right
    generalBound.size.height = self.layer.bounds.size.height - generalInset.top - generalInset.bottom;
    generalBound.size.width = self.rightLayer.ritl_borderWidth;
    self.rightLayer.bounds = generalBound;
    
    generalPoint.x = self.layer.bounds.size.width - generalInset.right - generalBound.size.width;
    generalPoint.y = generalInset.top;
    self.rightLayer.position = generalPoint;
    
    generalBound = self.bottomLayer.bounds;
    generalPoint = self.bottomLayer.position;
    generalInset = self.bottomLayer.ritl_borderInset;
    
    //bottom
    generalBound.size.height = self.bottomLayer.ritl_borderWidth;
    generalBound.size.width = self.layer.bounds.size.width - generalInset.right - generalInset.left;
    self.bottomLayer.bounds = generalBound;
    
    generalPoint.x = generalInset.left;
    generalPoint.y = self.layer.bounds.size.height - generalInset.bottom - generalBound.size.height;
    self.bottomLayer.position = generalPoint;
}





#pragma mark - public

- (void)ritl_addBorderWithInset:(UIEdgeInsets)inset
                          Color:(UIColor *)borderColor
                      direction:(RITLBorderDirection)directions
{
    [self ritl_addBorderWithInset:inset Color:borderColor BorderWidth:self.layer.borderWidth direction:directions];
}


- (void)ritl_addBorderWithInset:(UIEdgeInsets)inset
                    BorderWidth:(CGFloat)borderWidth
                      direction:(RITLBorderDirection)directions
{
    [self ritl_addBorderWithInset:inset Color:[UIColor colorWithCGColor:self.layer.borderColor] BorderWidth:borderWidth direction:directions];
}


- (void)ritl_addBorderWithColor:(UIColor *)borderColor
                    BodrerWidth:(CGFloat)borderWidth
                      direction:(RITLBorderDirection)directions
{
    [self ritl_addBorderWithInset:UIEdgeInsetsZero Color:borderColor BorderWidth:borderWidth direction:directions];
}


- (void)ritl_addBorderWithInset:(UIEdgeInsets)inset
                          Color:(UIColor *)borderColor
                    BorderWidth:(CGFloat)borderWidth
                      direction:(RITLBorderDirection)directions
{
    if (directions & RITLBorderDirectionLeft) {
        
        self.leftLayer.backgroundColor = borderColor.CGColor;
        self.leftLayer.ritl_borderWidth = borderWidth;
        self.leftLayer.ritl_borderInset = inset;
        if (self.leftLayer.superlayer) { [self.leftLayer removeFromSuperlayer]; }
        [self.layer addSublayer:self.leftLayer];
    }
    
    if (directions & RITLBorderDirectionTop) {
        
        self.topLayer.backgroundColor = borderColor.CGColor;
        self.topLayer.ritl_borderWidth = borderWidth;
        self.topLayer.ritl_borderInset = inset;
        if (self.topLayer.superlayer) { [self.topLayer removeFromSuperlayer]; }
        [self.layer addSublayer:self.topLayer];
    }
    
    if (directions & RITLBorderDirectionRight) {
        
        self.rightLayer.backgroundColor = borderColor.CGColor;
        self.rightLayer.ritl_borderWidth = borderWidth;
        self.rightLayer.ritl_borderInset = inset;
        if (self.rightLayer.superlayer) { [self.rightLayer removeFromSuperlayer]; }
        [self.layer addSublayer:self.rightLayer];
    }
    
    if (directions & RITLBorderDirectionBottom) {
        
        self.bottomLayer.backgroundColor = borderColor.CGColor;
        self.bottomLayer.ritl_borderWidth = borderWidth;
        self.bottomLayer.ritl_borderInset = inset;
        if (self.bottomLayer.superlayer) { [self.bottomLayer removeFromSuperlayer]; }
        [self.layer addSublayer:self.bottomLayer];
    }
    
    [self setNeedsLayout];
}



- (void)ritl_removeBorders:(RITLBorderDirection)directions
{
    if (directions & RITLBorderDirectionLeft) {
        
        [self ritl_removeBorderLayer:self.leftLayer];
    }
    
    if (directions & RITLBorderDirectionTop) {
        
        [self ritl_removeBorderLayer:self.topLayer];
    }
    
    if (directions & RITLBorderDirectionRight) {
        
        [self ritl_removeBorderLayer:self.rightLayer];
    }
    
    if (directions & RITLBorderDirectionBottom) {
        
        [self ritl_removeBorderLayer:self.bottomLayer];
    }
}

- (void)ritl_removeAllBorders
{
    [self ritl_removeBorderLayer:self.leftLayer];
    [self ritl_removeBorderLayer:self.topLayer];
    [self ritl_removeBorderLayer:self.rightLayer];
    [self ritl_removeBorderLayer:self.bottomLayer];
}



#pragma mark - private

- (void)ritl_removeBorderLayer:(CALayer *)layer
{
    if (layer) {
        
        [layer removeFromSuperlayer];
    }
}

//
//- (BOOL)ritl_checkLayer:(CALayer *)layer
//{
//    return layer.superlayer;
//}


#pragma mark - RITLViewBorderDirection


#pragma mark - layer

- (void)setLeftLayer:(RITLBorderLayer *)leftLayer
{
    objc_setAssociatedObject(self, @selector(leftLayer), leftLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setTopLayer:(RITLBorderLayer *)topLayer
{
    objc_setAssociatedObject(self, @selector(topLayer), topLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setRightLayer:(RITLBorderLayer *)rightLayer
{
    objc_setAssociatedObject(self, @selector(rightLayer), rightLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setBottomLayer:(RITLBorderLayer *)bottomLayer
{
    objc_setAssociatedObject(self, @selector(bottomLayer), bottomLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (RITLBorderLayer *)leftLayer
{
    id layer = objc_getAssociatedObject(self, _cmd);

    if (layer == nil) {

        self.leftLayer = RITLBorderLayer.new;
    }

    return objc_getAssociatedObject(self, _cmd);
}


- (RITLBorderLayer *)topLayer
{
    id layer = objc_getAssociatedObject(self, _cmd);

    if (layer == nil) {

        self.topLayer = RITLBorderLayer.new;
    }

    return objc_getAssociatedObject(self, _cmd);
}


- (RITLBorderLayer *)rightLayer
{
    id layer = objc_getAssociatedObject(self, _cmd);

    if (layer == nil) {

        self.rightLayer = RITLBorderLayer.new;
    }

    return objc_getAssociatedObject(self, _cmd);
}


- (RITLBorderLayer *)bottomLayer
{
    id layer = objc_getAssociatedObject(self, _cmd);

    if (layer == nil) {

        self.bottomLayer = RITLBorderLayer.new;
    }

    return objc_getAssociatedObject(self, _cmd);
}

@end
