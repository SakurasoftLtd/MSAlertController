MSAlertController
============

MSAlertController is a reusable and infinitely customisable substitute for the standard iOS UIAlertControllerController written entirely in Swift. It has been designed for ease of use as well as ease of customisation so it can be integrated into any project, seamlessly matching the style of that project.

## Getting started

MSAlertController is designed to get up and running in your app quickly, integrated as source code, or as a framework.

### Requirements

| MSAlertController Version | Minimum iOS Target  |                                   Notes                                   |
|:--------------------:|:---------------------------:|:----------------------------:|:-------------------------------------------------------------------------:|
|          1.0         |            8.2            | Xcode 8 is required. |

MSAlertController is written entirely in Swift, however it is fully compatible with Objective-C projects, albeit with a slightly less clean syntax in places. See below for full documentation for both languages.

Swift 3.0 is required to integrate into a Swift codebase.


###Install From Cocoapods

*Cocoapods support coming soon.*

###Install as Framework
Download the source code from Stash and compile the MSAlertController framework target, and then within your application, add the following:

```objective-c
// Objective-C

// Add this line to your bridging header to import the Swift classes of MSAlertController.
#import <MSAlertController/MSAlertController-Swift.h>

// In any subsequent source files that reference MSAlertController, import the module like so:
@import MSAlertController;
```
```swift
// Swift

// In any source file that references MSAlertController, import it like so:
import MSAlertController
```
###Install as Source
Download the source code from Stash and add to your target the contents of the MSAlertController root directory:

```objective-c
// Objective-C

// Add this line to your bridging header to import the Swift classes of MSAlertController.
#import "MSAlertController-Swift.h"

// In any subsequent source files that reference MSAlertController, import the module like so:
@import MSAlertController;
```
```swift
// Swift

// No additional import needed when installed as Swift source.
```

##Getting help and support
This library was originally written by Jacob King, of Cobalt Telephone Technologies Ltd. Whilst it is well documented here, if you have any questions that aren't covered please reach out to him.

## Usage

### Basic Usage

Once the necessary imports, detailed above, have been made, you can begin to use MSAlertController straight away. MSAlertController is supplied out of the box with some helper methods to get you up and running as quick as possible.

Research shows that the most commonly used alerts are basic title, body and button alerts; usually with either one or two buttons. MSAlertController makes it easy to create such basic alerts, as shown below:

```objective-c
// Objective-C

MSAlertController *alert = [MSAlertController basicOneButtonWithTitle:@"Error" body:@"The server cannot be reached, please try again later." dismissedAutomatically:NO buttonTitle:@"Okay" buttonAction:^(id _Nonnull sender, MSAlertController * _Nonnull alert) {
        
        [alert dismissAlertWithAnimation:MSAlertControllerHideAnimationNone];
        // Executed when button is pressed.
        
    }];
    
    [alert showAlertWithAnimation:MSAlertControllerShowAnimationNone];
```
```swift
// Swift

let alert = MSAlertController.basicOneButton(title: "Error", body: "The server cannot be reached, please try again later.", dismissAutomatically:false, buttonTitle: "Okay") { (sender, alert) in
            
            alert.dismissAlert(withAnimation: .none)
            // Executed when button is pressed.
            
        }
        
        alert.showAlert(withAnimation: .none)
```
As you can see, the above code will create and show a basic, single button alert, which dismisses when the button it contains is tapped. MSAlertController also includes a builder method for a two-button alert incase you need to give your users a choice. The code for this is largely the same, but with added details of the second button:

```objective-c
// Objective-C

MSAlertController *alert = [MSAlertController basicTwoButtonWithTitle:@"Question!" body:@"Do you like marmite?" dismissAutomatically:NO buttonOneTitle:@"Yes" buttonOneAction:^(id _Nonnull sender, MSAlertController * _Nonnull alert) {

        [alert dismissAlertWithAnimation:MSAlertControllerHideAnimationNone];
        
    } buttonTwoTitle:@"No" buttonTwoAction:^(id _Nonnull sender, MSAlertController * _Nonnull alert) {
    
        [alert dismissAlertWithAnimation:MSAlertControllerHideAnimationNone];
        
    }];
    
    [alert showAlertWithAnimation:MSAlertControllerShowAnimationNone];
```
```swift
// Swift

let alert = MSAlertController.basicTwoButton(title: "Question!", body: "Do you like marmite?", dismissAutomatically:false, buttonOneTitle: "Yes", buttonOneAction: { (sender, alert) in
            
            alert.dismissAlert(withAnimation: .none)
            
        }, buttonTwoTitle: "No") { (sender, alert) in
            
            alert.dismissAlert(withAnimation: .none)
            
        }
        
        alert.showAlert(withAnimation: .none)
```

