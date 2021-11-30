

import Foundation
import SwiftUI

public struct DynamicFont: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory
    var semanticFont: SemanticFont

    public func body(content: Content) -> some View {
        if #available(iOS 14, *) {
            return content.font(.custom(semanticFont.baseFont.fontName,
                                        size: semanticFont.baseFont.pointSize,
                                        relativeTo: semanticFont.style.1))
        }
        let scaledSize = semanticFont.fontMetrics.scaledValue(for: semanticFont.baseFont.pointSize)
        return content.font(.custom(semanticFont.baseFont.fontName, size: scaledSize))
    }
}

public extension View {
    func dynamicFont(semanticFont: SemanticFont) -> some View {
        return self.modifier(DynamicFont(semanticFont: semanticFont))
    }

    func styledText(semanticFont: SemanticFont, kern: CGFloat = 0) -> some View {
        return self.modifier(DynamicFont(semanticFont: semanticFont))
            .foregroundColor(semanticFont.color.color)
            .lineSpacing(semanticFont.lineSpacing)
    }
}

//https://swiftui-lab.com/attributed-strings-with-swiftui/

public extension Text {
    init(attributedString: NSAttributedString) {
        self.init("")

        attributedString.enumerateAttributes(in: NSRange(location: 0, length: attributedString.length), options: []) { attrs, range, _ in

            var text = Text(attributedString.attributedSubstring(from: range).string)
            if let color = attrs[NSAttributedString.Key.foregroundColor] as? UIColor {
                text = text.foregroundColor(Color(color))
            }

            if let font = attrs[NSAttributedString.Key.font] as? UIFont {
                text = text.font(.init(font))
            }

            if let kern = attrs[NSAttributedString.Key.kern] as? CGFloat {
                text = text.kerning(kern)
            }

            if let striked = attrs[NSAttributedString.Key.strikethroughStyle] as? NSNumber, striked != 0 {
                if let strikeColor = (attrs[NSAttributedString.Key.strikethroughColor] as? UIColor) {
                    text = text.strikethrough(true, color: Color(strikeColor))
                } else {
                    text = text.strikethrough(true)
                }
            }

            if let baseline = attrs[NSAttributedString.Key.baselineOffset] as? NSNumber {
                text = text.baselineOffset(CGFloat(baseline.floatValue))
            }

            if let underline = attrs[NSAttributedString.Key.underlineStyle] as? NSNumber, underline != 0 {
                if let underlineColor = (attrs[NSAttributedString.Key.underlineColor] as? UIColor) {
                    text = text.underline(true, color: Color(underlineColor))
                } else {
                    text = text.underline(true)
                }
            }
            //swiftlint:disable:next shorthand_operator
            self = self + text
        }
    }
}
