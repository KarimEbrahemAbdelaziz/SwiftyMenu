<p align="center">
    <img src="https://github.com/KarimEbrahemAbdelaziz/SwiftyMenu/blob/master/Screenshots/Logo.png" width="480” max-width="90%" alt="SwiftyMenu" />
</p>

<p align="center">
    <img src="https://img.shields.io/badge/Swift-5.0-orange.svg" />
    <a href="https://travis-ci.org/KarimEbrahemAbdelaziz/SwiftyMenu.svg?branch=master">
        <img src="https://img.shields.io/travis/KarimEbrahemAbdelaziz/SwiftyMenu/master.svg?style=flat" alt="CI Status" />
    </a>
    <a href="https://cocoadocs.org/pods/SwiftyMenu/">
        <img src="http://img.shields.io/badge/Cocoapods-available-green.svg?style=flat" alt="Cocoapod" />
    </a>
    <img src="http://img.shields.io/badge/version-0.5.9-green.svg?style=flat" alt="Version" />
    <a href="https://github.com/KarimEbrahemAbdelaziz/SwiftyMenu/blob/master/LICENSE">
        <img src="http://img.shields.io/badge/license-MIT-70a1fb.svg?style=flat" alt="MIT License" />
    </a>
    <br>
    <a href="https://www.facebook.com/KarimEbrahemAbdelaziz">
        <img src="http://img.shields.io/badge/facebook-%40KarimEbrahemAbdelaziz-70a1fb.svg?style=flat" alt="Facebook: @KarimEbrahemAbdelaziz" />
    </a>
    <a href="https://twitter.com/KarimEbrahem512">
        <img src="https://img.shields.io/badge/twitter-@KarimEbrahem512-blue.svg?style=flat" alt="Twitter: @KarimEbrahem512" />
    </a>
</p>

#

SwiftyMenu is simple yet powerfull drop down menu component for iOS. It allow you to have drop down menu that doesn't appear over your views, which give you awesome user experience.

### Android version 

