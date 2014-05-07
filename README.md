AMSmoothAlert
==================
• Now include multiple buttons feature you asked :)

• Now available on Cocoapods : AMSmoothAlert


I saw this pretty cool alert view concept on [Dribbble](https://dribbble.com/shots/1523277-Success-Popup-for-Handybook-New-App-GIF?list=users&offset=0) so i decided to reproduce it !

![Screen1](https://raw.githubusercontent.com/mtonio91/AMSmoothAlert/master/screenCapture.gif)

(the above gif is slower than the real speed animation)

##Installation Cocoapods

Add this in your Podfile
```
pod 'AMSmoothAlert', '~> 1.0'
```
It uses : 
- GPUImage Framework


Please note that GPUImage doesn't support arm64 devices yet.

##Easy to use !
```objective-c
AMSmoothAlertView *alert = [[AMSmoothAlertView alloc]initWithTitle:@"Congrats !" 
        andText:@"You've just displayed this awesome alert view !" 
        forAlertType:AlertSuccess];
```


Main methods :

```objective-c
//initialisation with a Title and a Text message
//drop animation init
- (id) initDropAlertWithTitle:(NSString*) title andText:(NSString*) text forAlertType:(AlertType) type;
//fade in animation init
- (id) initFadeAlertWithTitle:(NSString*) title andText:(NSString*) text forAlertType:(AlertType) type;
//set corner radius or not on the alertView
- (void) setCornerRadius:(float)cornerRadius;
//show the alertview!
- (void) show;
//dismiss it !
- (void) dismissAlertView;

```
You can now edit title and text fonts, circle icon, colors and the "ok" button (multiple button feature is coming soon).
```objective-c
//title font customization
[alert setTitleFont:[UIFont fontWithName:@"Verdana" size:25.0f]];
//text message font customization
[alert setTextFont:[UIFont fontWithName:@"Futura-Medium" size:13.0f]];
//icon customization
[alert.logoView setImage:[UIImage imageNamed:@"checkMark.png"]];

```

Three types of alert views (for now)
```objective-c
typedef enum AlertType : NSInteger AlertType;
enum AlertType : NSInteger {
    AlertSuccess,
    AlertFailure,
    AlertInfo
};
```


##Incoming improvments

- KVO bindings (change the button label for example) 
- performances
- more customisation
- more circles + icons
- more animations


Also check out my other controler [AMLoginViewController](https://github.com/mtonio91/AMLoginViewController)


Antoine
