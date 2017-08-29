//
//  NSString+Filter.h
//  Animation
//
//  Created by  on 2017/6/23.
//  Copyright © 2017年 PieDi. All rights reserved.
//

#import <Foundation/Foundation.h>



// 主要处理字符串的过滤
@interface NSString (Filter)

//删除首尾空格
- (NSString *)trim;
//去除空格
- (NSString *)removeSpaces;
// 金钱格式
- (NSString *)moneyFormat;


@end
