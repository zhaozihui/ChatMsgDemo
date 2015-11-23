//
//  FaceAndText.m
//  ChatMsgDemo
//
//  Created by 赵子辉 on 15/11/23.
//  Copyright © 2015年 zhaozihui. All rights reserved.
//

#import "FaceAndText.h"
#import "RXMLElement.h"
@implementation FaceAndText
/**
 *  单例创建字典
 *
 *  @return 返回含有表情名称的列表
 */
-(NSDictionary *)getFace{
    static NSMutableDictionary * dic = nil;
    if (dic == nil ) {
        //NSString * path = [[NSBundle mainBundle]pathForResource:@"FaceList" ofType:@"plist"];
        dic = [[NSMutableDictionary alloc]init];
        
        RXMLElement *rxml = [RXMLElement elementFromXMLFile:@"arrays.xml"];
        // count the players
        RXMLElement *players = [rxml child:@"string-array"];
        NSArray *children = [players children:@"item"];
        NSMutableArray *emojiDataArray=[[NSMutableArray alloc]init];
        for (RXMLElement *element in children) {
            [emojiDataArray addObject:element.text];
        }
        
        for (int i=0; i<emojiDataArray.count; i++) {
            NSString *imageName=[NSString stringWithFormat:@"f%@.png",[self returnEmojiFileNameWith:i]];
            //[self.emojiImageArray addObject:imageName];
            NSString *str=[emojiDataArray objectAtIndex:i];
            //[dic setObject:str forKey:imageName];
            [dic setObject:imageName forKey:str];
        }
    }
    return dic;
}
- (NSString *)returnEmojiFileNameWith:(int)index{
    if (index<10) {
        return [NSString stringWithFormat:@"00%d",index];
    }
    if (index<100) {
        return [NSString stringWithFormat:@"0%d",index];
    }
    //if (index<1000) {
    return [NSString stringWithFormat:@"%d",index];
    //}
    //return [NSString stringWithFormat:@"%d",index];
}

- (NSMutableAttributedString *)getAttributedStringFromText:(NSString *)text font:(UIFont *)font emojiSize:(CGSize)emojiSize

{
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName : font}];
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\[[^\\[]*\\]" options:0 error:nil];
    NSArray* matches = [regex matchesInString:[attri string]
                                      options:NSMatchingWithoutAnchoringBounds
                                        range:NSMakeRange(0, attri.length)];
    
    for (NSTextCheckingResult* result in [matches reverseObjectEnumerator]) {
        NSRange matchRange = [result range];
        
        // 4
        NSString *placeholder = [attri.string substringWithRange: matchRange];
        UIImage *emojiImage = [UIImage imageNamed:[self getFace][placeholder]];
        
        // 5
        UIGraphicsBeginImageContextWithOptions(emojiSize, NO, 0.0);
        [emojiImage drawInRect:CGRectMake(0, 0, emojiSize.width, emojiSize.height)];
        UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        // 6
        NSTextAttachment* textAttachment = [NSTextAttachment new];
        textAttachment.image = resizedImage;
        
        // 7
        NSAttributedString *rep = [NSAttributedString attributedStringWithAttachment:textAttachment];
        [attri replaceCharactersInRange:matchRange withAttributedString:rep];
    }
    return attri;

}
@end
