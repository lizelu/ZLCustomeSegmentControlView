//
//  ZLCustomeSegmentControlView.h
//  CustomeSegmentControl
//
//  Created by ZeluLi on 15/11/19.
//  Copyright © 2015年 zeluli. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonOnClickBlock)(NSInteger tag, NSString * title);

@interface ZLCustomeSegmentControlView : UIView

@property (nonatomic, strong) NSArray *titles;                      //标题数组
@property (nonatomic, strong) UIColor *titlesCustomeColor;          //标题的常规颜色
@property (nonatomic, strong) UIColor *titlesHeightLightColor;      //标题高亮颜色
@property (nonatomic, strong) UIColor *backgroundHeightLightColor;  //高亮时的颜色
@property (nonatomic, strong) UIFont *titlesFont;                   //标题的字号
@property (nonatomic, assign) CGFloat duration;                     //运动时间

/**
 *  点击按钮的回调
 *
 *  @param block 点击按钮的Block
 */
-(void) setButtonOnClickBlock: (ButtonOnClickBlock) block;

@end
