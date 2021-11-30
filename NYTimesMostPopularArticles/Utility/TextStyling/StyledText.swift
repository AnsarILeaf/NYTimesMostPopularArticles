import Combine
import UIKit

public protocol TextStyler {
    var attributedString: NSAttributedString { get }
    var isDynamic: Bool { get }
}

public struct StyledText: TextStyler, Equatable {
    public let text: String
    public let font: UIFont
    public let lineHeight: CGFloat
    public let color: UIColor
    public let isDynamic: Bool
    public let paragraphSpacing: CGFloat
    public let kern: CGFloat
    public let hasUnderline: Bool
    public let attributedStyles: [StyledText]

    public init(text: String, semanticFont: SemanticFont, hasUnderline: Bool = false) {
        self.init(text: text,
                  font: semanticFont.dynamicFont,
                  lineHeight: semanticFont.lineHeight,
                  color: semanticFont.color.uiColor,
                  hasUnderline: hasUnderline)
    }

    public init(text: String, semanticFont: SemanticFont, semanticColor: SemanticColor) {
        self.init(text: text,
                  font: semanticFont.dynamicFont,
                  lineHeight: semanticFont.lineHeight,
                  color: semanticColor.uiColor)
    }

    public init(text: String, semanticFont: SemanticFont, attributedStyles: [StyledText]) {
        self.init(text: text,
                  font: semanticFont.dynamicFont,
                  lineHeight: semanticFont.lineHeight,
                  color: semanticFont.color.uiColor,
                  attributedStyles: attributedStyles)
    }

    public init(text: String,
                font: UIFont,
                lineHeight: CGFloat,
                color: UIColor,
                paragraphSpacing: CGFloat = 0,
                kern: CGFloat = 0,
                isDynamic: Bool = true,
                hasUnderline: Bool = false,
                attributedStyles: [StyledText] = []) {
        self.text = text
        self.font = font
        self.lineHeight = lineHeight
        self.color = color
        self.paragraphSpacing = paragraphSpacing
        self.kern = kern
        self.isDynamic = isDynamic
        self.hasUnderline = hasUnderline
        self.attributedStyles = attributedStyles
    }

    public var lineSpacing: CGFloat {
        return lineHeight - font.pointSize - (font.lineHeight - font.pointSize)
    }

    private var attributes: [NSAttributedString.Key: Any] {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.paragraphSpacing = paragraphSpacing
        return [.font: font,
                .foregroundColor: color,
                .paragraphStyle: paragraphStyle,
                .kern: kern,
                .underlineStyle:
                    hasUnderline ? NSUnderlineStyle.single.rawValue: 0]
    }

    public var attributedString: NSAttributedString {
        let mutableAttributesString = NSMutableAttributedString(string: text)
        mutableAttributesString.addAttributes(attributes, range: NSRange(location: 0, length: text.count))
        attributedStyles.forEach { style in
            if let range = text.range(of: style.text) {
                mutableAttributesString.addAttributes(style.attributes, range: NSRange(range, in: text))
            }
        }
        return mutableAttributesString
    }
}

extension Array: TextStyler where Element: TextStyler {
    public var attributedString: NSAttributedString {
        reduce(into: NSMutableAttributedString()) { attributedString, styledText in
            attributedString.append(styledText.attributedString)
        }
    }

    public var isDynamic: Bool {
        return allSatisfy { $0.isDynamic }
    }
}

public protocol StyledTextSettable {
    func set(styledText: TextStyler)
}

extension UILabel: StyledTextSettable {
    public func set(styledText: TextStyler) {
        let alignment = textAlignment
        attributedText = styledText.attributedString
        textAlignment = alignment
        adjustsFontForContentSizeCategory = styledText.isDynamic
    }
}

extension UIButton: StyledTextSettable {
    public func set(styledText: TextStyler) {
        setAttributedTitle(styledText.attributedString, for: .normal)
    }
}

public extension Publisher where Output: TextStyler, Failure == Never {
    func set<Root: StyledTextSettable>(on object: Root) -> AnyCancellable {
        return sink {
            object.set(styledText: $0)
        }
    }
}

