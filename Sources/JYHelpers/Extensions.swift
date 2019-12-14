//
//  Extensions.swift
//  AppStoreJSONApis
//
//  Created by Brian Voong on 2/14/19.
//  Copyright © 2019 Brian Voong. All rights reserved.
//

#if !os(macOS)
import UIKit

extension UIView {
    /// A convenience method for adding multiple views to a view using a variadric pattern.
    ///
    /// - Parameter views: one or more views you need to add to the sub view.
    public func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}

extension UIStackView {
    /// A convenience method for adding multiple views to a stck view using a variadric pattern.
    ///
    /// - Parameter views: one or more views to add to the stack view
    public func addArrangedSubviews(_ views: UIView...) {
        views.forEach({addArrangedSubview($0)})
    }
}

extension UILabel {
    /// Creates a label with text and a font and number of lines.
    ///
    /// - Parameters:
    ///   - text: The text for the label.
    ///   - font: The font for the label.
    ///   - numberOfLines: The number of lines.
    public convenience init(text: String, font: UIFont, numberOfLines: Int = 1) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.numberOfLines = numberOfLines
    }
}

extension UIImageView {
    /// Creates an image view with a given corner radius.
    ///
    /// Clips to bounds internally.
    ///
    /// - Parameters:
    ///   - image: the image you want to show
    ///   - cornerRadius: the roundness of the edges for the view
    ///   - contentMode: the method for rendering the image (scale to fit, aspect fill, etc.)
    public convenience init(image: UIImage? = nil, cornerRadius: CGFloat, contentMode: UIView.ContentMode = .scaleAspectFill) {
        self.init(image: image)
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.contentMode = contentMode
    }
}

extension UIButton {
    
    /// Intializer for creating a system button with a title.
    /// - Parameter title: The title for the button.
    public convenience init(title: String) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
    }
}
#endif
