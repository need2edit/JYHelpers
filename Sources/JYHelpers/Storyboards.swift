//
//  Storyboards.swift
//  JYHelpers
//
//  Created by Jake Young on 7/8/19.
//  Copyright © 2019 Jake Young. All rights reserved.
//

#if os(macOS)
import AppKit
#else
import UIKit
#endif

#if os(macOS)
extension NSStoryboard {
    static let main = NSStoryboard.init(name: NSStoryboard.Name("Main"), bundle: .main)
}
#else
extension UIStoryboard {
    public static let main = UIStoryboard(name: "Main", bundle: .main)
}
#endif

public protocol StoryboardInitializable { }

#if !os(macOS)
extension StoryboardInitializable where Self: UIViewController {
    
    
    public static var storyboardIdentifier: String {
        return String(describing: Self.self)
    }
    
    public static func fromStoryboard(_ storyboard: UIStoryboard = .main, _ configure: (Self) -> Void = { _ in }) -> Self {
        
        #if os(macOS)
        guard let vc = storyboard.instantiateController(withIdentifier: storyboardIdentifier) as? Self
            else { throw AppError.generic("could not find a view controller with the id \(storyboardIdentifier)")}
        #else
        guard let vc = storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as? Self
            else { fatalError("could not find a view controller with the id \(storyboardIdentifier)")}
        #endif
        
        configure(vc)
        
        return vc
    }
}
#endif
