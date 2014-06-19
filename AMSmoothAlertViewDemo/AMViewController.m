//
//  AMViewController.m
//  AMSmoothAlertViewDemo
//
//  Created by AMarliac on 2014-04-24.
//  Copyright (c) 2014 AMarliac. All rights reserved.
//

#import "AMViewController.h"

@interface AMViewController ()
@property (nonatomic, strong) AMSmoothAlertView *alertView;
@end

@implementation AMViewController

- (IBAction)openPopup:(id)sender
{
    if (!self.alertView || !self.alertView.isDisplayed)
    {
        UIButton * btn = (UIButton*) sender;
        
        switch (btn.tag)
        {
            case AlertSuccess:
            {
                self.alertView = [[AMSmoothAlertView alloc] initDropAlertWithTitle:@"Congrats !"
                                                                           andText:@"You've just displayed this awesome alert view !"
                                                                      forAlertType:AlertSuccess
                                                                          andColor:nil
                                                           withDefaultButtonAction:^{
                                                               NSLog(@"Default touched");
                                                           } withCancelButtonAction:nil];
            
                [self.alertView.defaultButton setTitle:@"Great" forState:UIControlStateNormal];
            }
                break;
            case AlertFailure:
            {
                self.alertView = [[AMSmoothAlertView alloc] initDropAlertWithTitle:@"Sorry !"
                                                                           andText:@"You've just displayed this awesome alert view !"
                                                                      forAlertType:AlertFailure
                                                                          andColor:nil
                                                           withDefaultButtonAction:^{
                                                               NSLog(@"Default touched");
                                                           } withCancelButtonAction:nil];
                
                [self.alertView.defaultButton setTitle:@"Too Bad :(" forState:UIControlStateNormal];
            }
                break;
            case AlertInfo:
            {
                self.alertView = [[AMSmoothAlertView alloc] initDropAlertWithTitle:@"Notice !"
                                                                           andText:nil
                                                                      forAlertType:AlertInfo
                                                                          andColor:nil
                                                           withDefaultButtonAction:^{
                                                               NSLog(@"Default touched");
                                                           } withCancelButtonAction:^{
                                                               NSLog(@"Cancel touched");
                                                           }];
                
                [self.alertView setTitleFont:[UIFont fontWithName:@"Verdana" size:25.0f]];
            }
                break;
            case 3:
            {
                // Custom colored alert of type AlertInfo, custom colors can be applied to any alert type
                self.alertView = [[AMSmoothAlertView alloc] initDropAlertWithTitle:@"Notice !"
                                                                           andText:nil
                                                                      forAlertType:AlertInfo
                                                                          andColor:[UIColor colorWithRed:0.607 green:0.372 blue:0.862 alpha:1]
                                                           withDefaultButtonAction:^{
                                                               NSLog(@"Default touched");
                                                           } withCancelButtonAction:^{
                                                               NSLog(@"Cancel touched");
                                                           }];
                
                [self.alertView setTitleFont:[UIFont fontWithName:@"Verdana" size:25.0f]];
            }
                break;
            case 4:
            {
                self.alertView = [[AMSmoothAlertView alloc] initDropAlertWithTitle:@"Notice !"
                                                                           andText:@"This fires the delegate methods; Check your console!"
                                                                      forAlertType:AlertInfo
                                                                          andColor:nil
                                                           withDefaultButtonAction:^{
                                                               NSLog(@"Default touched");
                                                           } withCancelButtonAction:^{
                                                               NSLog(@"Cancel touched");
                                                           }];
                
				[self.alertView setTitleFont:[UIFont fontWithName:@"Verdana" size:25.0f]];
            }
				break;

                
            default:
                break;
        }
        
        self.alertView.tag = 0;
        
        self.alertView.delegate = self;
        
        self.alertView.cornerRadius = 3.0f;
        
        [self.alertView show];
    }
    else
    {
        [self.alertView dismissAlertView];
    }
}

#pragma mark - Delegates
- (void)alertViewWillShow:(AMSmoothAlertView *)alertView {
    if (alertView.tag == 0)
        NSLog(@"AlertView Will Show: '%@'", alertView.titleLabel.text);
}

- (void)alertViewDidShow:(AMSmoothAlertView *)alertView {
	NSLog(@"AlertView Did Show: '%@'", alertView.titleLabel.text);
}

- (void)alertViewWillDismiss:(AMSmoothAlertView *)alertView {
	NSLog(@"AlertView Will Dismiss: '%@'", alertView.titleLabel.text);
}

- (void)alertViewDidDismiss:(AMSmoothAlertView *)alertView {
	NSLog(@"AlertView Did Dismiss: '%@'", alertView.titleLabel.text);
}

@end
