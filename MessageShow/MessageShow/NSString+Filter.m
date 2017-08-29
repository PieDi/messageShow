//
//  NSString+Filter.m
//  Animation
//
//  Created by  on 2017/6/23.
//  Copyright © 2017年 PieDi. All rights reserved.
//

#import "NSString+Filter.h"

@implementation NSString (Filter)


//删除首尾空格
- (NSString *)trim{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
//去除空格
- (NSString *)removeSpaces{
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}




// 金钱格式 123,456,789
- (NSString *)moneyFormat{
    
    if (self) {
        
        NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        NSString *numberString = [self removeSpaces];
        NSString *newString = @"";
        while (numberString.length > 0) {
            NSString *subString = [numberString substringToIndex:MIN(numberString.length, 4)];
            newString = [newString stringByAppendingString:subString];
            if (subString.length == 4) {
                newString = [newString stringByAppendingString:@","];
            }
            numberString = [numberString substringFromIndex:MIN(numberString.length, 4)];
        }
        
        newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
        
        
        return newString;
    }
    return nil;
    
}


@end
