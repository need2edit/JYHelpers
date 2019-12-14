//
//  TextField.swift
//  JYHelpers
//
//  Created by Jake Young on 6/25/19.
//  Copyright © 2019 Jake Young. All rights reserved.
//

#if !os(macOS)
import UIKit

/// https://stackoverflow.com/questions/25367502/create-space-at-the-beginning-of-a-uitextfield
open class TextField: UITextField {
    
    public let padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
#endif
