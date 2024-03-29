//
//  Reusable.swift
//  AppStoreClone
//
//  Created by Phillip Farrugia on 6/17/17.
//  Copyright © 2017 Phill Farrugia. All rights reserved.
//

#if !os(macOS)
import UIKit

/// Represents a UIView that is a reuseable view such as a
/// UITableViewCell, UITableViewHeaderFooterView or UICollectionViewCell.
/// Provides everything necessary for a reusable view to be reused.
public protocol Reusable: AnyObject {
    
    /// Identifier used to dequeue this view for reuse.
    static var reuseIdentifier: String { get }
    
    /// UINib containing the Interface Builder representation.
    static var nib: UINib? { get }
}

/// Provides default implementations of the necessary variables
/// to reuse a generic view.
public extension Reusable {
    
    /// Uses the object's Type name as the ReuseIdentifier.
    static var reuseIdentifier: String { String(describing: self) }
    
    /// Uses the UINib named after the object's type name.
    static var nib: UINib? { UINib(nibName: String(describing: self), bundle: nil) }
}

/// Declares that all UICollectionReusableViews conform to the
/// Reusable protocol and therefore gain the default
/// implementation without any additional effort.
extension UICollectionReusableView: Reusable { }
extension UITableViewCell: Reusable { }
extension UITableViewHeaderFooterView: Reusable { }
#endif
