import Foundation
import UIKit

public extension SwiftyMenuAttributes{
    enum ErrorInformation {
        case `default`
        case custom(placeholderTextColor: UIColor?, iconTintColor: UIColor?)
        
        public var errorInfoValues: (placeholderTextColor: UIColor?, iconTintColor: UIColor?) {
            switch self {
            case .default:
                return (placeholderTextColor: nil, iconTintColor: nil)
            case let .custom(placeholderTextColor, iconTintColor):
                return (placeholderTextColor: placeholderTextColor, iconTintColor: iconTintColor)
            }
        }
    }
}
