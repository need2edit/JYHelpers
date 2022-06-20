//
//  Reusable.swift
//  AppStoreClone
//
//  Created by Phillip Farrugia on 6/17/17.
//  Copyright © 2017 Phill Farrugia. All rights reserved.
//

#if !os(macOS)
import UIKit

/// Provides default implementations of generic reuse methods on UICollectionView to
/// allow for consumers to register reuseable views for reuse such as UICollectionViewCells.
public extension UICollectionView {
    
    /// Registers a UICollectionViewCell subclass for reuse, by
    /// registering a UINib or Type for the object's reuseIdentifier.
    ///
    /// - Parameter _: UICollectionViewCell to register for reuse.
    func register<T: UICollectionViewCell>(_ cellClass: T.Type) {
        if let nibPreferred = cellClass as? DefaultNibLoadable.Type {
            register(nibPreferred.nib, forCellWithReuseIdentifier: cellClass.reuseIdentifier)
        } else {
            register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
        }
    }
    
    func register<T: UICollectionReusableView>(_ viewClass: T.Type, forSupplementaryViewOfKind kind: String) {
        if let nibPreferred = viewClass as? DefaultNibLoadable.Type {
            register(nibPreferred.nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: viewClass.reuseIdentifier)
        } else {
            register(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.reuseIdentifier)
        }
    }
    
    /// Dequeues a UICollectionViewCell for reuse given a specific indexPath.
    ///
    /// - Parameter indexPath: indexPath to dequeue cell for
    /// - Returns: a reused UICollectionViewCell associated with the indexPath
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath as IndexPath) as? T else {
            fatalError("could not dequeue cell of class \(T.self)")
        }
        return cell
    }
    
    func dequeueSupplementaryView<T: UICollectionReusableView>(kind: String, indexPath: IndexPath) -> T {
        guard let supplementaryView = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("could not dequeue cell of class \(T.self)")
        }
        return supplementaryView
    }
    
}
#endif
