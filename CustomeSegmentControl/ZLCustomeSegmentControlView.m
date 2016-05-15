//
//  ZLCustomeSegmentControlView.m
//  CustomeSegmentControl
//
//  Created by ZeluLi on 15/11/19.
//  Copyright © 2015年 zeluli. All rights reserved.
//

#define DEFAULT_TITLES_FONT 20.0f
#define DEFAULT_DURATION 3.0f

#import "ZLCustomeSegmentControlView.h"

@interface ZLCustomeSegmentControlView()

@property (nonatomic, assign) CGFloat viewWidth;                    //组件的宽度
@property (nonatomic, assign) CGFloat viewHeight;                   //组件的高度
@property (nonatomic, assign) CGFloat labelWidth;                   //Label的宽度

@property (nonatomic, strong) UIView * heightLightView;
@property (nonatomic, strong) UIView * heightTopView;
@property (nonatomic, strong) UIView * heightColoreView;

@property (nonatomic, strong) NSMutableArray * labelMutableArray;
@property (nonatomic, strong) ButtonOnClickBlock buttonBlock;

@property (nonatomic, strong) UIButton * currentTapButton;

@end

@implementation ZLCustomeSegmentControlView
- (instancetype)init
{
    self = [super init];
    if (self) {
         _duration = DEFAULT_DURATION;
    }
    return self;
}

- (void)layoutSubviews{
    
    _viewWidth = super.frame.size.width;
    _viewHeight = super.frame.size.height;
    
    [self removeAllSubView];
    

    [self customeData];
    [self createBottomLabels];
    [self createTopLables];
    [self createTopButtons];
    
    [self layoutIfNeeded];
    
    if (_currentTapButton != nil) {
        [self tapButton:_currentTapButton];
    }


}

-(void) setButtonOnClickBlock: (ButtonOnClickBlock) block {
    if (block) {
        _buttonBlock = block;
    }
}

- (void)removeAllSubView {
    if (_heightColoreView != nil) {
        [self removeSubView:_heightLightView];
        [self removeSubView:_heightTopView];
        [self removeSubView:_heightColoreView];
        [self.labelMutableArray removeAllObjects];
        
        for (UIView *view in self.subviews) {
            [view removeFromSuperview];
        }
    }
    
}

- (void)removeSubView: (UIView *) subView {
    [subView removeFromSuperview];
    subView = nil;
}


/**
 *  提供默认值
 */
- (void)customeData {
    if (_titles == nil) {
        _titles = @[@"Test0", @"Test1", @"Test2"];
    }
    
    if (_titlesCustomeColor == nil) {
        _titlesCustomeColor = [UIColor blackColor];
    }
    
    if (_titlesHeightLightColor == nil) {
        _titlesHeightLightColor = [UIColor whiteColor];
    }
    
    if (_backgroundHeightLightColor == nil) {
        _backgroundHeightLightColor = [UIColor redColor];
    }
    
    if (_titlesFont == nil) {
        _titlesFont = [UIFont systemFontOfSize:DEFAULT_TITLES_FONT];
    }
    
    if (_labelMutableArray == nil) {
        _labelMutableArray = [[NSMutableArray alloc] initWithCapacity:_titles.count];
    }
    _labelWidth = _viewWidth / _titles.count;
    
}

/**
 *  计算当前高亮的Frame
 *
 *  @param index 当前点击按钮的Index
 *
 *  @return 返回当前点击按钮的Frame
 */
- (CGRect) countCurrentRectWithIndex: (NSInteger) index {
     return  CGRectMake(_labelWidth * index, 0, _labelWidth, _viewHeight);
}

/**
 *  根据索引创建Label
 *
 *  @param index     创建的第几个Index
 *  @param textColor Label字体颜色
 *
 *  @return 返回创建好的label
 */
- (UILabel *) createLabelWithTitlesIndex: (NSInteger) index
                              textColor: (UIColor *) textColor {
    CGRect currentLabelFrame = [self countCurrentRectWithIndex:index];
    UILabel *tempLabel = [[UILabel alloc] initWithFrame:currentLabelFrame];
    tempLabel.textColor = textColor;
    tempLabel.text = _titles[index];
    tempLabel.font = _titlesFont;
    tempLabel.minimumScaleFactor = 0.1f;
    tempLabel.textAlignment = NSTextAlignmentCenter;
    return tempLabel;
}

/**
 *  创建最底层的Label
 */
- (void) createBottomLabels {
    for (int i = 0; i < _titles.count; i ++) {
        UILabel *tempLabel = [self createLabelWithTitlesIndex:i textColor:_titlesCustomeColor];
        [self addSubview:tempLabel];
        [_labelMutableArray addObject:tempLabel];
    }
}

/**
 *  创建上一层高亮使用的Label
 */
- (void) createTopLables {
    CGRect heightLightViewFrame = CGRectMake(0, 0, _labelWidth, _viewHeight);
    _heightLightView = [[UIView alloc] initWithFrame:heightLightViewFrame];
    _heightLightView.clipsToBounds = YES;
    
    _heightColoreView = [[UIView alloc] initWithFrame:heightLightViewFrame];
    _heightColoreView.backgroundColor = _backgroundHeightLightColor;
    _heightColoreView.layer.cornerRadius = 20;
    [_heightLightView addSubview:_heightColoreView];
    
    _heightTopView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, _viewWidth, _viewHeight)];
    for (int i = 0; i < _titles.count; i ++) {
        UILabel *label = [self createLabelWithTitlesIndex:i textColor:_titlesHeightLightColor];
        [_heightTopView addSubview:label];
    }
    [_heightLightView addSubview:_heightTopView];
    [self addSubview:_heightLightView];
}

/**
 *  创建按钮
 */
- (void) createTopButtons {
    for (int i = 0; i < _titles.count; i ++) {
        CGRect tempFrame = [self countCurrentRectWithIndex:i];
        UIButton *tempButton = [[UIButton alloc] initWithFrame:tempFrame];
        tempButton.tag = i;
        [tempButton addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:tempButton];
    }
}

/**
 *  点击按钮事件
 *
 *  @param sender 点击的相应的按钮
 */
- (void)tapButton:(UIButton *) sender {
    
    
    _currentTapButton = sender;
    if (_buttonBlock && sender.tag < _titles.count) {
        _buttonBlock(sender.tag, _titles[sender.tag]);
    }
    
    CGRect frame = [self countCurrentRectWithIndex:sender.tag];
    CGRect changeFrame = [self countCurrentRectWithIndex:-sender.tag];
    
    __weak typeof(self) weak_self = self;
    [UIView animateWithDuration:_duration animations:^{
        _heightLightView.frame = frame;
        _heightTopView.frame = changeFrame;
    } completion:^(BOOL finished) {
        [weak_self shakeAnimationForView:_heightColoreView];
    }];
}

/**
 *  抖动效果
 *
 *  @param view 要抖动的view
 */
- (void)shakeAnimationForView:(UIView *) view {
    CALayer *viewLayer = view.layer;
    CGPoint position = viewLayer.position;
    CGPoint x = CGPointMake(position.x + 1, position.y);
    CGPoint y = CGPointMake(position.x - 1, position.y);
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    [animation setAutoreverses:YES];
    [animation setDuration:.06];
    [animation setRepeatCount:3];
    [viewLayer addAnimation:animation forKey:nil];
}

@end
