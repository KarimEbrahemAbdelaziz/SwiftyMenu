<p align="center">
    <img src="https://github.com/KarimEbrahemAbdelaziz/SwiftyMenu/blob/master/Screenshots/Logo.png" width="480” max-width="90%" alt="SwiftyMenu" />
</p>

<p align="center">
    <img src="https://app.bitrise.io/app/71dfd9f5905c292e/status.svg?token=XHvRDPBZjf4d3Y_1f5pKbw&branch=master" />
    <img src="https://img.shields.io/badge/Swift-5.0-orange.svg" />
    <a href="https://cocoadocs.org/pods/SwiftyMenu/">
        <img src="http://img.shields.io/badge/Cocoapods-available-green.svg?style=flat" alt="Cocoapod" />
    </a>
    <img src="http://img.shields.io/badge/SPM-available-green.svg?style=flat" alt="Swift Package Manager" />
    <img src="http://img.shields.io/badge/version-1.0.1-green.svg?style=flat" alt="Version" />
    <a href="https://github.com/KarimEbrahemAbdelaziz/SwiftyMenu/blob/master/LICENSE">
        <img src="http://img.shields.io/badge/license-MIT-70a1fb.svg?style=flat" alt="MIT License" />
    </a>
    <br>
    <a href="https://www.facebook.com/KarimEbrahemAbdelaziz">
        <img src="http://img.shields.io/badge/facebook-%40KarimEbrahemAbdelaziz-70a1fb.svg?style=flat" alt="Facebook: @KarimEbrahemAbdelaziz" />
    </a>
    <a href="https://www.linkedin.com/in/KarimEbrahem">
        <img src="https://img.shields.io/badge/LinkedIn-@KarimEbrahem-blue.svg?style=flat" alt="LinkedIn: @karimebrahem" />
    </a>
</p>

#

SwiftyMenu is simple yet powerfull drop down menu component for iOS. It allow you to have drop down menu that doesn't appear over your views, which give you awesome user experience.

