//
//  YXMessageShow.h
//  Animation
//
//  Created by  on 2017/6/15.
//  Copyright © 2017年 PieDi. All rights reserved.
//

#import <UIKit/UIKit.h>


#define YXColor(a,b,c,r) [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:r]
#define YXkWidth [UIScreen mainScreen].bounds.size.width
#define YXkHeight [UIScreen mainScreen].bounds.size.height

@interface YXMessageShow : UIView

-(void)showAnimation:(NSString *)showTitle;
@end
