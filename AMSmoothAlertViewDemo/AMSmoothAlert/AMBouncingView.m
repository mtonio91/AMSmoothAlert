//
//  AMBouncingView.m
//  AMSmoothAlertViewDemo
//
//  Created by AMarliac on 2014-04-25.
//  Copyright (c) 2014 AMarliac. All rights reserved.
//

#import "AMBouncingView.h"

@implementation AMBouncingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initSuccessCircleWithFrame:(CGRect)frame andImageSize:(int) imageSize forAlertType:(AlertType) type
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code        
        switch (type) {
            case AlertSuccess:
                self.backgroundColor = [UIColor colorWithRed:0.443 green:0.765 blue:0.255 alpha:1];
                break;
            case AlertFailure:
                self.backgroundColor = [UIColor colorWithRed:0.906 green:0.296 blue:0.235 alpha:1];
                break;
            case AlertInfo:
                self.backgroundColor = [UIColor colorWithRed:0.204 green:0.286 blue:0.369 alpha:1];
                break;
                
            default:
                break;
        }
        
        [self.layer setCornerRadius:30];
    }
    return self;
}

- (CGRect) newFrameWithWidth:(float) width andHeight:(float) height
{
    return CGRectMake(self.frame.origin.x + ((self.frame.size.width - width)/2),
                      self.frame.origin.y + ((self.frame.size.height - height)/2),
                      width,
                      height);
}


@end
