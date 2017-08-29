//
//  ViewController.m
//  MessageShow
//
//  Created by lyc on 2017/8/29.
//  Copyright © 2017年 YiXun. All rights reserved.
//

#import "ViewController.h"
#import "YXMessageShow.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)ainmationShow:(UIButton *)sender {
    
    YXMessageShow *messageShow = (YXMessageShow *)[[NSBundle mainBundle] loadNibNamed:@"YXMessageShow" owner:self options:nil].firstObject;
    [messageShow showAnimation:@"123  4261  4772"];
}

@end
