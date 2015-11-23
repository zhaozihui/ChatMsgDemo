//
//  FaceAndText.h
//  ChatMsgDemo
//
//  Created by 赵子辉 on 15/11/23.
//  Copyright © 2015年 zhaozihui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface FaceAndText : NSObject
- (NSMutableAttributedString *)getAttributedStringFromText:(NSString *)text font:(UIFont *)font emojiSize:(CGSize)emojiSize;
@end