###Components
Due to MSAlertController's infinitely customisable nature, every alert is comprised of 'components'. Take the alerts that are shown above, for example. They are comprised of a title component, a body component and either one or two button components.

In the same way as the built in methods seen above create alerts, you can build your own custom alerts using a powerful set of APIs built right into each component. Let's look in more detail. I want an alert that includes a title, body, checkbox and 3 buttons; but there is no built in method in MSAlertController to make this? No problem, you can build the alert yourself with easy to use methods. An example for the above criteria is shown below:

####Example Alert, built from components:

```objective-c
// Objective-C

MSAlertController *alert = [MSAlertController empty];
    
    MSAlertControllerTitleComponent *title = [MSAlertControllerTitleComponent withTitleText:@"ParkNow sticker required"];
    
    MSAlertControllerBodyComponent *body = [MSAlertControllerBodyComponent withBodyText:@"This on-street location requires a parking sitcker to be displayed in the windscreen of your vehicle.\n\nDon’t have a parking sticker yet? You can download the parking sticker for free on park-now.com or order one below. Alternatively, you can place a note with ‘ParkNow Handyparken’ behind your windscreen."];
    
    MSAlertControllerCheckboxComponent *box = [MSAlertControllerCheckboxComponent withText:@"Don't remind me" defaultStateIsTicked:NO toggleAction:^(UIButton * _Nonnull button, BOOL checked) {
        // Executed when checkbox is toggled.
    }];
    
    MSAlertControllerButtonComponent *button1 = [MSAlertControllerButtonComponent submissiveButtonWithText:@"Start parking" andAction:^(id _Nonnull sender) {
        // Executed when button is pressed.
        [alert dismissAlertWithAnimation:MSAlertControllerHideAnimationSlideCentre];
    }];
    
    MSAlertControllerButtonComponent *button2 = [MSAlertControllerButtonComponent standardButtonWithText:@"Order a sticker" andAction:^(id _Nonnull sender) {
        // Executed when button is pressed.
        [alert dismissAlertWithAnimation:MSAlertControllerHideAnimationSlideCentre];
    }];
    
    MSAlertControllerButtonComponent *button3 = [MSAlertControllerButtonComponent standardButtonWithText:@"Cancel" andAction:^(id _Nonnull sender) {
        // Executed when button is pressed.
        [alert dismissAlertWithAnimation:MSAlertControllerHideAnimationSlideCentre];
    }];
    
    // As this is custom, apply custom spacing to components.
    [title applyConstraintMapWithMap:[[MSAlertControllerConstraintMap alloc] initWithTop:[NSNumber numberWithInteger:16] bottom:[NSNumber numberWithInteger:8] left:[NSNumber numberWithInteger:16] right:[NSNumber numberWithInteger:16] height:nil]];
    [body applyConstraintMapWithMap:[[MSAlertControllerConstraintMap alloc] initWithTop:[NSNumber numberWithInteger:8] bottom:[NSNumber numberWithInteger:8] left:[NSNumber numberWithInteger:16] right:[NSNumber numberWithInteger:16] height:nil]];
    [box applyConstraintMapWithMap:[[MSAlertControllerConstraintMap alloc] initWithTop:[NSNumber numberWithInteger:8] bottom:[NSNumber numberWithInteger:16] left:[NSNumber numberWithInteger:16] right:[NSNumber numberWithInteger:16] height:[NSNumber numberWithInteger:20]]];
    
    alert.components = @[title, body, box, button1, button2, button3];
    [alert showAlertWithAnimation:MSAlertControllerShowAnimationSlideCentre];

```
```Swift
// Swift

let alert = MSAlertController.empty()
        
        let title = MSAlertControllerTitleComponent.withTitleText("ParkNow sticker required")
        
        let body = MSAlertControllerBodyComponent.withBodyText("This on-street location requires a parking sitcker to be displayed in the windscreen of your vehicle.\n\nDon’t have a parking sticker yet? You can download the parking sticker for free on park-now.com or order one below. Alternatively, you can place a note with ‘ParkNow Handyparken’ behind your windscreen.")
        
        let box = MSAlertControllerCheckboxComponent.withText("Don't remind me", defaultStateIsTicked: false) { (button, ticket) in
            // Executed when checkbox is toggled.
        }
        
        let button1 = MSAlertControllerButtonComponent.submissiveButtonWithText("Start parking") { (sender) in
            alert.dismissAlert(withAnimation: .slideCentre)
            // Executed when button is pressed.
        }
        
        let button2 = MSAlertControllerButtonComponent.standardButtonWithText("Order a sticker") { (sender) in
            alert.dismissAlert(withAnimation: .slideCentre)
            // Executed when button is pressed.
        }
        
        let button3 = MSAlertControllerButtonComponent.standardButtonWithText("Cancel") { (sender) in
            alert.dismissAlert(withAnimation: .slideCentre)
            // Executed when button is pressed.
        }
        
        // As this is custom, apply custom spacing to components.
        title.applyConstraintMap(map: MSAlertControllerConstraintMap(top: 16, bottom: 8, left: 16, right: 16, height: nil))
        body.applyConstraintMap(map: MSAlertControllerConstraintMap(top: 8, bottom: 8, left: 16, right: 16, height: nil))
        box.applyConstraintMap(map: MSAlertControllerConstraintMap(top: 8, bottom: 16, left: 16, right: 16, height: 20))
        
        alert.components = [title, body, box, button1, button2, button3]
        alert.showAlert(withAnimation: .slideCentre)
```

