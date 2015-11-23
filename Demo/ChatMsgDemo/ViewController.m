//
//  ViewController.m
//  ChatMsgDemo
//
//  Created by 赵子辉 on 15/11/20.
//  Copyright © 2015年 zhaozihui. All rights reserved.
//

#import "ViewController.h"
#import "FaceAndText.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ViewController
{
    NSArray *msgs;
    
}
@synthesize listView,lableTxt;
- (void)viewDidLoad {
    [super viewDidLoad];
    msgs = @[@"短[微笑][微笑][微笑][微笑][微笑][微笑][微笑][微笑][微笑]",@"很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很[微笑]长[微笑][微笑][微笑][微笑][微笑]很长很长很长很长很长很长很长[微笑]很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很[微笑][微笑]长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长[微笑]",@"demo_avatar_cook",@"demo_avatar_jobs"];
    listView.delegate = self;
    listView.dataSource = self;
    listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    

    FaceAndText *faceText = [[FaceAndText alloc] init];

    lableTxt.attributedText = [faceText getAttributedStringFromText:@"123412[可爱]345[哼]67891[哼]234567891[哼][微笑][微笑][微笑][微笑]2345678912345678956789[微笑]"font:[UIFont systemFontOfSize:15] emojiSize:CGSizeMake(32, 32)];
    [lableTxt sizeToFit];
    
    
//    lableTxt.frame = CGRectMake(52, 72, 200, rect.size.height);
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(52, 72, lableTxt.frame.size.width, lableTxt.frame.size.height)];
    bg.layer.borderColor = [UIColor redColor].CGColor;
    bg.layer.borderWidth = 1;
    [self.view addSubview:bg];
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
