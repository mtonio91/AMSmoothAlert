//
//  AMSmoothAlertView.m
//  AMSmoothAlertViewDemo
//
//  Created by AMarliac on 2014-04-24.
//  Copyright (c) 2014 AMarliac. All rights reserved.
//

#import "AMSmoothAlertView.h"

@implementation AMSmoothAlertView
{
    UIView *alertView;
    UIView *circleView;
    UIImageView * bg;
    GPUImageiOSBlurFilter *_blurFilter;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


- (id) initWithTitle:(NSString*) title andText:(NSString*) text
{
    self = [super init];
    if (self) {
        // Initialization code
        self.opaque = YES;
        _blurFilter = [[GPUImageiOSBlurFilter alloc] init];
        _blurFilter.blurRadiusInPixels = 2.0;

        
        alertView = [self alertPopupView];
        
        [self addSubview:alertView];
        [self circleSetup];

        [self triggerAnimations];
    }
    return self;
}


- (UIView*) alertPopupView
{
    
    UIView * alertSquare = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 150)];
    
    alertSquare.backgroundColor = [UIColor colorWithRed:0.937 green:0.937 blue:0.937 alpha:1];
    alertSquare.center = CGPointMake([self screenFrame].size.width/2, -[self screenFrame].size.height/2);
    

    [self performScreenshotAndBlur];
    
    [alertSquare.layer setShadowColor:[UIColor blackColor].CGColor];
    [alertSquare.layer setShadowOpacity:0.4];
    [alertSquare.layer setShadowRadius:20.0f];
    [alertSquare.layer setShadowOffset:CGSizeMake(0.0, 0.0)];
    
    
    return alertSquare;
}

- (void) setCornerRadius:(float)cornerRadius
{
    [alertView.layer setCornerRadius:cornerRadius];
}

-(void) performScreenshotAndBlur
{

    UIImage * image = [self convertViewToImage];
    
    UIImage *blurredSnapshotImage = [_blurFilter imageByFilteringImage:image];
    
    bg = [[UIImageView alloc]initWithFrame:[self screenFrame]];
    [bg setImage:blurredSnapshotImage];
    bg.alpha = 0.0;
    [self addSubview:bg];
}


- (CGRect) screenFrame
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    return screenRect;
}

-(UIImage *)convertViewToImage
{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    CGRect rect = [keyWindow bounds];
    UIGraphicsBeginImageContextWithOptions(rect.size,YES,0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [keyWindow.layer renderInContext:context];
    UIImage *capturedScreen = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return capturedScreen;
}


-(void) triggerAnimations
{
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         bg.alpha = 1.0;
                         [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                                          animations:^{
                                              alertView.center = CGPointMake([self screenFrame].size.width/2, ([self screenFrame].size.height/2)+alertView.frame.size.height*0.1);
                                          }
                                          completion:^(BOOL finished) {
                                              [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                                                               animations:^{
                                                                   alertView.center = CGPointMake([self screenFrame].size.width/2, ([self screenFrame].size.height/2));
                                                               }
                                                               completion:^(BOOL finished) {
                                                                   [self circleAnimation];
                                                               }];
                                          }];

                     }
                     completion:^(BOOL finished) {
                                              }];
}



- (void) circleAnimation
{
        [UIView animateWithDuration:0.15
                              delay:0.0
                            options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             circleView.frame = [self newFrameForView:circleView withWidth:85 andHeight:85];
                         }
                         completion:^(BOOL finished){
                             [UIView animateWithDuration:0.1
                                                   delay:0.0
                                                 options: UIViewAnimationOptionCurveEaseInOut
                                              animations:^{
                                                  circleView.frame = [self newFrameForView:circleView withWidth:50 andHeight:50];

                                              }
                                              completion:^(BOOL finished){
                                                  [UIView animateWithDuration:0.05
                                                                        delay:0.0
                                                                      options: UIViewAnimationOptionCurveEaseInOut
                                                                   animations:^{
                                                                       circleView.frame = [self newFrameForView:circleView withWidth:60 andHeight:60];

                                                                   }
                                                                   completion:^(BOOL finished){
                                                                       
                                                                   }];
                                              }];
                         }];

}
    
- (CGRect) newFrameForView:(UIView*) uiview withWidth:(float) width andHeight:(float) height
{
    
    return CGRectMake(uiview.frame.origin.x + ((uiview.frame.size.width - width)/2),
                      uiview.frame.origin.y + ((uiview.frame.size.height - height)/2),
                      width,
                      height);
}

- (void) circleSetup
{
    circleView = [[UIView alloc]initWithFrame:CGRectMake([self screenFrame].size.width/2, (([self screenFrame].size.width/2)+alertView.frame.size.height/2) - 30 , 0, 0)];
    UIImageView*imgV = [[UIImageView alloc]initWithFrame:circleView.bounds];
    [imgV setImage:[UIImage imageNamed:@"check.png"]];
    imgV.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [circleView clipsToBounds];
    [circleView addSubview:imgV];
    [self addSubview:circleView];

}


@end
