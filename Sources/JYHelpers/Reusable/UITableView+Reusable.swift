//
//  UITableView+Reusable.swift
//  
//
//  Created by Jake Young on 5/9/20.
//

#if !os(macOS)
import UIKit

/// Provides default implementations of generic reuse methods on UICollectionView to
/// allow for consumers to register reuseable views for reuse such as UICollectionViewCells.
public extension UITableView {

    /// Registers a UICollectionViewCell subclass for reuse, by
    /// registering a UINib or Type for the object's reuseIdentifier.
    ///
    /// - Parameter _: UICollectionViewCell to register for reuse.
    func register<T: UITableViewCell>(_ cellClass: T.Type) {
        if let nibPreferred = cellClass as? DefaultNibLoadable.Type {
            register(nibPreferred.nib, forCellReuseIdentifier: cellClass.reuseIdentifier)
        } else {
            register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
        }
    }

    func register<T: UITableViewHeaderFooterView>(_ viewClass: T.Type) {
        if let nibPreferred = viewClass as? DefaultNibLoadable.Type {

            register(nibPreferred.nib, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
        } else {
            register(viewClass, forHeaderFooterViewReuseIdentifier: viewClass.reuseIdentifier)
        }
    }

    /// Dequeues a UICollectionViewCell for reuse given a specific indexPath.
    ///
    /// - Parameter indexPath: indexPath to dequeue cell for
    /// - Returns: a reused UICollectionViewCell associated with the indexPath
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath as IndexPath) as? T else {
            fatalError("could not dequeue cell of class \(T.self)")
        }
        return cell
    }

    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T {
        guard let headerFooter = dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T else {
            fatalError("could not dequeue cell of class \(T.self)")
        }
        return headerFooter
    }

}
#endif
