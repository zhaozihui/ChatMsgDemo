//
//  ViewController.h
//  ChatMsgDemo
//
//  Created by 赵子辉 on 15/11/20.
//  Copyright © 2015年 zhaozihui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Util.h"
#import "MessageCell.h"
@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *listView;
@property (weak, nonatomic) IBOutlet MessageCell *cell;
@property (weak, nonatomic) IBOutlet UILabel *lableTxt;

@end

