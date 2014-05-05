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
    AMBouncingView *circleView;
    UIImageView * bg;
    GPUImageiOSBlurFilter *_blurFilter;
    UILabel * titleLabel;
    UILabel * textLabel;
}

- (id) initDropAlertWithTitle:(NSString*) title andText:(NSString*) text forAlertType:(AlertType) type
{
    self = [super init];
    if (self) {
        // Initialization code
        self.frame = [self screenFrame];
        self.opaque = YES;
        self.alpha = 1;

        _animationType = DropAnimation;
        
        _blurFilter = [[GPUImageiOSBlurFilter alloc] init];
        _blurFilter.blurRadiusInPixels = 2.0;

        bg = [[UIImageView alloc]initWithFrame:[self screenFrame]];

        alertView = [self alertPopupView];
        
        [self labelSetupWithTitle:title andText:text];
        [self buttonSetupForType:type];
        [self addSubview:alertView];

        [self circleSetupForAlertType:type];
        
    }
    return self;
}


- (id) initFadeAlertWithTitle:(NSString*) title andText:(NSString*) text forAlertType:(AlertType) type
{
    self = [super init];
    if (self) {
        // Initialization code
        self.frame = [self screenFrame];
        self.opaque = YES;
        self.alpha = 1;
        
        _animationType = FadeInAnimation;

        
        _blurFilter = [[GPUImageiOSBlurFilter alloc] init];
        _blurFilter.blurRadiusInPixels = 2.0;
        
        bg = [[UIImageView alloc]initWithFrame:[self screenFrame]];
        
        alertView = [self alertPopupView];
        
        [self labelSetupWithTitle:title andText:text];
        [self buttonSetupForType:type];
        [self addSubview:alertView];
        
        [self circleSetupForAlertType:type];
        
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


- (void) show
{
    switch ((int)_animationType) {
        case DropAnimation:
            [self triggerDropAnimations];
            break;
        case FadeInAnimation:
            [self triggerFadeAnimations];
            break;
            
        default:
            break;
    }
    [[[[UIApplication sharedApplication] delegate] window] addSubview:self];
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

- (void) circleSetupForAlertType:(AlertType) type
{
    UIView * circleMask = [[UIView alloc]initWithFrame:CGRectMake([self screenFrame].size.width/2, (([self screenFrame].size.height/2)-alertView.frame.size.height/2) , 60, 60)];
    circleView = [[AMBouncingView alloc]initSuccessCircleWithFrame:CGRectMake(0, 0, 0, 0) andImageSize:60 forAlertType:type];
    
    _logoView = [[UIImageView alloc]initWithFrame:CGRectMake(circleMask.frame.size.width/2-30, circleMask.frame.size.height/2-30 , 0, 0)];
    
    switch (type) {
        case AlertSuccess:
            [_logoView setImage:[UIImage imageNamed:@"checkMark.png"]];
            break;
        case AlertFailure:
            [_logoView setImage:[UIImage imageNamed:@"crossMark.png"]];
            break;
        case AlertInfo:
            [_logoView setImage:[UIImage imageNamed:@"info.png"]];
            break;
            
        default:
            break;
    }
    _logoView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [self addSubview:circleMask];
    [circleMask addSubview:circleView];
    [circleMask addSubview:_logoView];
}

- (void) labelSetupWithTitle:(NSString*) title andText:(NSString*) text
{
    titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 180, 30)];
    titleLabel.center = CGPointMake(alertView.frame.size.width/2, 45);
    titleLabel.text = title;
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-LightItalic" size:20.0f];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [alertView addSubview:titleLabel];
    
    
    textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 180, 50)];
    textLabel.center = CGPointMake(alertView.frame.size.width/2, 80);
    textLabel.text = text;
    textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12.0f];
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    textLabel.numberOfLines = 0;
    [alertView addSubview:textLabel];
    
}

- (void) buttonSetupForType:(AlertType)type
{
 
    _defaultButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 180, 30)];
    _defaultButton.center = CGPointMake(alertView.frame.size.width/2, 120);
    
    switch (type) {
        case AlertSuccess:
            _defaultButton.backgroundColor = GREENCOLOR;
            break;
        case AlertFailure:
            _defaultButton.backgroundColor = REDCOLOR;
            break;
        case AlertInfo:
            _defaultButton.backgroundColor = BLUECOLOR;
            break;
            
        default:
            break;
    }
    
    [_defaultButton setTitle:@"Neat !" forState:UIControlStateNormal];
    _defaultButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:18.0f];
    [_defaultButton addTarget:self action:@selector(dismissAlertView) forControlEvents:UIControlEventTouchUpInside];
    
    [_defaultButton.layer setCornerRadius:3.0f];
    

    [alertView addSubview:_defaultButton];
    
}



