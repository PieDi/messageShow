//
//  YXMessageShow.m
//  Animation
//
//  Created by  on 2017/6/15.
//  Copyright © 2017年 PieDi. All rights reserved.
//

#import "YXMessageShow.h"
#import "NSString+Filter.h"
#import "AppDelegate.h"




@interface YXMessageShow ()<CAAnimationDelegate>{
    UIWindow  *_mainWindow;
    UIControl *_mainControl;
}

@property (weak, nonatomic) IBOutlet UILabel *mTopLabel;

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@property (weak, nonatomic) IBOutlet UILabel *mBottomLabel;

@property (weak, nonatomic) IBOutlet UIImageView *messageImg;

@property (strong, nonatomic) IBOutlet UIButton *mButton;

@property (strong, nonatomic) UIView *lineView;

@property (weak, nonatomic) IBOutlet UIButton *mCloseBtn;





@end



@implementation YXMessageShow

-(void)awakeFromNib{
    [super awakeFromNib];
    _mainWindow = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _mainControl = [[UIControl alloc]initWithFrame:_mainWindow.bounds];
    
    _mainControl.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.3];
    _mainControl.alpha = 0.0;

    
    _lineView = [[UIView alloc]initWithFrame:CGRectMake(YXkWidth/2, 0, 1,0)];
    _lineView.backgroundColor = [UIColor orangeColor];
    
    _mButton.hidden = YES;
    _mTopLabel.hidden = YES;
    _mBottomLabel.hidden = YES;
    _mCloseBtn.hidden = YES;
    


    _mButton.hidden = YES;
}


-(void)showAnimation:(NSString *)showTitle{

    self.messageLabel.text = [showTitle moneyFormat];
    
    [self.messageLabel sizeToFit];
    self.messageLabel.alpha = 0.0;
    
    [_mainWindow addSubview:_mainControl];
    [_mainControl addSubview:_lineView];
    [_mainControl addSubview:self];
    
    _mainControl.alpha = 1.0;
    [_mainWindow makeKeyAndVisible];
    
    [self show];
}

-(void)show{
    

    
    UIBezierPath *bPath = [UIBezierPath bezierPath];
    [bPath moveToPoint:CGPointMake(YXkWidth/2, 0)];
    [bPath addLineToPoint:CGPointMake(YXkWidth/2, YXkHeight/2+100)];
    [bPath addLineToPoint:CGPointMake(YXkWidth/2, YXkHeight/2)];
    

    
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animation];
    keyAnimation.keyPath=@"position";

    keyAnimation.path = bPath.CGPath;
    keyAnimation.removedOnCompletion = NO;
    keyAnimation.fillMode=kCAFillModeForwards;
    keyAnimation.duration=2.0;
    keyAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    keyAnimation.delegate=self;
    
    [self.layer addAnimation:keyAnimation forKey:@"position"];
    
    
    
    CAKeyframeAnimation *lineAnimation = [CAKeyframeAnimation animation];
    lineAnimation.keyPath=@"bounds";
    [NSValue valueWithCGRect:CGRectMake(0, 0, 1, (YXkHeight/2+16))];
    lineAnimation.values = @[[NSValue valueWithCGRect:CGRectMake(0, 0, 1, 0)],[NSValue valueWithCGRect:CGRectMake(0, 0, 1, YXkHeight+32)],[NSValue valueWithCGRect:CGRectMake(0, 0, 1, (YXkHeight-168))]];
    lineAnimation.removedOnCompletion = NO;
    lineAnimation.fillMode=kCAFillModeForwards;
    lineAnimation.duration=2.0;
    lineAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [self.lineView.layer addAnimation:lineAnimation forKey:@"lineBounds"];
}



-(void)animationDidStart:(CAAnimation *)anim
{
    
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
    self.userInteractionEnabled = YES;
    _mainControl.userInteractionEnabled = YES;
    _mCloseBtn.userInteractionEnabled = YES;
    

    if ([[anim valueForKey:@"keyPath"] isEqualToString:@"position"]) {
        CAKeyframeAnimation *theAnimation = [CAKeyframeAnimation animation];
        theAnimation.values = [NSArray arrayWithObjects:
                               [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, 0,1,0)],
                               [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0,1,0)],
                               [NSValue valueWithCATransform3D:CATransform3DMakeRotation(2*M_PI, 0,1,0)],
                               [NSValue valueWithCATransform3D:CATransform3DMakeRotation(3*M_PI, 0,1,0)],
                               nil];
        theAnimation.cumulative = YES;
        theAnimation.duration = 2;
        theAnimation.repeatCount = 1;
        theAnimation.removedOnCompletion = YES;
        theAnimation.fillMode=kCAFillModeForwards;
        theAnimation.delegate = self;
        theAnimation.timingFunctions =
        [NSArray arrayWithObjects:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
         nil
         ];
        
        self.messageImg.animationImages = [NSArray arrayWithObjects:
                                           [UIImage imageNamed:@"cycle_back"],
                                           [UIImage imageNamed:@"cycle_front"],
                                           [UIImage imageNamed:@"cycle_back"],
                                           [UIImage imageNamed:@"cycle_back"],
                                           [UIImage imageNamed:@"cycle_front"],
                                           nil];
        [self.messageImg.layer addAnimation:theAnimation forKey:@"transform"];
        self.messageImg.animationDuration = 2;
        self.messageImg.animationRepeatCount = 1;
        [self.messageImg startAnimating];
        
        
    }else if ([[anim valueForKey:@"keyPath"] isEqualToString:@"transform"]){
        self.messageImg.image = [UIImage imageNamed:@"cycle_front"];
        self.messageLabel.alpha = 1.0;
        _mButton.hidden = NO;
        _mTopLabel.hidden = NO;
        _mBottomLabel.hidden = NO;
        _mCloseBtn.hidden = NO;
        
        self.frame = CGRectMake(YXkWidth/2-150, YXkHeight/2-150, 300, 300);
        [self needsUpdateConstraints];
        [self updateConstraints];

    }

    
}

- (IBAction)clickAction:(UIButton *)sender {
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSLog(@" 看看没有数据信息 %@ \n  %@  \n %@",[UIApplication sharedApplication].keyWindow,_mainWindow,app.window.rootViewController);
}



- (IBAction)closeAction:(UIButton *)sender {
    

    [UIView animateWithDuration:0.3 animations:^{
        
        _mainControl.alpha = 0.0;
        _messageLabel.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        
        
        [self removeFromSuperview];
        [_mainControl removeFromSuperview];
        [_lineView removeFromSuperview];
        [_mCloseBtn removeFromSuperview];
        [_mButton removeFromSuperview];

        _lineView = nil;
        _mCloseBtn = nil;
        _mButton = nil;
        _mainControl = nil;
        _mainWindow = nil;
        
    }];
}




@end
