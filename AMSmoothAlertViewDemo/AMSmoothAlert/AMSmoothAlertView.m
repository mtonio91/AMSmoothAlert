//
//  AMSmoothAlertView.m
//  AMSmoothAlertViewDemo
//
//  Created by AMarliac on 2014-04-24.
//  Contributor: Everest Liu
//  Copyright (c) 2014 AMarliac. All rights reserved.
//

#import "AMSmoothAlertView.h"

@interface AMSmoothAlertView ()
@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) GPUImageiOSBlurFilter *blurFilter;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) AMBouncingView *circleView;
@end

@implementation AMSmoothAlertView

#pragma mark - Getters
-(UIView*)alertView
{
    if (_alertView == nil) {
        _alertView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 150)];
        _alertView.backgroundColor = [UIColor colorWithRed:0.937 green:0.937 blue:0.937 alpha:1];
        _alertView.center = CGPointMake([self screenFrame].size.width/2, -[self screenFrame].size.height/2);
        [_alertView.layer setShadowColor:[UIColor blackColor].CGColor];
        [_alertView.layer setShadowOpacity:0.4];
        [_alertView.layer setShadowRadius:20.0f];
        [_alertView.layer setShadowOffset:CGSizeMake(0.0, 0.0)];
    }
    return _alertView;
}

-(GPUImageiOSBlurFilter*)blurFilter
{
    if (_blurFilter == nil) {
        _blurFilter = [[GPUImageiOSBlurFilter alloc] init];
        _blurFilter.blurRadiusInPixels = 2.0;
    }
    return _blurFilter;
}

-(UILabel*)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 180, 30)];
        _titleLabel.center = CGPointMake(self.alertView.frame.size.width/2, 45);
        _titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-LightItalic" size:20.0f];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

-(UILabel *)textLabel
{
    if (_textLabel == nil) {
        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 180, 50)];
        _textLabel.center = CGPointMake(self.alertView.frame.size.width/2, 80);
        _textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12.0f];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _textLabel.numberOfLines = 0;
    }
    return _textLabel;
}

-(UIButton*)cancelButton
{
    if (_cancelButton == nil) {
        _cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 84, 30)];
        _cancelButton.center = CGPointMake((self.alertView.frame.size.width*3/4)-3, 120);
        _cancelButton.backgroundColor = [UIColor colorWithRed:0.792 green:0.792 blue:0.792 alpha:1];
        [_cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
        _cancelButton.titleLabel.textColor = [UIColor whiteColor];
        _cancelButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:18.0f];
		[_cancelButton addTarget:self action:@selector(handleButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        [_cancelButton.layer setCornerRadius:3.0f];
    }
    return _cancelButton;
}

