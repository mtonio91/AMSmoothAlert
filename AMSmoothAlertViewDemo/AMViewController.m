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
                break;
            case AlertFailure:
                alert = [[AMSmoothAlertView alloc]initFadeAlertWithTitle:@"Sorry !" andText:@"You've just displayed this awesome alert view !" andCancelButton:NO forAlertType:AlertFailure];
                [alert.defaultButton setTitle:@"Too Bad :(" forState:UIControlStateNormal];
                break;
            case AlertInfo:
                alert = [[AMSmoothAlertView alloc]initDropAlertWithTitle:@"Notice !" andText:@"You've just displayed this awesome alert view !" andCancelButton:YES forAlertType:AlertInfo];
                [alert setTitleFont:[UIFont fontWithName:@"Verdana" size:25.0f]];
                break;
            case AlertInfoPurple:
                alert = [[AMSmoothAlertView alloc]initDropAlertWithTitle:@"Notice !" andText:@"You've just displayed this awesome alert view !" andCancelButton:YES forAlertType:AlertInfoPurple];
                [alert setTitleFont:[UIFont fontWithName:@"Verdana" size:25.0f]];
                break;
            case 4:
				alert = [[AMSmoothAlertView alloc]initDropAlertWithTitle:@"Notice !" andText:@"This fires the delegate methods; Check your console!" andCancelButton:YES forAlertType:AlertInfo];
				[alert setTitleFont:[UIFont fontWithName:@"Verdana" size:25.0f]];
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

#pragma mark - Delegate
- (void)alertView:(AMSmoothAlertView *)alertView didDismissWithButton:(UIButton *)button {
	if (alertView == alert) {
		if (button == alert.defaultButton) {
			NSLog(@"Default button touched!");
			[alertView dismissAlertView];
		}
		if (button == alert.cancelButton) {
			NSLog(@"Cancel button touched!");
			[alertView dismissAlertView];
		}
	}
}


@end
