//
//  BottomInputView.m
//  ChatMsgDemo
//
//  Created by 赵子辉 on 15/12/4.
//  Copyright © 2015年 zhaozihui. All rights reserved.
//

#import "BottomInputView.h"

@implementation BottomInputView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(instancetype)initView
{
    static NSString * identifier = @"BottomInputView";
    NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil];
    BottomInputView *inputView = [subviewArray objectAtIndex:0];
    return inputView;
}
@end
