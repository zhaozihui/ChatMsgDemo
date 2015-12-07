//
//  ViewController.m
//  ChatMsgDemo
//
//  Created by 赵子辉 on 15/11/20.
//  Copyright © 2015年 zhaozihui. All rights reserved.
//

#import "ViewController.h"
#import "BottomInputView.h"
#define FRAME_SIZE [[UIScreen mainScreen] bounds].size
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ViewController
{
    NSArray *msgs;
    BottomInputView *inputView;
    
}
@synthesize listView,lableTxt;
- (void)viewDidLoad {
    [super viewDidLoad];
    msgs = @[@"短[微笑][微笑][微笑][微笑][微笑][微笑][微笑][微笑][微笑]",@"很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很[微笑]长[微笑][微笑][微笑][微笑][微笑]很长很长很长很长很长很长很长[微笑]很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很[微笑][微笑]长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长[微笑]",@"demo_avatar_cook",@"a2.jpg",@"a4.jpg"];
    listView.frame = CGRectMake(0, 0, FRAME_SIZE.width, FRAME_SIZE.height - 44);
    listView.delegate = self;
    listView.dataSource = self;
    listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    inputView = [BottomInputView initView];
   
    
    
    [self.view addSubview:inputView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillhide:) name:UIKeyboardWillHideNotification object:nil];
    
    UITapGestureRecognizer *grAll = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                    action:@selector(view_TouchDown:)];
    grAll.cancelsTouchesInView = NO;
    [listView addGestureRecognizer:grAll];

}
- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    [inputView resetFameKeyboardWillShow:info];
}


- (void)keyboardWillhide:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    [inputView resetFameKeyboardWillHide:info];
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.cell.height + 8;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [msgs count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BOOL left = NO;
    if ([indexPath row]%2==0) {
        left = YES;
    }
    MessageCell *cell = [MessageCell initCellWithTableView:tableView isLeft:left];
    self.cell = cell;
    NSString *type = @"txt";
    if([indexPath row] >1 )
    {
        type = @"img";
    }
    [cell setMsg:msgs[[indexPath row]] type:type];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)view_TouchDown:(id)sender {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}


@end
