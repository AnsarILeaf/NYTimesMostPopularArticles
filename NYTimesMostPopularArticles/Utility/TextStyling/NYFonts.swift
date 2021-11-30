
import Foundation
import SwiftUI
import UIKit

public enum NYFont: String {
    case helveticaBold = "Helvetica Neue Bold"
    case helveticaRegular = "Helvetica Neue"
    case helveticaMedium = "Helvetica Neue Medium"
}

public extension UIFont {
    convenience init(type: NYFont, size: CGFloat) {
        self.init(name: type.rawValue, size: size)!
    }
}

public enum SemanticFont: Equatable {
    case header1
    case subHeading
    case title
    case description
    case currencySymbol
    case error
    case address

    public var baseFont: UIFont {
        switch self {
        
        case .header1:
            return UIFont(type: .helveticaBold, size: 28)
            case .subHeading:
                return UIFont(type: .helveticaRegular, size: 17)
            case .currencySymbol:
                return UIFont(type: .helveticaBold, size: 25)
            case .title :
                return UIFont(type: .helveticaRegular, size: 15)
            case .error :
                return UIFont(type: .helveticaRegular, size: 13)
            case .description :
                return UIFont(type: .helveticaRegular, size: 13)
            case .address :
                return UIFont(type: .helveticaBold, size: 15)
        }
    }

    public var style: (UIFont.TextStyle, Font.TextStyle) {
        switch self {
            case .header1,.subHeading,.currencySymbol,.error,.title,.description,.address:
            return (.body, .body)
//        case .header4,
//             .subtitle2,
//             .subtitle3,
//             .header5:
//            return (.title1, .title)
//        case .body2,
//             .textField,
//             .buttonLabel,
//             .selectableControl,
//             .bold2,
//             .bold1,
//             .body1 :
//            return (.body, .body)
//        case .link2 :
//            return (.callout, .callout)
        }
    }

    public var fontMetrics: UIFontMetrics {
        return UIFontMetrics(forTextStyle: style.0)
    }

    public var dynamicFont: UIFont {
        return fontMetrics.scaledFont(for: baseFont)
    }

    public var lineHeight: CGFloat {
        switch self {
            case .header1:
            return 28
            case .description:
                return 0
       
        default:
            return 24
        }
    }
    
    public var lineSpacing: CGFloat {
        lineHeight - dynamicFont.pointSize - (dynamicFont.lineHeight - dynamicFont.pointSize)
    }

    public var color: SemanticColor {
        switch self {
        case .header1:
            return .header1Text
            case .subHeading:
                return .subHeadingText
            case .currencySymbol:
                return .subHeadingText
            case .error:
                return .error
            case .title :
                return .subHeadingText
            case .description :
                return .descriptionGrey
            case .address:
                return .subHeadingText
        }
    }
}
