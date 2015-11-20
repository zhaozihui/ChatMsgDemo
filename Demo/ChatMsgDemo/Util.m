//
//  Util.m
//  ChatMsgDemo
//
//  Created by 赵子辉 on 15/11/20.
//  Copyright © 2015年 zhaozihui. All rights reserved.
//

#import "Util.h"

@implementation Util
+(CGSize)workOutSizeWithStr:(NSString *)str font:(NSInteger)fontSize maxWith:(float)maxWidth maxHeight:(float) maxHeight{
    return [self workOutSizeWithStr:str andFont:fontSize value:[NSValue valueWithCGSize:CGSizeMake(maxWidth, maxHeight)]];
}

+(CGSize)workOutSizeWithStr:(NSString *)str andFont:(NSInteger)fontSize value:(NSValue *)value{
    CGSize size;
    if (str) {
        NSDictionary *attribute = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:fontSize],NSFontAttributeName, nil];
        size=[str boundingRectWithSize:[value CGSizeValue] options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingTruncatesLastVisibleLine attributes:attribute context:nil].size;
    }
    return size;
}
@end
