# SwiftyMenu

[![Facebook: @KarimEbrahemAbdelaziz](http://img.shields.io/badge/contact-%40KarimEbrahem-70a1fb.svg?style=flat)](https://www.facebook.com/KarimEbrahemAbdelaziz)
[![License: MIT](http://img.shields.io/badge/license-MIT-70a1fb.svg?style=flat)](https://github.com/KarimEbrahemAbdelaziz/SwiftyMenu/blob/master/README.md)
[![CI Status](https://img.shields.io/travis/KarimEbrahemAbdelaziz/SwiftyMenu/master.svg?style=flat)](https://travis-ci.org/KarimEbrahemAbdelaziz/SwiftyMenu.svg?branch=master)
[![Version](http://img.shields.io/badge/version-0.1.0-green.svg?style=flat)](https://cocoapods.org/pods/SwiftyMenu)
[![Cocoapods](http://img.shields.io/badge/Cocoapods-available-green.svg?style=flat)](https://cocoadocs.org/pods/SwiftyMenu/)

<img src="https://github.com/KarimEbrahemAbdelaziz/SwiftyMenu/blob/master/Screenshots/2.gif" width="250" height="500"> <img src="https://github.com/KarimEbrahemAbdelaziz/SwiftyMenu/blob/master/Screenshots/1.png" width="250" height="500"> <img src="https://github.com/KarimEbrahemAbdelaziz/SwiftyMenu/blob/master/Screenshots/3.png" width="250" height="500">

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements ⚙️

* Xcode 10.2
* Swift 5
* iOS 10+

## Example 🛠

Do `pod try SwiftyMenu` in your console and run the project to try a demo.
To install [CocoaPods](http://www.cocoapods.org), run `sudo gem install cocoapods` in your console.

## Installation 📱

`SwiftyMenu` supports Swift 5.0 since version `0.1.0`.

### CocoaPods

Use [CocoaPods](http://www.cocoapods.org).

1. Add `pod 'SwiftyMenu'` to your *Podfile*.
2. Install the pod(s) by running `pod install`.
3. Add `import SwiftyMenu` in the .swift files where you want to use it

## Basic Usage 💎

### Storyboard

<img src="https://github.com/KarimEbrahemAbdelaziz/SwiftyMenu/blob/master/Screenshots/4.png" width="800" height="600">

```swift
// Connect view in storyboard with you outlet
@IBOutlet private weak var dropDownMenu: SwiftyMenu!

// Define your options array (for now SwiftyMenu only accept String array, soon it'll be generic 😉)
private let options = ["Option 1", "Option 2", "Option 3", "Option 4"]

// Give array of options to SwiftyMenu
dropDownMenu.options = dropDownOptionsDataSource

// Give SwiftyMenu the clusore to excute when update it's constraints
// If you didn't give it to dropDownMenu, there won't be any animation
dropDownMenu.updateConstraints {
    UIView.animate(withDuration: 0.5, animations: {
        self.view.layoutIfNeeded()
    })
}

// Give SwiftyMenu the clusore to excute when user select an option
dropDownMenu.didSelectOption { (selectedOption, index) in
    print("Selected String: \(selectedOption) at index: \(index)")
}
```

## Author

Karim Ebrahem, karimabdelazizmansour@gmail.com

## License

SwiftyMenu is available under the MIT license. See the `LICENSE` file for more info.

## Credits

You can find me on Twitter [@KarimEbrahem512](https://twitter.com/KarimEbrahem512).

It will be updated when necessary and fixes will be done as soon as discovered to keep it up to date.

Enjoy!