- (void) setTitleFont:(UIFont *)titleFont
{
    [titleLabel setFont:titleFont];
}

- (void) setTextFont:(UIFont *)textFont
{
    [textLabel setFont:textFont];
}

#pragma mark - Animations

-(void) triggerDropAnimations
{
 
    NSMutableArray* animationBlocks = [NSMutableArray new];
    
    typedef void(^animationBlock)(BOOL);
    
    // getNextAnimation
    // removes the first block in the queue and returns it
    animationBlock (^getNextAnimation)() = ^{
        animationBlock block = animationBlocks.count ? (animationBlock)[animationBlocks objectAtIndex:0] : nil;
        if (block){
            [animationBlocks removeObjectAtIndex:0];
            return block;
        }else{
            return ^(BOOL finished){};
        }
    };
    
    //block 1
    [animationBlocks addObject:^(BOOL finished){;
        [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            bg.alpha = 1.0;
        } completion: getNextAnimation()];
    }];
    
    //block 2
    [animationBlocks addObject:^(BOOL finished){;
        [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            alertView.center = CGPointMake([self screenFrame].size.width/2, ([self screenFrame].size.height/2)+alertView.frame.size.height*0.1);
        } completion: getNextAnimation()];
    }];
    
    //block 3
    [animationBlocks addObject:^(BOOL finished){;
        [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            alertView.center = CGPointMake([self screenFrame].size.width/2, ([self screenFrame].size.height/2));
        } completion: getNextAnimation()];
    }];
    
    //add a block to our queue
    [animationBlocks addObject:^(BOOL finished){;
        [self circleAnimation];
    }];
    
    // execute the first block in the queue
    getNextAnimation()(YES);
    
    
    
    
}



-(void) triggerFadeAnimations
{
 
    alertView.alpha = 0;
    alertView.center = CGPointMake([self screenFrame].size.width/2, ([self screenFrame].size.height/2));

    NSMutableArray* animationBlocks = [NSMutableArray new];
    
    typedef void(^animationBlock)(BOOL);
    
    // getNextAnimation
    // removes the first block in the queue and returns it
    animationBlock (^getNextAnimation)() = ^{
        animationBlock block = animationBlocks.count ? (animationBlock)[animationBlocks objectAtIndex:0] : nil;
        if (block){
            [animationBlocks removeObjectAtIndex:0];
            return block;
        }else{
            return ^(BOOL finished){};
        }
    };
    
    //block 1
    [animationBlocks addObject:^(BOOL finished){;
        [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            bg.alpha = 1.0;
        } completion: getNextAnimation()];
    }];
    
    //block 2
    [animationBlocks addObject:^(BOOL finished){;
        [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            alertView.alpha = 1;
        } completion: getNextAnimation()];
    }];
    
    //add a block to our queue
    [animationBlocks addObject:^(BOOL finished){;
        [self circleAnimation];
    }];
    
    // execute the first block in the queue
    getNextAnimation()(YES);
    
}

- (void) circleAnimation
{
    NSMutableArray* animationBlocks = [NSMutableArray new];
    
    typedef void(^animationBlock)(BOOL);
    
    // getNextAnimation
    // removes the first block in the queue and returns it
    animationBlock (^getNextAnimation)() = ^{
        animationBlock block = animationBlocks.count ? (animationBlock)[animationBlocks objectAtIndex:0] : nil;
        if (block){
            [animationBlocks removeObjectAtIndex:0];
            return block;
        }else{
            return ^(BOOL finished){};
        }
    };
    
    //block 1
    [animationBlocks addObject:^(BOOL finished){;
        [UIView animateWithDuration:0.15 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            circleView.frame = [circleView newFrameWithWidth:85 andHeight:85];
            _logoView.frame = [self newFrameForView:_logoView withWidth:40 andHeight:40];
        } completion: getNextAnimation()];
    }];
    
    //block 2
    [animationBlocks addObject:^(BOOL finished){;
        [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            circleView.frame = [circleView newFrameWithWidth:50 andHeight:50];
            _logoView.frame = [self newFrameForView:_logoView withWidth:15 andHeight:15];
        } completion: getNextAnimation()];
    }];
    
    //block 3
    [animationBlocks addObject:^(BOOL finished){;
        [UIView animateWithDuration:0.05 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            circleView.frame = [circleView newFrameWithWidth:60 andHeight:60];
            _logoView.frame = [self newFrameForView:_logoView withWidth:20 andHeight:20];
        } completion: getNextAnimation()];
    }];
    
    //add a block to our queue
    [animationBlocks addObject:^(BOOL finished){;
        self.isDisplayed = true;
    }];
    
    // execute the first block in the queue
    getNextAnimation()(YES);
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
