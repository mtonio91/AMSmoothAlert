//
//  AMViewController.m
//  AMSmoothAlertViewDemo
//
//  Created by AMarliac on 2014-04-24.
//  Copyright (c) 2014 AMarliac. All rights reserved.
//

#import "AMViewController.h"

@interface AMViewController ()

@end

@implementation AMViewController
{
    AMSmoothAlertView * alert;
    bool isPopupShown;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openPopup:(id)sender {

    if (!alert || !alert.isDisplayed) {
        UIButton * btn = (UIButton*) sender;
        switch (btn.tag) {
            case AlertSuccess:
                alert = [[AMSmoothAlertView alloc]initDropAlertWithTitle:@"Congrats !" andText:@"You've just displayed this awesome alert view !" andCancelButton:NO forAlertType:AlertSuccess];
                [alert.defaultButton setTitle:@"Great" forState:UIControlStateNormal];
                alert.completionBlock = ^void (AMSmoothAlertView *alertObj, UIButton *button) {
                    if(button == alertObj.defaultButton) {
                        NSLog(@"Default");
                    } else {
                        NSLog(@"Others");
                    }
                };
                break;
            case AlertFailure:
                alert = [[AMSmoothAlertView alloc]initFadeAlertWithTitle:@"Sorry !" andText:@"You've just displayed this awesome alert view !" andCancelButton:NO forAlertType:AlertFailure];
                [alert.defaultButton setTitle:@"Too Bad :(" forState:UIControlStateNormal];
                break;
            case AlertInfo:
                alert = [[AMSmoothAlertView alloc]initDropAlertWithTitle:@"Notice !" andText:@"You've just displayed this awesome alert view !" andCancelButton:YES forAlertType:AlertInfo];
                [alert setTitleFont:[UIFont fontWithName:@"Verdana" size:25.0f]];
                break;
            case 3:
                // Custom colored alert of type AlertInfo, custom colors can be applied to any alert type
                alert = [[AMSmoothAlertView alloc]initDropAlertWithTitle:@"Notice !" andText:@"You've just displayed this awesome alert view! With a custom color!" andCancelButton:YES forAlertType:AlertInfo andColor:[UIColor colorWithRed:0.607 green:0.372 blue:0.862 alpha:1]];
                [alert setTitleFont:[UIFont fontWithName:@"Verdana" size:25.0f]];
                break;
            case 4:
				alert = [[AMSmoothAlertView alloc]initDropAlertWithTitle:@"Notice !" andText:@"This fires the delegate methods; Check your console!" andCancelButton:YES forAlertType:AlertInfo];
				[alert setTitleFont:[UIFont fontWithName:@"Verdana" size:25.0f]];
                alert.tag = 0;
				alert.delegate = self;
				break;

                
            default:
                break;
        }
        
        alert.cornerRadius = 3.0f;
//        [self.view addSubview:alert];
        [alert show];
    }else{
        [alert dismissAlertView];
    }
    

}

#pragma mark - Delegates
- (void)alertView:(AMSmoothAlertView *)alertView didDismissWithButton:(UIButton *)button {
	if (alertView == alert) {
		if (button == alert.defaultButton) {
			NSLog(@"Default button touched!");
		}
		if (button == alert.cancelButton) {
			NSLog(@"Cancel button touched!");
		}
	}
}

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
