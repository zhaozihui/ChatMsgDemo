//
//  Util.h
//  ChatMsgDemo
//
//  Created by 赵子辉 on 15/11/20.
//  Copyright © 2015年 zhaozihui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Util : NSObject
+(CGSize)workOutSizeWithStr:(NSString *)str font:(NSInteger)fontSize maxWith:(float)maxWidth maxHeight:(float) maxHeight;

+(CGSize)workOutSizeWithStr:(NSString *)str andFont:(NSInteger)fontSize value:(NSValue *)value;
@end
