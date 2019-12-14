//
//  BaseTableViewCell.swift
//  JYHelpers
//
//  Created by Jake Young on 5/1/19.
//  Copyright © 2019 Jake Young. All rights reserved.
//

#if !os(macOS)
import UIKit

/// A simple table view cell that offers `setupViews` when initializing that you can override.
///
/// You can manually intialize this view in code or use storyboards.
open class BaseTableViewCell: UITableViewCell {
    
    /// Configures the view. This is a good place to add new views or setup your constraints.
    ///
    /// If you do not subclass this method, there will be an `assertionFailure`
    open func setupViews() {
        assertionFailure("override in subclass")
    }
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
}
#endif
