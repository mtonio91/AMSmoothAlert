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
                alert = [[AMSmoothAlertView alloc]initDropAlertWithTitle:@"Congrats !" andText:@"You've just displayed this awesome alert view !" forAlertType:AlertSuccess];
                break;
            case AlertFailure:
                alert = [[AMSmoothAlertView alloc]initFadeAlertWithTitle:@"Sorry !" andText:@"You've just displayed this awesome alert view !" forAlertType:AlertFailure];
                [alert.defaultButton setTitle:@"Too Bad :(" forState:UIControlStateNormal];
                break;
            case AlertInfo:
                alert = [[AMSmoothAlertView alloc]initDropAlertWithTitle:@"Notice !" andText:@"You've just displayed this awesome alert view !" forAlertType:AlertInfo];
                [alert setTitleFont:[UIFont fontWithName:@"Verdana" size:25.0f]];
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




@end
