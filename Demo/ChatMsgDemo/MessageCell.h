//
//  MessageCell.h
//  ChatMsgDemo
//
//  Created by 赵子辉 on 15/11/20.
//  Copyright © 2015年 zhaozihui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Util.h"
@interface MessageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *msgBtn;
@property (weak, nonatomic) IBOutlet UIImageView *iconImg;
@property (assign, nonatomic) float height;
+(instancetype)initCellWithTableView:(UITableView *)tableView isLeft:(BOOL) left;
- (void)setMsg:(NSString *)message type:(NSString *)type;
@end
