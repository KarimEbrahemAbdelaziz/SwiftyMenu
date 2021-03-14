<p align="center">
    <img src="https://github.com/KarimEbrahemAbdelaziz/SwiftyMenu/blob/master/Screenshots/Logo.png" width="480” max-width="90%" alt="SwiftyMenu" />
</p>

<p align="center">
    <img src="https://github.com/KarimEbrahemAbdelaziz/SwiftyMenu/workflows/Build/badge.svg" />
    <img src="https://img.shields.io/badge/Swift-5.0-orange.svg" />
    <a href="https://cocoadocs.org/pods/SwiftyMenu/">
        <img src="http://img.shields.io/badge/Cocoapods-available-green.svg?style=flat" alt="Cocoapod" />
    </a>
    <img src="http://img.shields.io/badge/version-0.6.4-green.svg?style=flat" alt="Version" />
    <a href="https://github.com/KarimEbrahemAbdelaziz/SwiftyMenu/blob/master/LICENSE">
        <img src="http://img.shields.io/badge/license-MIT-70a1fb.svg?style=flat" alt="MIT License" />
    </a>
    <br>
    <a href="https://www.facebook.com/KarimEbrahemAbdelaziz">
        <img src="http://img.shields.io/badge/facebook-%40KarimEbrahemAbdelaziz-70a1fb.svg?style=flat" alt="Facebook: @KarimEbrahemAbdelaziz" />
    </a>
    <a href="https://twitter.com/@k_ebrahem_">
        <img src="https://img.shields.io/badge/twitter-@k_ebrahem_-blue.svg?style=flat" alt="Twitter: @k_ebrahem_" />
    </a>
</p>

#

SwiftyMenu is simple yet powerfull drop down menu component for iOS. It allow you to have drop down menu that doesn't appear over your views, which give you awesome user experience.

- [Screenshots](#screenshots)
- [Requirements](#requirements)
- [Installation](#installation)
    - [Cocoapods](#cocoapods)
- [Usage](#usage)
    - [Storyboard](#storyboard)
    - [Customize UI](#customizeui)
- [Todo](#todo)
- [Android Version](#android)
- [Author](#author)
- [Credits](#credits)
- [License](#license)

## Screenshots

<img src="https://github.com/KarimEbrahemAbdelaziz/SwiftyMenu/blob/master/Screenshots/2.gif" width="250" height="500"> <img src="https://github.com/KarimEbrahemAbdelaziz/SwiftyMenu/blob/master/Screenshots/1.png" width="250" height="500"> <img src="https://github.com/KarimEbrahemAbdelaziz/SwiftyMenu/blob/master/Screenshots/3.png" width="250" height="500">

## Requirements

* Xcode 10.2+
* Swift 5+
* iOS 10+

## Installation

### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate SwiftyMenu into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'SwiftyMenu', '~> 0.6.5'
```

## Usage

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

// Define your Generic items array)
private let items: [SwiftyMenuDisplayable] = ["Option 1", "Option 2", "Option 3", "Option 4"]

// Assign the component that implement SwiftyMenuDelegate to SwiftyMenu component
dropDownMenu.delegate = self

// Give array of items to SwiftyMenu
dropDownMenu.items = items
```

Then implement SwiftyMenuDelegate:

```swift
extension ViewController: SwiftyMenuDelegate {
    // Get selected option from SwiftyMenu
    func swiftyMenu(_ swiftyMenu: SwiftyMenu, didSelectItem item: SwiftyMenuDisplayable, atIndex index: Int) {
        print("Selected item: \(item), at index: \(index)")
    }
    
    // SwiftyMenu drop down menu will expand
    func swiftyMenu(willExpand swiftyMenu: SwiftyMenu) {
        print("SwiftyMenu willExpand.")
    }

    // SwiftyMenu drop down menu did expand
    func swiftyMenu(didExpand swiftyMenu: SwiftyMenu) {
        print("SwiftyMenu didExpand.")
    }

    // SwiftyMenu drop down menu will collapse
    func swiftyMenu(willCollapse swiftyMenu: SwiftyMenu) {
        print("SwiftyMenu willCollapse.")
    }

    // SwiftyMenu drop down menu did collapse
    func swiftyMenu(didCollapse swiftyMenu: SwiftyMenu) {
        print("SwiftyMenu didCollapse.")
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

dropDown.didSelectItem = { menu, item, index in
    print("\(item) at index: \(index)")
}
```

### CustomizeUI

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
dropDownMenu.itemTextColor = .red
dropDownMenu.placeHolderColor = .blue
dropDownMenu.menuHeaderBackgroundColor = .lightGray
dropDownMenu.rowBackgroundColor = .orange
dropDown.separatorColor = .white

// Change drop down menu default expand and collapse animation
dropDownMenu.expandingAnimationStyle = .spring(level: .low)
dropDownMenu.expandingDuration = 0.5
dropDownMenu.collapsingAnimationStyle = .linear
dropDownMenu.collapsingDuration = 0.5
````

## TODO

- [x] Automate release new version to Cocoapods from Github Actions.
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

## Android 

- [ExpandableSelectionView](https://github.com/ashrafDoubleO7/ExpandableSelectionView), Thanks to [Ahmed Ashraf](https://github.com/ashrafDoubleO7) ❤️💪🏻

## Author

Karim Ebrahem, karimabdelazizmansour@gmail.com

## License

SwiftyMenu is available under the MIT license. See the `LICENSE` file for more info.

## Credits

You can find me on Twitter [@k_ebrahem_](https://twitter.com/k_ebrahem_).

It will be updated when necessary and fixes will be done as soon as discovered to keep it up to date.

Enjoy!
