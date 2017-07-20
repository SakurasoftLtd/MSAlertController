//
//  ViewController.m
//  MSAlertControllerExampleObjC
//
//  Created by Jacob King on 13/01/2017.
//  Copyright © 2017 Militia Softworks Ltd. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "ViewController.h"
@import MSAlertController;

@interface ViewController ()

@end

@implementation ViewController

// DEMO of most basic alert view, using pre-built convenience method and no animation.
- (IBAction)demo1:(id)sender {
    MSAlertController *alert = [MSAlertController basicOneButtonWithTitle:@"Error" body:@"The server cannot be reached, please try again later." dismissAutomatically:YES buttonTitle:@"Okay" buttonAction:^(id _Nonnull sender, MSAlertController * _Nonnull alert) {
        
        NSLog(@"Dismissing");
        // Note that `dismissAutomatically:` is set to YES.
        // Executed when button is pressed.
        
    }];
    
    [alert showAlertWithAnimation:MSAlertControllerShowAnimationNone];
}

// DEMO of text input alert view, with 2 buttons and a fade animation. Uses convenience builder.
- (IBAction)demo2:(id)sender {
    MSAlertController *alert = [MSAlertController basicTextInputWithTitle:@"Reset my password" body:@"Enter the mobile number or email address you used when creating our account. Then hit the send button and we will send you a text or email with instructions on how to reset your password." dismissAutomatically:NO  textfieldPlaceholder:@"Mobile or email" buttonOneTitle:@"Send" buttonOneAction:^(id _Nonnull sender, MSAlertController * _Nonnull alert) {
        
        NSLog(@"Dismissing");
        [alert dismissAlertWithAnimation:MSAlertControllerHideAnimationFade];
        // Executed when button is pressed.
        
    } buttonTwoTitle:@"Cancel" buttonTwoAction:^(id _Nonnull sender, MSAlertController * _Nonnull alert) {
        
        NSLog(@"Dismissing");
        [alert dismissAlertWithAnimation:MSAlertControllerHideAnimationFade];
        // Executed when button is pressed.
        
    }];
    
    [alert showAlertWithAnimation:MSAlertControllerShowAnimationFade];
}

// DEMO of totally custom built alert view with no convenience builder.
- (IBAction)demo3:(id)sender {
    
    MSAlertController *alert = [MSAlertController empty];
    
    MSAlertControllerTitleComponent *title = [MSAlertControllerTitleComponent withTitleText:@"Licence Required"];
    
    MSAlertControllerBodyComponent *body = [MSAlertControllerBodyComponent withBodyText:@"You must purchase a licence to continually use this software."];
    
    MSAlertControllerCheckboxComponent *box = [MSAlertControllerCheckboxComponent withText:@"Don't remind me" defaultStateIsTicked:NO toggleAction:^(UIButton * _Nonnull button, BOOL checked) {
        // Executed when checkbox is toggled.
    }];
    
    MSAlertControllerButtonComponent *button1 = [MSAlertControllerButtonComponent submissiveButtonWithText:@"Continue with evaluation" andAction:^(id _Nonnull sender) {
        // Executed when button is pressed.
        [alert dismissAlertWithAnimation:MSAlertControllerHideAnimationSlideCentre];
    }];
    
    MSAlertControllerButtonComponent *button2 = [MSAlertControllerButtonComponent standardButtonWithText:@"Purchase a licence" andAction:^(id _Nonnull sender) {
        // Executed when button is pressed.
        [alert dismissAlertWithAnimation:MSAlertControllerHideAnimationSlideCentre];
    }];
    
    MSAlertControllerButtonComponent *button3 = [MSAlertControllerButtonComponent standardButtonWithText:@"Cancel" andAction:^(id _Nonnull sender) {
        // Executed when button is pressed.
        [alert dismissAlertWithAnimation:MSAlertControllerHideAnimationSlideCentre];
    }];
    
    // As this is custom, apply custom spacing to components.
    [title applyConstraintMap:[[MSAlertControllerConstraintMap alloc] initWithTop:16 bottom:8 left:16 right:16 height:0.0]];
    [body applyConstraintMap:[[MSAlertControllerConstraintMap alloc] initWithTop:8 bottom:8 left:16 right:16 height:0.0]];
    [box applyConstraintMap:[[MSAlertControllerConstraintMap alloc] initWithTop:8 bottom:16 left:16 right:16 height:20]];
    
    alert.components = @[title, body, box, button1, button2, button3];
    [alert showAlertWithAnimation:MSAlertControllerShowAnimationSlideCentre];
}

@end
