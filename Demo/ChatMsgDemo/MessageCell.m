//
//  MessageCell.m
//  ChatMsgDemo
//
//  Created by 赵子辉 on 15/11/20.
//  Copyright © 2015年 zhaozihui. All rights reserved.
//

#import "MessageCell.h"
#import "FaceAndText.h"
#define maxHeight 150
@implementation MessageCell
@synthesize msgBtn,height,iconImg;

- (void)awakeFromNib {
    msgBtn.titleEdgeInsets = UIEdgeInsetsMake(17, 15, 17, 15);
    iconImg.layer.masksToBounds = YES;
    iconImg.layer.cornerRadius = iconImg.frame.size.height/2;
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
        UIImage *image = [UIImage imageNamed:message];
        CGSize size = image.size;
        
        CGRect frame = msgBtn.frame;
        if(size.width> size.height) {
            frame.size.width = maxHeight + 15*2;
            frame.size.height = maxHeight/size.width *size.height + 17*2;
        } else {
            frame.size.height = maxHeight + 17*2;
            frame.size.width = maxHeight/size.height *size.width + 15*2;
        }
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(15, 17, frame.size.width - 15*2, frame.size.height - 17*2);
        msgBtn.frame = frame;
        [msgBtn addSubview:imageView];
        
    } else if([type isEqualToString:@"txt"]){
        
        
        FaceAndText *faceText = [[FaceAndText alloc] init];
        
        UILabel *msgLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 17, msgBtn.frame.size.width - 15*2, msgBtn.frame.size.width - 17*2)];
        msgLbl.numberOfLines = 0;
        msgLbl.lineBreakMode = NSLineBreakByCharWrapping;
        msgLbl.attributedText = [faceText getAttributedStringFromText:message font:[UIFont systemFontOfSize:15] emojiSize:CGSizeMake(32, 32)];
        [msgLbl sizeToFit];

        
        
        CGRect frame = msgBtn.frame;
        frame.size.height = 17*2 + msgLbl.frame.size.height;
        frame.size.width = 15*2 + msgLbl.frame.size.width;
        msgBtn.frame = frame;
        [msgBtn addSubview:msgLbl];
       



    }
    height = msgBtn.frame.size.height;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
