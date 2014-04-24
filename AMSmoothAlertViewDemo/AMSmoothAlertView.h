//
//  AMSmoothAlertView.h
//  AMSmoothAlertViewDemo
//
//  Created by AMarliac on 2014-04-24.
//  Copyright (c) 2014 AMarliac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GPUImage/GPUImage.h>

@interface AMSmoothAlertView : UIView


@property (nonatomic, assign) float cornerRadius;

- (id) initWithTitle:(NSString*) title andText:(NSString*) text;
- (void) setCornerRadius:(float)cornerRadius;




@end
