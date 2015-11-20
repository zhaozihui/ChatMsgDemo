//
//  MessageCell.m
//  ChatMsgDemo
//
//  Created by 赵子辉 on 15/11/20.
//  Copyright © 2015年 zhaozihui. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell
@synthesize msgBtn,height,iconImg;
- (void)awakeFromNib {
    // Initialization code
    msgBtn.titleEdgeInsets = UIEdgeInsetsMake(17, 15, 17, 15);
   // msgBtn.imageEdgeInsets = UIEdgeInsetsMake(17, 15, 17, 15);
}
+(instancetype)initCellWithTableView:(UITableView *)tableView isLeft:(BOOL) left{
    
    NSString * identifier = @"MessageLeftCell";
    if (!left) {
        identifier = @"MessageRightCell";
    }
    MessageCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:identifier owner:nil options:nil] firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (void)setMsg:(NSString *)message type:(NSString *)type
{
    if([type isEqualToString:@"img"])
    {
        UIImage *image = [UIImage imageNamed:@"demo_avatar_cook"];
        CGRect frame = msgBtn.frame;
        frame.size.height = 150 + 17*2;
        frame.size.width = 150 + 15*2;
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(15, 17, 150, 150);
        msgBtn.frame = frame;
        [msgBtn addSubview:imageView];
        
    } else if([type isEqualToString:@"txt"]){
        [msgBtn setTitle:message forState:UIControlStateNormal];
        CGSize size = [Util workOutSizeWithStr:message font:15 maxWith:200-30 maxHeight:999];
        if (size.width < 20) {
            size.width = 20;
        }
        CGRect frame = msgBtn.frame;
        frame.size.height = 17*2 + size.height;
        frame.size.width = 15*2 + size.width;
        msgBtn.frame = frame;

    }
    height = msgBtn.frame.size.height;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
