//
//  ViewController.swift
//  MSAlertControllerExampleSwift
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

import UIKit
import MSAlertController

class ViewController: UIViewController {
    
    // DEMO of most basic alert view, using pre-built convenience method and no animation.
    @IBAction func demo1(_ sender: Any) {
        
        let alert = MSAlertController.basicOneButton(title: "Error", body: "The server cannot be reached, please try again later.", buttonTitle: "Okay") { (sender, alert) in
            print("Dismissing")
            // Executed when button is pressed.
            
        }
        
        alert.showAlert(withAnimation: .none)
    }
    
    // DEMO of text input alert view, with 2 buttons and a fade animation. Uses convenience builder.
    @IBAction func demo2(_ sender: Any) {
        
        let alert = MSAlertController.basicTextInput(title: "Reset my password", body: "Enter the mobile number or email address you used when creating your account. Then hit the send button and we will send you a text or email with instructions on how to reset your password.", textfieldPlaceholder: "Mobile or email", buttonOneTitle: "Send",
                                                     buttonOneAction: { (sender, alert) in
                                                        
                                                        alert.dismissAlert(withAnimation: .fade)
                                                        // Executed when button is pressed.
                                                        
        }, buttonTwoTitle: "Cancel") { (sender, alert) in
            print("Dismissing")
            // Executed when button is pressed.
            
        }
        
        alert.showAlert(withAnimation: .fade)
    }
    
    // DEMO of totally custom built alert view with no convenience builder.
    @IBAction func demo3(_ sender: Any) {
        
        let alert = MSAlertController.empty()
        
        let title = MSAlertControllerTitleComponent.withTitleText("Licence Required")
        
        let body = MSAlertControllerBodyComponent.withBodyText("You must purchase a licence to continually use this software.")
        
        let box = MSAlertControllerCheckboxComponent.withText("Don't remind me", defaultStateIsTicked: false) { (button, ticket) in
            // Executed when checkbox is toggled.
        }
        
        let button1 = MSAlertControllerButtonComponent.submissiveButtonWithText("Continue with evaluation") { (sender) in
            alert.dismissAlert(withAnimation: .slideCentre)
            // Executed when button is pressed.
        }
        
        let button2 = MSAlertControllerButtonComponent.standardButtonWithText("Purchase a licence") { (sender) in
            alert.dismissAlert(withAnimation: .slideCentre)
            // Executed when button is pressed.
        }
        
        let button3 = MSAlertControllerButtonComponent.standardButtonWithText("Cancel") { (sender) in
            alert.dismissAlert(withAnimation: .slideCentre)
            // Executed when button is pressed.
        }
        
        // As this is custom, apply custom spacing to components.
        title.applyConstraintMap(MSAlertControllerConstraintMap(top: 16, bottom: 8, left: 16, right: 16))
        body.applyConstraintMap(MSAlertControllerConstraintMap(top: 8, bottom: 8, left: 16, right: 16))
        box.applyConstraintMap(MSAlertControllerConstraintMap(top: 8, bottom: 16, left: 16, right: 16, height: 20))
        
        alert.components = [title, body, box, button1, button2, button3]
        alert.showAlert(withAnimation: .slideCentre)
    }
}