- [ExpandableSelectionView](https://github.com/ashrafDoubleO7/ExpandableSelectionView), Thanks to [Ahmed Ashraf](https://github.com/ashrafDoubleO7) ❤️💪🏻

## TODO 💪🏻

- [x] Automate release new version to Cocoapods from Travis CI.
- [x] Add CHANGELOG file for the project.
- [ ] Allow custom header and options cells.
- [ ] Allow different interactions to dismiss SwiftyMenu.
- [ ] Allow to customize the default seperator.
- [x] Support Generic DataSource.
- [x] Support multi selection in SwiftMenu 🔥.
- [x] Support multi SwiftyMenu in one screen.
- [x] Support stack view and add example.
- [x] Support call backs and delegation.
- [x] Support different types of Animations. 
- [x] Add different customization to colors for default cells.

And much more ideas to make it solid drop down menu for iOS projects 😎💪🏻

#

## Screenshots 👀

<img src="https://github.com/KarimEbrahemAbdelaziz/SwiftyMenu/blob/master/Screenshots/2.gif" width="250" height="500"> <img src="https://github.com/KarimEbrahemAbdelaziz/SwiftyMenu/blob/master/Screenshots/1.png" width="250" height="500"> <img src="https://github.com/KarimEbrahemAbdelaziz/SwiftyMenu/blob/master/Screenshots/3.png" width="250" height="500">

## Requirements ⚙️

* Xcode 10.2+
* Swift 5
* iOS 10+

## Example 🛠

Do `pod try SwiftyMenu` in your console and run the project to try a demo.
To install [CocoaPods](http://www.cocoapods.org), run `sudo gem install cocoapods` in your console.

## Installation 📱

`SwiftyMenu` supports Swift 5.0 since version `0.1.0`.

### CocoaPods

Use [CocoaPods](http://www.cocoapods.org).

#### Swift 5
1. Add `pod 'SwiftyMenu', '~> 0.5.9'` to your *Podfile*.
2. Install the pod(s) by running `pod install`.
3. Add `import SwiftyMenu` in the .swift files where you want to use it

## Basic Usage 💎

### Storyboard

<img src="https://github.com/KarimEbrahemAbdelaziz/SwiftyMenu/blob/master/Screenshots/4.gif" width="800" height="600">

We are supporting Generic Data Source, all you have to do is conforming to our Generic Protocol on which type you want to add to the menu:

```swift
// Example on String. You can change it to what ever type you want ;)
// String extension to conform SwiftyMenuDisplayable Protocl
extension String: SwiftyMenuDisplayable {
    public var displayableValue: String {
        return self
    }
    
    public var retrivableValue: Any {
        return self
    }
}
```

Then setup your view controller:

```swift
// Connect view in storyboard with you outlet
@IBOutlet private weak var dropDownMenu: SwiftyMenu!

// Define your Generic options array)
private let optionsData: [SwiftyMenuDisplayable] = ["Option 1", "Option 2", "Option 3", "Option 4"]

// Assign the component that implement SwiftyMenuDelegate to SwiftyMenu component
dropDownMenu.delegate = self

// Give array of options to SwiftyMenu
dropDownMenu.options = optionsData
```

Then implement SwiftyMenuDelegate:

```swift
extension ViewController: SwiftyMenuDelegate {
    // Get selected option from SwiftyMenu
    func didSelectOption(_ swiftyMenu: SwiftyMenu, _ selectedOption: SwiftyMenuDisplayable, _ index: Int) {
        print("Selected option: \(selectedOption), at index: \(index)")
    }
    
    // SwiftyMenu drop down menu will appear
    func swiftyMenuWillAppear(_ swiftyMenu: SwiftyMenu) {
        print("SwiftyMenu will appear.")
    }

    // SwiftyMenu drop down menu did appear
    func swiftyMenuDidAppear(_ swiftyMenu: SwiftyMenu) {
        print("SwiftyMenu did appear.")
    }

    // SwiftyMenu drop down menu will disappear
    func swiftyMenuWillDisappear(_ swiftyMenu: SwiftyMenu) {
        print("SwiftyMenu will disappear.")
        }

    // SwiftyMenu drop down menu did disappear
    func swiftyMenuDidDisappear(_ swiftyMenu: SwiftyMenu) {
        print("SwiftyMenu did disappear.")
    }
}
```

Also you can use callbacks to know what happen:

```swift
// Support different callbacks for different events
dropDownMenu.didExpand = {
    print("SwiftyMenu Expanded!")
}

dropDownMenu.didCollapse = {
    print("SwiftyMeny Collapsed")
}

dropDownMenu.didSelectOption = { (selection: Selection) in
    print("\(selection.value) at index: \(selection.index)")
}
```

## Customize UI 😎

You can configure SwiftyMenu from Storyboard or Code as following:

```swift
// Change option's row height (default 35)
dropDownMenu.rowHeight = 35

// Change option's drop down menu height 
// default is 0, which make drop down height = number of options * rowHeight
dropDownMenu.listHeight = 150

// Change drop down menu border width
dropDownMenu.borderWidth = 1.0

// Change drop down menu scroll behavior 
dropDownMenu.scrollingEnabled = false

// Change drop down menu default colors
dropDownMenu.borderColor = .black
dropDownMenu.optionColor = .red
dropDownMenu.placeHolderColor = .blue
dropDownMenu.menuHeaderBackgroundColor = .lightGray
dropDownMenu.rowBackgroundColor = .orange

// Change drop down menu default expand and collapse animation
dropDownMenu.expandingAnimationStyle = .spring(level: .high)
dropDownMenu.expandingDuration = 0.5
dropDownMenu.collapsingAnimationStyle = .linear
dropDownMenu.collapsingDuration = 0.5
````

## Author

Karim Ebrahem, karimabdelazizmansour@gmail.com

## License

SwiftyMenu is available under the MIT license. See the `LICENSE` file for more info.

## Credits

You can find me on Twitter [@KarimEbrahem512](https://twitter.com/KarimEbrahem512).

It will be updated when necessary and fixes will be done as soon as discovered to keep it up to date.

Enjoy!