The above code might look daunting, but once we break it down it's very simple.

 1. First, we declare an empty instance of MSAlertController.
 2. Next, we declare all of the components we want to use in our alert, in the case of the above example we want a title, body, checkbox and 3 buttons. Each component has an initialiser that grabs all the required information for that component to work, details on these can be found in the breakdown of each component below.
 3. After that, a constraint map should be applied to each component.  A constraint map is just an easy way of specifying the spacing around each component. This example adds padding of 16pts on all sides and between each component. Notice how title and body components don't get a specified height, this is automatically calculated and should be excluded. All other components will need a specified height, though.
 4. Set the alert's `components` property to an array containing all the components.
 5. Finally, show the alert using an animation of your choice. More on animations below.

##Components - Detail

MSAlertController has a number of built in components, as briefly touched on above. As of writing these are:

 - MSAlertControllerTitleComponent
 - MSAlertControllerBodyComponet
 - MSAlertControllerSpacerComponent
 - MSAlertControllerButtonComponent
 - MSAlertControllerTextfieldComponent
 - MSAlertControllerCheckboxComponent
 - MSAlertControllerEmbedComponent

These components are detailed below.

####**MSAlertControllerTitleComponent**

The title component exposes 3 static builder methods, the first two are convenience builders and simply take the title text (or attributed text) as an argument, they do all the heavy lifting for you.

```swift
public static func withTitleText(_ text: String) -> MSAlertControllerTitleComponent

public static func withAttributedTitleText(_ attributedText: NSAttributedString) -> MSAlertControllerTitleComponent
```

In most scenarios you will use one of these two methods to create title components, however in the event that you need such drastic customisation that you need access to the actual label object, you can use a third method that exposes this label in a configuration block:

```swift
public static func withCustomConfiguration(_ configHandler: @escaping ((_ label: UILabel) -> Void)) -> MSAlertControllerTitleComponent
```

####**MSAlertControllerBodyComponent**

The body component exposes the same methods as the title component, and is in effect the same component. The only thing that sets it apart is the styling.

```swift
public static func withBodyText(_ text: String) -> MSAlertControllerBodyComponent

public static func withAttributedBodyText(_ attributedText: NSAttributedString) -> MSAlertControllerBodyComponent

public static func withCustomConfiguration(_ configHandler: @escaping ((_ label: UILabel) -> Void)) -> MSAlertControllerBodyComponent
```

####**MSAlertControllerSpacerComponent**

