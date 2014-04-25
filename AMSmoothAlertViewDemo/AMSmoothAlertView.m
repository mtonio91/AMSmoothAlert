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

- (id) initWithTitle:(NSString*) title andText:(NSString*) text
{
    self = [super init];
    if (self) {
        // Initialization code
        self.frame = [self screenFrame];
        self.opaque = YES;
        
        
        self.alpha = 1;

        _blurFilter = [[GPUImageiOSBlurFilter alloc] init];
        _blurFilter.blurRadiusInPixels = 2.0;

        bg = [[UIImageView alloc]initWithFrame:[self screenFrame]];

        alertView = [self alertPopupView];
        
        [self labelSetupWithTitle:title andText:text];
        [self buttonSetup];
        
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
    
    
    [alertSquare.layer setShadowColor:[UIColor blackColor].CGColor];
    [alertSquare.layer setShadowOpacity:0.4];
    [alertSquare.layer setShadowRadius:20.0f];
    [alertSquare.layer setShadowOffset:CGSizeMake(0.0, 0.0)];
    
    [self performScreenshotAndBlur];
    
    return alertSquare;
}




#pragma mark - Blur

-(void) performScreenshotAndBlur
{

    UIImage * image = [self convertViewToImage];
    UIImage *blurredSnapshotImage = [_blurFilter imageByFilteringImage:image];
    
    [bg setImage:blurredSnapshotImage];
    bg.alpha = 0.0;
    
    [self addSubview:bg];
}


#pragma mark - Items Setup

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

- (void) labelSetupWithTitle:(NSString*) title andText:(NSString*) text
{
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 180, 30)];
    titleLabel.center = CGPointMake(alertView.frame.size.width/2, 45);
    titleLabel.text = title;
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-LightItalic" size:20.0f];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [alertView addSubview:titleLabel];
    
    
    UILabel * textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 180, 50)];
    textLabel.center = CGPointMake(alertView.frame.size.width/2, 80);
    textLabel.text = text;
    textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12.0f];
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    textLabel.numberOfLines = 0;
    [alertView addSubview:textLabel];
    
}

- (void) buttonSetup
{
 
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 180, 30)];
    btn.center = CGPointMake(alertView.frame.size.width/2, 120);
    btn.backgroundColor = [UIColor colorWithRed:0.443 green:0.765 blue:0.255 alpha:1];
    [btn setTitle:@"Neat !" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:18.0f];
    [btn addTarget:self action:@selector(dismissAlertView) forControlEvents:UIControlEventTouchUpInside];
    
    [btn.layer setCornerRadius:3.0f];
    

    [alertView addSubview:btn];
    
    
}


#pragma mark - Animations

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
                                                                   self.isDisplayed = true;
                                                               }];
                                          }];
                     }];
    
}


- (void) dismissAlertView
{
    [UIView animateWithDuration:0.4
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.alpha = 0;
                     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                         self.isDisplayed = false;
                     }];
}


#pragma mark - Miscellaneous

- (void) setCornerRadius:(float)cornerRadius
{
    [alertView.layer setCornerRadius:cornerRadius];
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


- (CGRect) newFrameForView:(UIView*) uiview withWidth:(float) width andHeight:(float) height
{
    return CGRectMake(uiview.frame.origin.x + ((uiview.frame.size.width - width)/2),
                      uiview.frame.origin.y + ((uiview.frame.size.height - height)/2),
                      width,
                      height);
}



@end
