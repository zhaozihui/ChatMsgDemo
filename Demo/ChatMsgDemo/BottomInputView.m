//
//  BottomInputView.m
//  ChatMsgDemo
//
//  Created by 赵子辉 on 15/12/4.
//  Copyright © 2015年 zhaozihui. All rights reserved.
//

#import "BottomInputView.h"
#import "FaceAndText.h"
#define FRAME_SIZE [[UIScreen mainScreen] bounds].size
#define EMOJI_VIEW_HEIGHT  200
@implementation BottomInputView


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
@synthesize inputField,emojiView,plusView,addBtn,emojiBtn;

+(instancetype)initView
{
    static NSString * identifier = @"BottomInputView";
    NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil];
    BottomInputView *inputView = [subviewArray objectAtIndex:0];
    inputView.frame = CGRectMake(0, FRAME_SIZE.height - 44, FRAME_SIZE.width ,44);
    return inputView;
}
- (void)resetFameKeyboardWillShow:(NSDictionary *)dic
{
    NSValue *value = [dic objectForKey:@"UIKeyboardFrameEndUserInfoKey"];
    CGSize keyboardSize = [value CGRectValue].size;//获取键盘的size值
    //获取键盘出现的动画时间
    NSValue *animationDurationValue = [dic objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    CGFloat startY =FRAME_SIZE.height-keyboardSize.height - 44;
    
    NSTimeInterval animation = animationDuration;
    [UIView animateWithDuration:animation animations:^{
        self.frame = CGRectMake(0, startY, FRAME_SIZE.width ,44);
    }];
    
}
- (void)resetFameKeyboardWillHide:(NSDictionary *)dic
{
    if (addBtn.isSelected || emojiBtn.isSelected) {
        return;
    }
    //获取键盘出现的动画时间
    NSValue *animationDurationValue = [dic objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    NSTimeInterval animation = animationDuration;
    //视图移动的动画开始
    
    [UIView animateWithDuration:animation animations:^{
        self.frame = CGRectMake(0, FRAME_SIZE.height - 44, FRAME_SIZE.width ,44);
    }];

}
- (IBAction)addOtherBtn:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (!btn.isSelected) {
        [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
        [emojiView removeFromSuperview];
        [self addPlusView];
        [btn setSelected:YES];
        [emojiBtn setSelected:NO];
    } else {
        [plusView removeFromSuperview];
        self.frame = CGRectMake(0, FRAME_SIZE.height - 44, FRAME_SIZE.width ,44);
        [btn setSelected:NO];
    }
}
- (IBAction)addEmoji:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (!btn.isSelected) {
        [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
        [plusView removeFromSuperview];
        [self addEmojiView];
        [btn setSelected:YES];
        [addBtn setSelected:NO];
    } else {
        [emojiView removeFromSuperview];
        self.frame = CGRectMake(0, FRAME_SIZE.height - 44, FRAME_SIZE.width ,44);
        [btn setSelected:NO];
    }
    
}
- (void)addPlusView
{
    plusView = [[UIView alloc] init];
    plusView.frame = CGRectMake(0, 44, FRAME_SIZE.width, EMOJI_VIEW_HEIGHT);
    plusView.backgroundColor = [UIColor whiteColor];
    NSMutableArray *btnItems = [[NSMutableArray alloc] initWithObjects:@{@"name":@"图片",@"image":@"add_picture"},@{@"name":@"地理位置",@"image":@"add_address"}, nil];
    
    CGFloat space=(FRAME_SIZE.width-60*4)/5;
    CGFloat btnWidth=60;
    for (int i=0; i<btnItems.count; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        int x=i%4;
        int y=i/4;
        [btn setFrame:CGRectMake(space+x*(space+btnWidth), space+y*(space+btnWidth+25), btnWidth, btnWidth)];
        [btn setImage:[UIImage imageNamed:[[btnItems objectAtIndex:i] objectForKey:@"image"]] forState:UIControlStateNormal];
        btn.tag=200+i;
        [btn addTarget:self action:@selector(btnClciked:) forControlEvents:UIControlEventTouchUpInside];
        [plusView addSubview:btn];
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(btn.frame.origin.x, btn.frame.origin.y+5 + btnWidth, btnWidth, 20)];
        label.text=[[btnItems objectAtIndex:i] objectForKey:@"name"];
        label.textAlignment=NSTextAlignmentCenter;
        label.font= [UIFont systemFontOfSize:13];
        label.textColor=[UIColor grayColor];
        [plusView addSubview:label];
    }
    [self addSubview:plusView];
    self.frame = CGRectMake(0, FRAME_SIZE.height - EMOJI_VIEW_HEIGHT - 44, FRAME_SIZE.width, EMOJI_VIEW_HEIGHT + 44);

}

- (void)addEmojiView
{
    emojiView = [[UIView alloc] init];
    emojiView.backgroundColor = [UIColor whiteColor];
    emojiView.frame = CGRectMake(0, 44, FRAME_SIZE.width, EMOJI_VIEW_HEIGHT);
    UIScrollView *_scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, FRAME_SIZE.width, EMOJI_VIEW_HEIGHT)];
    _scrollView.tag = 100;
    _scrollView.backgroundColor=[UIColor clearColor];
    _scrollView.pagingEnabled=YES;
    _scrollView.bounces=NO;
    _scrollView.delegate=self;
    _scrollView.showsVerticalScrollIndicator=NO;
    _scrollView.showsHorizontalScrollIndicator=NO;
    [emojiView addSubview:_scrollView];
    
    FaceAndText *face = [[FaceAndText alloc] init];
    NSDictionary *dic =  [face getFace];
    NSInteger pageCount = [[dic allKeys] count]/24;
    NSInteger lastCount = [[dic allKeys] count]%24;
    _scrollView.contentSize=CGSizeMake((pageCount+1)*FRAME_SIZE.width, EMOJI_VIEW_HEIGHT);
    for (int i=0; i<= pageCount; i++) {
        //
        NSRange rang;
        if (i == pageCount) {
            rang = NSMakeRange(i*24, lastCount);
        } else {
            rang = NSMakeRange(i*24, 24);
        }
        NSArray *names = [[dic allKeys] subarrayWithRange:rang];
        UIView *scrollSubView = [[UIView alloc] initWithFrame:CGRectMake(FRAME_SIZE.width*i, 0, FRAME_SIZE.width, EMOJI_VIEW_HEIGHT)];
        for (int j =0 ; j<[names count]; j++) {
            CGFloat imageWidht=30;
            CGFloat imageHeight=30;
            CGFloat widhtSpace=(FRAME_SIZE.width-20-8*imageWidht)/9;
            CGFloat heightSpace=(EMOJI_VIEW_HEIGHT-3*imageHeight)/4;
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            [btn setFrame:CGRectMake(10+widhtSpace+j%8*(imageWidht+widhtSpace),10 + j/8*(imageHeight+heightSpace), imageWidht, imageHeight)];
            [btn setImage:[UIImage imageNamed:[dic objectForKey:names[j]]] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:[dic objectForKey:names[j]]] forState:UIControlStateHighlighted];
            [btn addTarget:self action:@selector(emojiBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag=i*24+j;
            [scrollSubView addSubview:btn];
            
        }
        [_scrollView addSubview:scrollSubView];
    }
    UIPageControl *_pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(0, EMOJI_VIEW_HEIGHT - 10, FRAME_SIZE.width, 10)];
    _pageControl.numberOfPages = pageCount;
    _pageControl.currentPage=0;
    _pageControl.tag = 101;
    
    [emojiView addSubview:_pageControl];
    [self addSubview:emojiView];
    
    self.frame = CGRectMake(0, FRAME_SIZE.height - EMOJI_VIEW_HEIGHT - 44, FRAME_SIZE.width, EMOJI_VIEW_HEIGHT + 44);
}
- (void)btnClciked:(UIButton *)btn
{
    NSLog(@"index:%d",btn.tag);
}
- (void)emojiBtnClicked:(UIButton *)btn
{
    NSLog(@"index:%d",btn.tag);
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGPoint point=scrollView.contentOffset;
    int index=point.x/FRAME_SIZE.width;
    UIPageControl *pageControl = (UIPageControl*)[emojiView viewWithTag:101];
    pageControl.currentPage=index;
}
- (IBAction)sendBtn:(id)sender {
}

@end