The spacer component is something you will rarely use, it existed before I implemented the constraint map system as a way of applying custom spacing to components. Everything that it can do can be done with less code using the constraint map, but by way of completeness I have left it in incase you want to use it. It exposes only one method that allows you to set **vertical** spacing between components. The spacing is added between whichever components are adjacent to it in the alert's `components` array.

```swift
public static func withSpacing(_ spacing: CGFloat) -> MSAlertControllerSpacerComponent
```

####**MSAlertControllerButtonComponent**

The button component is crucial to all alerts as it is the main way in which an alert will be dismissed or acted upon. It exposes 4 methods, however 3 of these are basically the same but the one you use dictates how the button is styled. 3 styles exist, these are `standard`,  `destructive` and `submissive`. These styles are reflected below, along with the standard custom config method, exposing the UIButton object.

```swift
standardButtonWithText(_ text: String, andAction action: @escaping ((_ sender: Any) -> Void)) -> MSAlertControllerButtonComponent

destructiveButtonWithText(_ text: String, andAction action: @escaping ((_ sender: Any) -> Void)) -> MSAlertControllerButtonComponent

submissiveButtonWithText(_ text: String, andAction action: @escaping ((_ sender: Any) -> Void)) -> MSAlertControllerButtonComponent

withCustomConfiguration(_ configHandler: @escaping ((_ button: UIButton) -> Void), andButtonAction action: @escaping ((_ sender: Any) -> Void)) -> MSAlertControllerButtonComponent
```

####**MSAlertControllerTextFieldComponent**

MSAlertController also includes a built in UITextField based component incase you want to capture information from the user in your alert. It exposes 3 methods that can be seen below.

```swift
public static func withPlaceholderText(_ text: String) -> MSAlertControllerTextFieldComponent

public static func withPlaceholderText(_ text: String, keyboard: UIKeyboardType, secureEntry: Bool) -> MSAlertControllerTextFieldComponent

public static func withCustomConfiguration(_ configHandler: @escaping ((_ textfield: UITextField) -> Void)) -> MSAlertControllerTextFieldComponent
```

####**MSAlertControllerCheckboxComponent**

The checkbox component displays an interactive checkbox that can be ticked and un-ticked when the user taps it. It exposes 2 methods, one of which is the usual custom config method:

```swift
public static func withText(_ text: String, defaultStateIsTicked: Bool, toggleAction: @escaping ((_ sender: UIButton, _ checkboxIsTicked: Bool) -> Void)) -> MSAlertControllerCheckboxComponent

public static func withCustomConfiguration(_ configHandler: @escaping ((_ checkbox: UIView) -> Void)) -> MSAlertControllerCheckboxComponent
```

####**MSAlertControllerEmbedComponent**

This is perhaps the most powerful of all the components, it allows the user to display any custom view of their choice within the alert. The only criteria for this view is that the user must specify it's height as it is ambiguous to the alert view. One method is exposed here, with no custom configuration as the user is expected to configure their own view before passing it to the embed component.

```swift
public static func withEmbeddedView(view: UIView, andFixedHeight height: CGFloat) -> MSAlertControllerEmbedComponent
```

##Positioning & Spacing

MSAlertController's components all have a default padding of 0pts on all sides, therefore if you constructed your alert without specifying custom padding, there would be no spacing between components and no padding at the sides.

Fortunately there is an easy API exposed on all components to specify your own custom spacing and padding!
Enter **MSAlertControllerConstraintMap**...

MSAlertControllerConstraintMap is merely a construct that holds 5 NSNumber values, for the four sides as well as the height of a component. It exposes two initialisers, the first allows you to set all constraint values and the second is just for specifying the height of a component whilst maintaining it's default padding:

```swift
public convenience init(top: NSNumber?, bottom: NSNumber?, left: NSNumber?, right: NSNumber?, height: NSNumber?)

public convenience init(height: NSNumber?)
```

`MSAlertControllerComponent` exposes the method `applyConstraintMap`, this takes a constraint map as an argument and applies it to the receiving component. Usage examples are shown below as well as an in-context example towards the beginning of this documentation.

```objective-c
// Objective-C

[title applyConstraintMapWithMap:[[MSAlertControllerConstraintMap alloc] initWithTop:[NSNumber numberWithInteger:16] bottom:[NSNumber numberWithInteger:8] left:[NSNumber numberWithInteger:16] right:[NSNumber numberWithInteger:16] height:nil]];
```
```swift
// Swift

title.applyConstraintMap(map: MSAlertControllerConstraintMap(top: 16, bottom: 8, left: 16, right: 16, height: nil))
```