- [Screenshots](#screenshots)
- [Requirements](#requirements)
- [Installation](#installation)
    - [Cocoapods](#cocoapods)
    - [Swift Package Manager](#swift-package-manager)
- [Usage](#usage)
    - [Initialization](#initialization)
        - [Storyboard](#storyboard)
        - [Code](#code)
    - [Configure DataSource](#configure-datasource)
        - [Setup Models](#setup-models)
        - [Assign DataSource](#assign-datasource)
    - [Capture Selection](#capture-selection)
        - [Using Delegate](#using-delegate)
        - [Using Closures](#using-closures)
    - [UI Customization](#ui-customization)
        - [Placeholder](#placeholder)
        - [Text Style](#text-style)
        - [Scroll](#scroll)
        - [Selection Behavior](#selection-behavior)
        - [Row Style](#row-style)
        - [Frame Style](#frame-style)
        - [Arrow Style](#arrow-style)
        - [Separator Style](#separator-style)
        - [Header Style](#header-style)
        - [Accessory](#accessory)
        - [Animation](#animation)
        - [Margin Horizontal](#margin-horizontal)
        - [Error Info](#error-info)
        - [Set Error](#set-error)
    - [New Functionalities](#new-functionalities)
    - [Example Project](#example-project)
- [Todo](#todo)
- [Android Version](#android)
- [Author](#author)
- [Credits](#credits)
- [License](#license)

## Screenshots

<img src="https://github.com/KarimEbrahemAbdelaziz/SwiftyMenu/blob/master/Screenshots/2.gif" width="250" height="500"> <img src="https://github.com/KarimEbrahemAbdelaziz/SwiftyMenu/blob/master/Screenshots/1.png" width="250" height="500"> <img src="https://github.com/KarimEbrahemAbdelaziz/SwiftyMenu/blob/master/Screenshots/3.png" width="250" height="500">

<img src="https://github.com/nowjordanhappy/SwiftyMenu/blob/feature/customization-ui/Screenshots/5.gif" width="250" height="500"> <img src="https://github.com/nowjordanhappy/SwiftyMenu/blob/feature/customization-ui/Screenshots/6.gif" width="250" height="500">

## Requirements

* Xcode 10.2+
* Swift 5+
* iOS 10+

## Installation

### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate SwiftyMenu into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'SwiftyMenu', '~> 1.0.1'
```

### Swift Package Manager

1. Automatically in Xcode:

 - Click **File > Swift Packages > Add Package Dependency...**  
 - Use the package URL `https://github.com/KarimEbrahemAbdelaziz/SwiftyMenu` to add TimelaneCombine to your project.

2. Manually in your **Package.swift** file add:

```swift
.package(url: "https://github.com/KarimEbrahemAbdelaziz/SwiftyMenu", from: "1.0.1")
```

## Usage

`SwiftyMenu` supports initialization from `Storyboard` and `Code`.

### Initialization

#### Storyboard

Setup your view controller:

```swift
// Connect view in storyboard with you outlet
@IBOutlet private weak var dropDownMenu: SwiftyMenu!
```
Then connect `IBOutlet` to `Storyboard`, and connect the `Height` Constraints of the menu as shown below.

<img src="https://github.com/KarimEbrahemAbdelaziz/SwiftyMenu/blob/master/Screenshots/4.gif" width="800" height="600">

#### Code

1. Init `SwiftyMenu`

```swift
/// Init SwiftyMenu from Code
let dropDownCode = SwiftyMenu(frame: CGRect(x: 0, y: 0, width: 0, height: 40))
```
2. Add `SwiftyMenu` as `Subview`

```swift
/// Add it as subview
view.addSubview(dropDownCode)
```
3. Setup Constraints

```swift
/// Add constraints to SwiftyMenu
/// You must take care of `hegiht` constraint, please.
dropDownCode.translatesAutoresizingMaskIntoConstraints = false

let horizontalConstraint = NSLayoutConstraint(item: dropDownCode, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)

let topConstraint = NSLayoutConstraint(item: dropDownCode, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: otherView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 64)

let widthConstraint = NSLayoutConstraint(item: dropDownCode, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 255)

dropDownCode.heightConstraint = NSLayoutConstraint(item: dropDownCode, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 40)

NSLayoutConstraint.activate(
    [
        horizontalConstraint,
        topConstraint,
        widthConstraint,
        dropDownCode.heightConstraint
    ]
)
```

### Configure DataSource

To configure `SwiftyMenu` DataSource, you'll need to prepare your `Model` to be able to presented and retrived from the menu. Then, create and assign the DataSource to `SwiftyMenu`.

#### Setup Models

We are supporting Generic Data Source, all you have to do is conforming to our Generic Protocol on which type you want to add to the menu.

- Example of `String`

```swift
extension String: SwiftyMenuDisplayable {
    public var displayableValue: String {
        return self
    }
    
    public var retrivableValue: Any {
        return self
    }
}
```
- Example of custom `Struct`

```swift
struct MealSize {
    let id: Int
    let name: String
}

extension MealSize: SwiftyMenuDisplayable {
    public var displayableValue: String {
        return self.name
    }

    public var retrievableValue: Any {
        return self.id
    }
}
```

#### Assign DataSource

1. Create an `Array` of your models

```swift
/// Define menu data source
/// The data source type must conform to `SwiftyMenuDisplayable`
private let dropDownOptionsDataSource = [
    MealSize(id: 1, name: "Small"),
    MealSize(id: 2, name: "Medium"),
    MealSize(id: 3, name: "Large"),
    MealSize(id: 4, name: "Combo Large")
]
```
2. Assign it to `SwiftyMenu` DataSource property

```swift
dropDownCode.items = dropDownOptionsDataSource
```
### Capture Selection

`SwiftyMenu` supports 2 ways to capture the selected items, `Delegate` and `Closure`s. You can use one or both of them at the same time.

#### Using Delegate

1. Conform to `SwiftyMenu` Delegate protocol

```swift
extension ViewController: SwiftyMenuDelegate {
    // Get selected option from SwiftyMenu
    func swiftyMenu(_ swiftyMenu: SwiftyMenu, didSelectItem item: SwiftyMenuDisplayable, atIndex index: Int) {
        print("Selected item: \(item), at index: \(index)")
    }
    
    // NEW - Get selected option from SwiftyMenu
    func swiftyMenu(_ swiftyMenu: SwiftyMenu, didDeselectItem item: SwiftyMenuDisplayable, atIndex index: Int){
        print("deselected item: \(item), at index: \(index)")
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
2. Assign `SwiftyMenu` delegate

```swift
dropDownCode.delegate = self
```

#### Using Closures

You can use callbacks to know what happen:

```swift
/// SwiftyMenu also supports `CallBacks`
dropDownCode.didSelectItem = { menu, item, index in
    print("Selected \(item) at index: \(index)")
}

dropDownCode.willExpand = {
    print("SwiftyMenu Will Expand!")
}

dropDownCode.didExpand = {
    print("SwiftyMenu Expanded!")
}

dropDownCode.willCollapse = {
    print("SwiftyMenu Will Collapse!")
}

dropDownCode.didCollapse = {
    print("SwiftyMenu Collapsed!")
}
```

### UI Customization

Having an amazing drop down menu is essential. So, there're a lot of UI customization for `SwiftyMenu` (More to be added soon).

To configure UI customization for `SwiftyMenu`:

1. Create `SwiftyMenuAttributes` property

```swift
private var codeMenuAttributes = SwiftyMenuAttributes()
```
2. Assign it to `SwiftyMenu`

```swift
/// Configure SwiftyMenu with the attributes
dropDownCode.configure(with: codeMenuAttributes)
```
Also before assigning it to `SwiftyMenu` you could customize the menu look using following attributes.

#### Placeholder

```swift
attributes.placeHolderStyle = .value(text: "Please Select Size", textColor: .lightGray)
```

#### Text Style

```swift
attributes.textStyle = .value(color: .gray, separator: " & ", font: .systemFont(ofSize: 12))
```

#### Scroll

```swift
attributes.scroll = .disabled
```

#### Selection Behavior

```swift
//NEW - Single selection disallowing deselection clicking the same item
attributes.multiSelect = .disabled(allowSingleDeselection: false)
//NEW - Single selection allowing deselection clicking the same item
attributes.multiSelect = .disabled(allowSingleDeselection: true)
//Multi selection enable
attributes.multiSelect = .enabled
attributes.hideOptionsWhenSelect = .enabled
```

#### Row Style

```swift
attributes.rowStyle = .value(height: 40, backgroundColor: .white, selectedColor: .white)
```

#### Frame Style

```swift
/// Rounded Corners 
attributes.roundCorners = .all(radius: 8)

/// Menu Maximum Height
attributes.height = .value(height: 300)

/// Menu Border
attributes.border = .value(color: .gray, width: 0.5)
```

#### Arrow Style

```swift
/// `SwiftyMenu` have default arrow
attributes.arrowStyle = .value(isEnabled: true)
/// NEW - Now able to add a custom image, tint color and space between icon and text
attributes.arrowStyle = .value(isEnabled: true, image: image, tintColor: .purple, spacingBetweenText: 10.0)
```

#### Separator Style

```swift
attributes.separatorStyle = .value(color: .black, isBlured: false, style: .singleLine)
```

#### Header Style

```swift
attributes.headerStyle = .value(backgroundColor: .white, height: 40)
```

#### Accessory

```swift
attributes.accessory = .disabled
```

#### Animation

```swift
attributes.expandingAnimation = .linear
attributes.expandingTiming = .value(duration: 0.5, delay: 0)

attributes.collapsingAnimation = .linear
attributes.collapsingTiming = .value(duration: 0.5, delay: 0)
```

#### Margin Horizontal

```swift
/// Margin leading and trailing for title / placeholder
attributes.titleMarginHorizontal = .value(leading: 10, trailing: 20)
/// Margin leading and trailing for item list
attributes.itemMarginHorizontal = .value(leading: 10, trailing: 10)
```

#### Error Info

```swift
/// Default use the .red color
attributes.errorInfo = .default
/// Custom color for placeholder and icon if it's enabled
attributes.errorInfo = .custom(placeholderTextColor: .red, iconTintColor: .red)
```

#### Set Error

```swift
/// Enabling this will show the config in errorInfo
dropDown.setError(hasError: true)
```

### New Functionalities
* Custom arrow and color and space between arrow and title
* Fix multi select title: showing now sorted by index
* Margin leading and trailing for title and items
* Handling deselection for multi and single selection
* Seting Error with custom color for title and arrow

### Example Project

You could check the full `Example` project [Here](https://github.com/KarimEbrahemAbdelaziz/SwiftyMenu/tree/master/Example).

You could check the full new `Example` project [Here New Example](https://github.com/nowjordanhappy/SwiftyMenu/tree/feature/customization-ui/Example).

## TODO

- [x] Automate release new version to Cocoapods from Github Actions.
- [x] Add CHANGELOG file for the project.
- [x] Allow custom header and options cells.
- [ ] Allow different interactions to dismiss SwiftyMenu.
- [x] Allow to customize the default seperator.
- [x] Support Generic DataSource.
- [x] Support multi selection in SwiftMenu 🔥.
- [x] Support multi SwiftyMenu in one screen.
- [x] Support stack view and add example.
- [x] Support call backs and delegation.
- [x] Support different types of Animations. 
- [x] Add different customization to colors for default cells.
- [x] Margin horizontal for title and item
- [x] Custom arrow and tint color



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
