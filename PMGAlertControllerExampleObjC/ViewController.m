//
//  ViewController.m
//  PMGAlertControllerExampleObjC
//
//  Created by Jacob King on 13/01/2017.
//  Copyright © 2017 Parkmobile Group. All rights reserved.
//

#import "ViewController.h"
@import PMGAlertController;

@interface ViewController ()

@end

@implementation ViewController

// DEMO of most basic alert view, using pre-built convenience method and no animation.
- (IBAction)demo1:(id)sender {
    PMGAlertController *alert = [PMGAlertController basicOneButtonWithTitle:@"Error" body:@"The server cannot be reached, please try again later." dismissAutomatically:YES buttonTitle:@"Okay" buttonAction:^(id _Nonnull sender, PMGAlertController * _Nonnull alert) {
        
        NSLog(@"Dismissing");
        // Note that `dismissAutomatically:` is set to YES.
        // Executed when button is pressed.
        
    }];
    
    [alert showAlertWithAnimation:PMGAlertControllerShowAnimationNone];
}

// DEMO of text input alert view, with 2 buttons and a fade animation. Uses convenience builder.
- (IBAction)demo2:(id)sender {
    PMGAlertController *alert = [PMGAlertController basicTextInputWithTitle:@"Reset my password" body:@"Enter the mobile number or email address you used when creating our account. Then hit the send button and we will send you a text or email with instructions on how to reset your password." dismissAutomatically:NO  textfieldPlaceholder:@"Mobile or email" buttonOneTitle:@"Send" buttonOneAction:^(id _Nonnull sender, PMGAlertController * _Nonnull alert) {
        
        NSLog(@"Dismissing");
        [alert dismissAlertWithAnimation:PMGAlertControllerHideAnimationFade];
        // Executed when button is pressed.
        
    } buttonTwoTitle:@"Cancel" buttonTwoAction:^(id _Nonnull sender, PMGAlertController * _Nonnull alert) {
        
        NSLog(@"Dismissing");
        [alert dismissAlertWithAnimation:PMGAlertControllerHideAnimationFade];
        // Executed when button is pressed.
        
    }];
    
    [alert showAlertWithAnimation:PMGAlertControllerShowAnimationFade];
}

// DEMO of totally custom built alert view with no convenience builder.
- (IBAction)demo3:(id)sender {
    
    PMGAlertController *alert = [PMGAlertController empty];
    
    PMGAlertControllerTitleComponent *title = [PMGAlertControllerTitleComponent withTitleText:@"ParkNow sticker required"];
    
    PMGAlertControllerBodyComponent *body = [PMGAlertControllerBodyComponent withBodyText:@"This on-street location requires a parking sitcker to be displayed in the windscreen of your vehicle.\n\nDon’t have a parking sticker yet? You can download the parking sticker for free on park-now.com or order one below. Alternatively, you can place a note with ‘ParkNow Handyparken’ behind your windscreen."];
    
    PMGAlertControllerCheckboxComponent *box = [PMGAlertControllerCheckboxComponent withText:@"Don't remind me" defaultStateIsTicked:NO toggleAction:^(UIButton * _Nonnull button, BOOL checked) {
        // Executed when checkbox is toggled.
    }];
    
    PMGAlertControllerButtonComponent *button1 = [PMGAlertControllerButtonComponent submissiveButtonWithText:@"Start parking" andAction:^(id _Nonnull sender) {
        // Executed when button is pressed.
        [alert dismissAlertWithAnimation:PMGAlertControllerHideAnimationSlideCentre];
    }];
    
    PMGAlertControllerButtonComponent *button2 = [PMGAlertControllerButtonComponent standardButtonWithText:@"Order a sticker" andAction:^(id _Nonnull sender) {
        // Executed when button is pressed.
        [alert dismissAlertWithAnimation:PMGAlertControllerHideAnimationSlideCentre];
    }];
    
    PMGAlertControllerButtonComponent *button3 = [PMGAlertControllerButtonComponent standardButtonWithText:@"Cancel" andAction:^(id _Nonnull sender) {
        // Executed when button is pressed.
        [alert dismissAlertWithAnimation:PMGAlertControllerHideAnimationSlideCentre];
    }];
    
    // As this is custom, apply custom spacing to components.
    [title applyConstraintMap:[[PMGAlertControllerConstraintMap alloc] initWithTop:16 bottom:8 left:16 right:16 height:0.0]];
    [body applyConstraintMap:[[PMGAlertControllerConstraintMap alloc] initWithTop:8 bottom:8 left:16 right:16 height:0.0]];
    [box applyConstraintMap:[[PMGAlertControllerConstraintMap alloc] initWithTop:8 bottom:16 left:16 right:16 height:20]];
    
    alert.components = @[title, body, box, button1, button2, button3];
    [alert showAlertWithAnimation:PMGAlertControllerShowAnimationSlideCentre];
}

@end
