# UIView-RITLBorder
为UIView追加单向border, 适配autoLayout

```
pod 'UIView+RITLBorders'

//如果 pod install 不能安装，请使用pod update 尝试
```


使用比较简单

- 提供的对外接口

```
/// 提供了一些比较通用的对外方法
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

```

<div align="center"><img src="https://github.com/RITL/UIView-RITLBorder/blob/master/Assets/PreView.png" height=500></img></div>


- Demo中实现的代码:
```
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    #pragma mark - SimpleBorder
    [self.left ritl_addBorderWithColor:UIColor.blackColor BodrerWidth:5 direction:RITLBorderDirectionLeft];
    
    
    [self.top ritl_addBorderWithColor:UIColor.orangeColor BodrerWidth:5 direction:RITLBorderDirectionTop];
    
    
    [self.right ritl_addBorderWithColor:UIColor.greenColor BodrerWidth:5 direction:RITLBorderDirectionRight];
    
    
    [self.bottom ritl_addBorderWithColor:UIColor.yellowColor BodrerWidth:5 direction:RITLBorderDirectionBottom];
    
    
    #pragma mark -
    [self.leftRight ritl_addBorderWithColor:UIColor.cyanColor BodrerWidth:5 direction:RITLBorderDirectionLeft|RITLBorderDirectionRight];
    
    [self.topBottom ritl_addBorderWithColor:UIColor.purpleColor BodrerWidth:4 direction:RITLBorderDirectionTop|RITLBorderDirectionBottom];
    
    
    [self.custom ritl_addBorderWithColor:UIColor.orangeColor BodrerWidth:2 direction:RITLBorderDirectionLeft];
    [self.custom ritl_addBorderWithColor:UIColor.blueColor BodrerWidth:1 direction:RITLBorderDirectionTop];
    [self.custom ritl_addBorderWithColor:UIColor.redColor BodrerWidth:3 direction:RITLBorderDirectionBottom];
    
}
```
