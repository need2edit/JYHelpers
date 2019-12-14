//
//  Resusable.swift
//  JYHelpers
//
//  Created by Jake Young on 7/8/19.
//  Copyright © 2019 Jake Young. All rights reserved.
//

import Foundation

public protocol Reusable { }
public protocol FromNib: Reusable { }

#if !os(macOS)
import UIKit
extension Reusable where Self: UIView {
    public static var identifier: String {
        return String(describing: self)
    }
}

extension FromNib where Self: UITableViewCell {
    public static var nib: UINib? {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: Self.self))
    }
    public static func register(in tableView: UITableView) {
        tableView.register(nib, forCellReuseIdentifier: identifier)
    }
}
#endif
