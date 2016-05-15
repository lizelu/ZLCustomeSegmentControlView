//
//  ViewController.m
//  CustomeSegmentControl
//
//  Created by ZeluLi on 15/11/19.
//  Copyright © 2015年 zeluli. All rights reserved.
//
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

#import "ViewController.h"
#import "ZLCustomeSegmentControlView.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *myView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ZLCustomeSegmentControlView *v = [[ZLCustomeSegmentControlView alloc] init];
    
    v.titles = @[@"Hello", @"Apple", @"Swift", @"Objc"];
    v.duration = 0.7f;
    
    [v setButtonOnClickBlock:^(NSInteger tag, NSString *title) {
        NSLog(@"index = %ld, title = %@", (long)tag, title);
    }];
    
    
    [self.view addSubview:v];
    [self addLayout:v];
    
 }

- (void)addLayout: (UIView *)v {
    v.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint
                                         constraintWithItem:v
                                         attribute:NSLayoutAttributeTop
                                         relatedBy:NSLayoutRelationEqual
                                         toItem:self.view
                                         attribute:NSLayoutAttributeTop
                                         multiplier:1
                                         constant:50];
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint
                                          constraintWithItem:v
                                          attribute:NSLayoutAttributeLeft
                                          relatedBy:NSLayoutRelationEqual
                                          toItem:self.view
                                          attribute:NSLayoutAttributeLeft
                                          multiplier:1
                                          constant:20];
    NSLayoutConstraint *rigthConstraint = [NSLayoutConstraint
                                           constraintWithItem:v
                                           attribute:NSLayoutAttributeRight
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.view
                                           attribute:NSLayoutAttributeRight
                                           multiplier:1
                                           constant:-20];
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint
                                            constraintWithItem:v
                                            attribute:NSLayoutAttributeHeight
                                            relatedBy:NSLayoutRelationEqual
                                            toItem:nil
                                            attribute:NSLayoutAttributeHeight
                                            multiplier:1
                                            constant:60];
    [v addConstraint:heightConstraint];
    [self.view addConstraints:@[topConstraint, leftConstraint,rigthConstraint]];
    


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
