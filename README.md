AMSmoothAlert
==================

I saw this pretty cool alert view concept on [Dribbble](https://dribbble.com/shots/1523277-Success-Popup-for-Handybook-New-App-GIF?list=users&offset=0) so i decided to reproduce it !

![Screen1](https://raw.githubusercontent.com/mtonio91/AMSmoothAlert/master/screenCapture.gif)

(the above gif is slower than the real speed animation)

##Installation

It uses : 
- GPUImage Framework

Please note that GPUImage doesn't support arm64 devices yet.

##Easy to use !
Main methods :

```objective-c
//initialisation with a Title and a message
- (id) initWithTitle:(NSString*) title andText:(NSString*) text forAlertType:(AlertType) type;
//set corner radius or not on the alertView
- (void) setCornerRadius:(float)cornerRadius;
//dismiss it !
- (void) dismissAlertView;

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

- performances
- more customisation
- more circles + icons
- more animations

Antoine
