import SwiftUI
import UIKit

private class SemanticColorBundle {
}

public enum SemanticColor {
    case header1Text
    case subHeadingText
    case error
    case descriptionGrey

    public var uiColor: UIColor {
        _ = Bundle(for: SemanticColorBundle.self)
        switch self {
     
            case .header1Text, .error:
                return UIColor.red
            case .subHeadingText:
                return .black
            case .descriptionGrey:
                return .gray
                

        }
    }

    public var color: Color {
        return Color(self.uiColor)
    }
}

public extension UIColor {
    static func semantic(_ semantic: SemanticColor) -> UIColor {
        return semantic.uiColor
    }
}

public extension Color {
    static func semantic(_ semantic: SemanticColor) -> Color {
        return semantic.color
    }
}
