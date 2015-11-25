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
    ZLCustomeSegmentControlView *v = [[ZLCustomeSegmentControlView alloc] initWithFrame:CGRectMake(30, 100, SCREEN_WIDTH - 60, 50)];
    
    v.titles = @[@"Hello", @"Apple", @"Swift", @"Objc"];
    v.duration = 0.7f;
    
    [v setButtonOnClickBlock:^(NSInteger tag, NSString *title) {
        NSLog(@"index = %ld, title = %@", (long)tag, title);
    }];
    
    [self.view addSubview:v];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
