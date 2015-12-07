//
//  BottomInputView.h
//  ChatMsgDemo
//
//  Created by 赵子辉 on 15/12/4.
//  Copyright © 2015年 zhaozihui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BottomInputView : UIView<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *inputField;
@property (retain, nonatomic) IBOutlet UIView *emojiView;
@property (retain, nonatomic) IBOutlet UIView *plusView;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIButton *emojiBtn;
+(instancetype)initView;
- (void)resetFameKeyboardWillShow:(NSDictionary *)dic;
- (void)resetFameKeyboardWillHide:(NSDictionary *)dic;
@end
