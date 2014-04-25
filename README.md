AMSmoothAlert
==================

![Screen1](https://raw.githubusercontent.com/mtonio91/AMSmoothAlert/master/screenCapture.gif)

##Installation

It uses : 
- GPUImage Framework

Please note that GPUImage doesn't support arm64 devices yet.

Easy to use !
Main methods :
```objective-c
//initialisation with a Title and a message
- (id) initWithTitle:(NSString*) title andText:(NSString*) text;
//set corner radius or not on the alertView
- (void) setCornerRadius:(float)cornerRadius;
//dismiss it !
- (void) dismissAlertView;

```

##Incoming improvments

- performances
- more customisation
- more circles + icons
- more animations

Antoine