Notice that the value of `bottom` here is 8 whilst all others have the value of 16? This is because below this title component there is a body component which also has a top value of 8. Both of these together makes 16 and therefore there will be 16pts of padding between the title and body components. Keep this in mind when specifying your constraint values.

##Animation

When you present or dismiss your alert, you can specify an animation which the system will honour when presenting or dismissing the alert. There are currently 3 animation options, but I am actively adding more. The animation options are:

 - No Animation
 - Fade
 - Slide In/Out From/To Centre of Screen

These are represented as enum values which are passed into the `presentAlert` and `dismissAlert` methods of MSAlertController. The raw enums can be seen below, for reference purposes.

```objective-c
// Objective-C

typedef enum MSAlertControllerShowAnimation {
    None,
    Fade,
    SlideCentre
} MSAlertControllerShowAnimation;

typedef enum MSAlertControllerHideAnimation {
    None,
    Fade,
    SlideCentre
} MSAlertControllerHideAnimation;
```

```swift
// Swift

public enum MSAlertControllerShowAnimation: Int {
    case none = 0
    case fade = 1
    case slideCentre = 2
}

public enum MSAlertControllerHideAnimation: Int {
    case none = 0
    case fade = 1
    case slideCentre = 2
}
```

##Theming

You might have noticed the lack of customisation options available in the methods exposed by the various components, this is because MSAlertController uses a theming system to style all of it's UI. This makes it easy to have a consistent style across all the alerts in your app, but is powerful enough to customise the style on a per-alert basis should you want to.

MSAlertController ships with a default theme and will use this theme if you do not provide it with a custom one. The default theme is detailed below:

```swift
public class MSAlertControllerTheme: NSObject {
    
    public var titleFont: UIFont = UIFont.systemFont(ofSize: 17, weight: UIFontWeightMedium)
    public var bodyFont: UIFont = UIFont.systemFont(ofSize: 13, weight: UIFontWeightRegular)
    public var buttonFont: UIFont = UIFont.systemFont(ofSize: 17, weight: UIFontWeightMedium)
    public var textfieldFont: UIFont = UIFont.systemFont(ofSize: 17, weight: UIFontWeightRegular)
    
    public var titleTextColor: UIColor = UIColor(red: 0/255, green: 127/255, blue: 163/255, alpha: 1)
    public var bodyTextColor: UIColor = UIColor(red: 117/255, green: 117/255, blue: 117/255, alpha: 1)
    public var standardButtonTextColor: UIColor = UIColor(red: 0/255, green: 127/255, blue: 163/255, alpha: 1)
    public var destructiveButtonTextColor: UIColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
    public var submissiveButtonTextColor: UIColor = UIColor(red: 156/255, green: 189/255, blue: 35/255, alpha: 1)
    public var alertWindowBackgroundColor: UIColor = UIColor.black.withAlphaComponent(0.4)
    
    public var separatorColor: UIColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
    public var textfieldBorderColor: UIColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
    public var checkboxBorderColor: UIColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
    public var checkboxBackgroundColor: UIColor = UIColor.white
    public var checkboxTickColor: UIColor = UIColor.clear
    
    public var titleTextAlignment: NSTextAlignment = .left
    public var bodyTextAlignment: NSTextAlignment = .left
    
    public var defaultButtonHeight: CGFloat = 44
    public var defaultTextFieldHeight: CGFloat = 48
    public var defaultCheckboxHeight: CGFloat = 20
    
    public var bodyLineSpacing: CGFloat = 4
}
```
MSAlertController has 2 theme related properties, a static `masterTheme` and an instance property `theme`.

```swift
public static var masterTheme: MSAlertControllerTheme = MSAlertControllerTheme()
public var theme: MSAlertControllerTheme = MSAlertController.masterTheme
```

Should you want to change any part of the default theme, you will need to subclass `MSAlertControllerTheme` (the class shown above) and override any properties that you want to change. You can then set `MSAlertController.masterTheme` equal to your custom class to change the theme of all alerts, or just set the `theme` property of a single alert if you so desire.