-(UIButton*)defaultButton
{
    if (_defaultButton == nil) {
        _defaultButton = [UIButton new];
        [_defaultButton setTitle:@"OK !" forState:UIControlStateNormal];
        _defaultButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:18.0f];
        [_defaultButton addTarget:self action:@selector(handleButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        [_defaultButton.layer setCornerRadius:3.0f];
    }
    return _defaultButton;
}

- (id) initDropAlertWithTitle:(NSString*) title andText:(NSString*) text andCancelButton:(BOOL)hasCancelButton forAlertType:(AlertType) type
{
    return [self initDropAlertWithTitle:title andText:text andCancelButton:hasCancelButton forAlertType:type andColor:nil];
}

- (id) initDropAlertWithTitle:(NSString*) title andText:(NSString*) text andCancelButton:(BOOL)hasCancelButton forAlertType:(AlertType) type andColor:(UIColor*) color
{
    self = [super init];
    if (self) {
        // Initialization code
        _animationType = DropAnimation;
        [self _initViewWithTitle:title andText:text andCancelButton:hasCancelButton forAlertType:type andColor:color];
    }
    return self;
}


- (id) initFadeAlertWithTitle:(NSString*) title andText:(NSString*) text andCancelButton:(BOOL)hasCancelButton forAlertType:(AlertType) type
{
    return [self initFadeAlertWithTitle:title andText:text andCancelButton:hasCancelButton forAlertType:type andColor:nil];
}

- (id) initFadeAlertWithTitle:(NSString*) title andText:(NSString*) text andCancelButton:(BOOL)hasCancelButton forAlertType:(AlertType) type andColor:(UIColor*) color
{
    self = [super init];
    if (self) {
        // Initialization code
        _animationType = FadeInAnimation;
        [self _initViewWithTitle:title andText:text andCancelButton:hasCancelButton forAlertType:type andColor:color];
    }
    return self;
}

// init with completion blocks

- (id) initDropAlertWithTitle:(NSString*) title andText:(NSString*) text andCancelButton:(BOOL)hasCancelButton forAlertType:(AlertType) type withCompletionHandler:(dismissAlertWithButton) completionHandler
{
    self.completionBlock = completionHandler;
    return [self initDropAlertWithTitle:title andText:text andCancelButton:hasCancelButton forAlertType:type andColor:nil];
}

- (id) initDropAlertWithTitle:(NSString*) title andText:(NSString*) text andCancelButton:(BOOL)hasCancelButton forAlertType:(AlertType) type andColor:(UIColor*) color withCompletionHandler:(dismissAlertWithButton) completionHandler
{
    self = [super init];
    if (self) {
        // Initialization code
        self.completionBlock = completionHandler;
        _animationType = DropAnimation;
        [self _initViewWithTitle:title andText:text andCancelButton:hasCancelButton forAlertType:type andColor:color];
    }
    return self;
}


- (id) initFadeAlertWithTitle:(NSString*) title andText:(NSString*) text andCancelButton:(BOOL)hasCancelButton forAlertType:(AlertType) type withCompletionHandler:(dismissAlertWithButton) completionHandler
{
    self.completionBlock = completionHandler;
    return [self initFadeAlertWithTitle:title andText:text andCancelButton:hasCancelButton forAlertType:type andColor:nil];
}

- (id) initFadeAlertWithTitle:(NSString*) title andText:(NSString*) text andCancelButton:(BOOL)hasCancelButton forAlertType:(AlertType) type andColor:(UIColor*) color withCompletionHandler:(dismissAlertWithButton) completionHandler
{
    self = [super init];
    if (self) {
        // Initialization code
        self.completionBlock = completionHandler;
        _animationType = FadeInAnimation;
        [self _initViewWithTitle:title andText:text andCancelButton:hasCancelButton forAlertType:type andColor:color];
    }
    return self;
}


- (void) _initViewWithTitle:(NSString *)title andText:(NSString *)text andCancelButton:(BOOL)hasCancelButton forAlertType:(AlertType)type andColor:(UIColor*) color
{
    self.frame = [self screenFrame];
    self.opaque = YES;
    self.alpha = 1;

    self.backgroundImageView = [[UIImageView alloc]initWithFrame:[self screenFrame]];
  
    [self performScreenshotAndBlur];
    
    [self labelSetupWithTitle:title andText:text];
    [self buttonSetupForType:type withCancelButton: hasCancelButton andColor:color];
    [self addSubview:self.alertView];
  
    [self circleSetupForAlertType:type andColor:color];
}

- (void) show
{
	id<AMSmoothAlertViewDelegate> delegate = self.delegate;
	if ([delegate respondsToSelector:@selector(alertViewWillShow:)]) [delegate alertViewWillShow:self];

    switch (_animationType) {
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
    UIImage *blurredSnapshotImage = [self.blurFilter imageByFilteringImage:image];
    
    [self.backgroundImageView setImage:blurredSnapshotImage];
    self.backgroundImageView.alpha = 0.0;
    
    [self addSubview:self.backgroundImageView];
}


#pragma mark - Items Setup

- (void) circleSetupForAlertType:(AlertType) type andColor:(UIColor*) color
{
    UIView * circleMask = [[UIView alloc]initWithFrame:CGRectMake([self screenFrame].size.width/2, (([self screenFrame].size.height/2)-self.alertView.frame.size.height/2) , 60, 60)];
    self.circleView = [[AMBouncingView alloc]initSuccessCircleWithFrame:CGRectMake(0, 0, 0, 0) andImageSize:60 forAlertType:type andColor:color];
    
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
    [circleMask addSubview:_logoView];
    [circleMask addSubview:self.circleView];
}

- (void) labelSetupWithTitle:(NSString*) title andText:(NSString*) text
{
    self.titleLabel.text = title;
    
    [self.alertView addSubview:self.titleLabel];
    
    self.textLabel.text = text;
    
    [self.alertView addSubview:self.textLabel];
    
}

- (void)buttonSetupForType:(AlertType)type withCancelButton:(BOOL)hasCancelButton andColor:(UIColor*)color
{
    if (hasCancelButton)
    {
        [self.alertView addSubview:self.cancelButton];
        
        self.defaultButton.frame = CGRectMake(0, 0, 84, 30);
        self.defaultButton.center = CGPointMake((self.alertView.frame.size.width/4)+3, 120);
    }
    else
    {
        self.defaultButton.frame = CGRectMake(0, 0, 180, 30);
        self.defaultButton.center = CGPointMake(self.alertView.frame.size.width/2, 120);
    }
    
    [self setColorForButton:color
                   onButton:self.defaultButton
                   withType:type];
    
    [self.alertView addSubview:self.defaultButton];
}


- (void) setColorForButton:(UIColor*) color onButton:(UIButton*) btn withType:(AlertType)type
{
    if (color)
    {
        btn.backgroundColor = color;
    }
    else
    {
        switch (type) {
            case AlertSuccess:
                btn.backgroundColor = GREENCOLOR;
                break;
            case AlertFailure:
                btn.backgroundColor = REDCOLOR;
                break;
            case AlertInfo:
                btn.backgroundColor = BLUECOLOR;
                break;
                
            default:
                break;
        }
    }
    
}

- (void)setTitleFont:(UIFont *)titleFont
{
    [self.titleLabel setFont:titleFont];
}

- (void)setTextFont:(UIFont *)textFont
{
    [self.textLabel setFont:textFont];
}

-(void)setTitleText:(NSString*) string
{
    self.titleLabel.text = string;
}

-(void)setMessageText:(NSString*) string
{
    self.textLabel.text = string;
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
            self.backgroundImageView.alpha = 1.0;
        } completion: getNextAnimation()];
    }];
    
    //block 2
    [animationBlocks addObject:^(BOOL finished){;
        [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.alertView.center = CGPointMake([self screenFrame].size.width/2, ([self screenFrame].size.height/2)+self.alertView.frame.size.height*0.1);
        } completion: getNextAnimation()];
    }];
    
    //block 3
    [animationBlocks addObject:^(BOOL finished){;
        [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.alertView.center = CGPointMake([self screenFrame].size.width/2, ([self screenFrame].size.height/2));
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
    self.alertView.alpha = 0;
    self.alertView.center = CGPointMake([self screenFrame].size.width/2, ([self screenFrame].size.height/2));

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
            self.backgroundImageView.alpha = 1.0;
        } completion: getNextAnimation()];
    }];
    
    //block 2
    [animationBlocks addObject:^(BOOL finished){;
        [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.alertView.alpha = 1;
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
            self.circleView.frame = [self.circleView newFrameWithWidth:85 andHeight:85];
            self.logoView.frame = [self newFrameForView:self.logoView withWidth:40 andHeight:40];
        } completion: getNextAnimation()];
    }];
    
    //block 2
    [animationBlocks addObject:^(BOOL finished){;
        [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.circleView.frame = [self.circleView newFrameWithWidth:50 andHeight:50];
            self.logoView.frame = [self newFrameForView:self.logoView withWidth:15 andHeight:15];
        } completion: getNextAnimation()];
    }];
    
    //block 3
    [animationBlocks addObject:^(BOOL finished){;
        [UIView animateWithDuration:0.05 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.circleView.frame = [self.circleView newFrameWithWidth:60 andHeight:60];
            self.logoView.frame = [self newFrameForView:self.logoView withWidth:20 andHeight:20];
        } completion: getNextAnimation()];
    }];
    
    //add a block to our queue
    [animationBlocks addObject:^(BOOL finished){;
        self.isDisplayed = true;
		id<AMSmoothAlertViewDelegate> delegate = self.delegate;
		if ([delegate respondsToSelector:@selector(alertViewDidShow:)]) [delegate alertViewDidShow:self];
    }];
    
    // execute the first block in the queue
    getNextAnimation()(YES);
}


- (void) dismissAlertView
{
	id<AMSmoothAlertViewDelegate> delegate = self.delegate;
	if ([delegate respondsToSelector:@selector(alertViewWillDismiss:)]) [delegate alertViewWillDismiss:self];
    [UIView animateWithDuration:0.4
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.alpha = 0;
                     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                         self.isDisplayed = false;
						 if ([delegate respondsToSelector:@selector(alertViewDidDismiss:)]) [delegate alertViewDidDismiss:self];
                     }];
}


#pragma mark - Miscellaneous

- (void) setCornerRadius:(float)cornerRadius
{
    [self.alertView.layer setCornerRadius:cornerRadius];
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

#pragma mark - Delegate Methods
- (void)handleButtonTouched:(id)sender {
	[self dismissAlertView];

	id<AMSmoothAlertViewDelegate> delegate = self.delegate;
	UIButton *button = (UIButton *) sender;
	if ([delegate respondsToSelector:@selector(alertView:didDismissWithButton:)]) {
		// Since there isn't a button index for the alertView, pass the button
		[delegate alertView:self didDismissWithButton:button];
	}
    
    if(self.completionBlock) {
        self.completionBlock(self, button);
    }
}

@end
