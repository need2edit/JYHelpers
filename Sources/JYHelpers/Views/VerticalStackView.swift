//
//  VerticalStackView.swift
//  AppStoreJSONApis
//
//  Created by Brian Voong on 2/11/19.
//  Copyright © 2019 Brian Voong. All rights reserved.
//

#if !os(macOS)
import UIKit

/// A more convienent way to create vertical a UIStackView.
///
/// This sets the axis as `vertical` and uses the default arrangeSubviews with spacing.
public class VerticalStackView: UIStackView {

    /// Creates a vertical stack view with spacing.
    ///
    /// - Parameters:
    ///   - arrangedSubviews: the views you need to incldue in this stack view
    ///   - spacing: the spacing for the stack view
    public init(arrangedSubviews: [UIView], spacing: CGFloat = 0) {
        super.init(frame: .zero)
        
        arrangedSubviews.forEach({addArrangedSubview($0)})
        
        self.spacing = spacing
        self.axis = .vertical
    }
    
    public required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
#endif
