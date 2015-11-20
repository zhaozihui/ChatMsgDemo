//
//  ViewController.m
//  ChatMsgDemo
//
//  Created by 赵子辉 on 15/11/20.
//  Copyright © 2015年 zhaozihui. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ViewController
{
    NSArray *msgs;
    
}
@synthesize listView;
- (void)viewDidLoad {
    [super viewDidLoad];
    msgs = @[@"短",@"很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长",@"demo_avatar_cook",@"demo_avatar_jobs"];
    listView.delegate = self;
    listView.dataSource = self;
    listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
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


@end
