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
        alert = [[AMSmoothAlertView alloc]initWithTitle:@"Congrats !" andText:@"You've just displayed this awesome alert view !"];
        alert.cornerRadius = 3.0f;
        [self.view addSubview:alert];
    }else{
        [alert dismissAlertView];
    }
    

}




@end
