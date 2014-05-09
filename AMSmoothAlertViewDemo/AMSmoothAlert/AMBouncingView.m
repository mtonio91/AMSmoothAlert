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

- (id)initSuccessCircleWithFrame:(CGRect)frame andImageSize:(int) imageSize forAlertType:(AlertType) type andColor:(UIColor*) color
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        if (color)
        {
            self.backgroundColor = color;
        }
        else
        {
            switch (type) {
                case AlertSuccess:
                    self.backgroundColor = GREENCOLOR;
                    break;
                case AlertFailure:
                    self.backgroundColor = REDCOLOR;
                    break;
                case AlertInfo:
                    self.backgroundColor = BLUECOLOR;
                    break;
                default:
                    break;
            }
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
