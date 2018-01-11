//
//  ViewController.m
//  RITLBorder
//
//  Created by YueWen on 2018/1/11.
//  Copyright © 2018年 YueWen. All rights reserved.
//

#import "ViewController.h"
#import "UIView+RITLBorder.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *left;
@property (weak, nonatomic) IBOutlet UILabel *top;
@property (weak, nonatomic) IBOutlet UILabel *right;
@property (weak, nonatomic) IBOutlet UILabel *bottom;

@property (weak, nonatomic) IBOutlet UILabel *leftRight;
@property (weak, nonatomic) IBOutlet UILabel *topBottom;
@property (weak, nonatomic) IBOutlet UILabel *custom;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    #pragma mark - SimpleBorder
    [self.left ritl_addBorderWithColor:UIColor.blackColor BodrerWidth:2 direction:RITLBorderDirectionLeft];
    
    
    [self.top ritl_addBorderWithColor:UIColor.orangeColor BodrerWidth:2 direction:RITLBorderDirectionTop];
    
    
    [self.right ritl_addBorderWithColor:UIColor.greenColor BodrerWidth:2 direction:RITLBorderDirectionRight];
    
    
    [self.bottom ritl_addBorderWithColor:UIColor.yellowColor BodrerWidth:2 direction:RITLBorderDirectionBottom];
    
    
    #pragma mark -
    [self.leftRight ritl_addBorderWithColor:UIColor.cyanColor BodrerWidth:2 direction:RITLBorderDirectionLeft|RITLBorderDirectionRight];
    
    [self.topBottom ritl_addBorderWithColor:UIColor.purpleColor BodrerWidth:2 direction:RITLBorderDirectionTop|RITLBorderDirectionBottom];
    
    
    [self.custom ritl_addBorderWithColor:UIColor.orangeColor BodrerWidth:1.5 direction:RITLBorderDirectionLeft];
    [self.custom ritl_addBorderWithColor:UIColor.blueColor BodrerWidth:1 direction:RITLBorderDirectionTop];
    [self.custom ritl_addBorderWithColor:UIColor.redColor BodrerWidth:2 direction:RITLBorderDirectionBottom];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
