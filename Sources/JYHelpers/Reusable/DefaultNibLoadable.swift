//
//  DefaultNibLoadable.swift
//  
//
//  Created by Jake Young on 4/25/20.
//

#if !os(macOS)
import UIKit

public protocol DefaultNibLoadable {
    static var nib: UINib { get }
}

public extension DefaultNibLoadable where Self: UIView {
    static var nibName: String { String(describing: self.self) }
    static var nib: UINib { UINib(nibName: nibName, bundle: Bundle(for: Self.self)) }
}
#endif
