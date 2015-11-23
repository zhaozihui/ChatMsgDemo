//
//  MessageCell.m
//  ChatMsgDemo
//
//  Created by 赵子辉 on 15/11/20.
//  Copyright © 2015年 zhaozihui. All rights reserved.
//

#import "MessageCell.h"
#import "FaceAndText.h"
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
       
//        //[msgBtn setTitle:message forState:UIControlStateNormal];
//        CGSize size = [Util workOutSizeWithStr:message font:15 maxWith:200-30 maxHeight:999];
//        if (size.width < 20) {
//            size.width = 20;
//        }
//        
//        FaceAndTextLabel *_wordLabel=[[FaceAndTextLabel alloc]initWithFrame:CGRectMake(15, 17, size.width, size.height) ];
//
//        _wordLabel.backgroundColor=[UIColor clearColor];
//        [_wordLabel setFaceAndText:message andTextColor:[UIColor whiteColor] andFont:[UIFont systemFontOfSize:15]];
//        CGSize sizeThatFit=[_wordLabel sizeThatFits:CGSizeZero];
////        //重新指定frame
////        _wordLabel.frame=CGRectMake(0, 0, sizeThatFit.width, sizeThatFit.height);
//        msgBtn.titleLabel.frame  = CGRectMake(15, 17, sizeThatFit.width, sizeThatFit.height);
//        
//        
//        NSMutableAttributedString *attri =     [[NSMutableAttributedString alloc] initWithString:@"哈哈哈哈哈123456789"];
//        
//        // 修改富文本中的不同文字的样式
//        [attri addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, 5)];
//        [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, 5)];
//        
//        // 设置数字为红色
//        [attri addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5, 9)];
//        [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:30] range:NSMakeRange(5, 9)];
//        
//        
//        NSTextAttachment *attch = [[NSTextAttachment alloc] init];
//        // 表情图片
//        attch.image = [UIImage imageNamed:@"f001"];
//        // 设置图片大小
//        attch.bounds = CGRectMake(0, 0, 32, 32);
//        
//        // 创建带有图片的富文本
//        NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
//        [attri appendAttributedString:string];
//        
//        // 用label的attributedText属性来使用富文本
//        msgBtn.titleLabel.attributedText = attri;
//        //[msgBtn addSubview:_wordLabel];
//        
//        CGRect frame = msgBtn.frame;
//        frame.size.height = 17*2 + _wordLabel.frame.size.height;
//        frame.size.width = 15*2 + _wordLabel.frame.size.width;
//        msgBtn.frame = frame;


    }
        height = msgBtn.frame.size.height;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
