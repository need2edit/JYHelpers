//
//  ActivityView.swift
//  CoreDataTest
//
//  Created by Jake Young on 7/3/19.
//  Copyright © 2019 Nous Foundation. All rights reserved.
//

#if !os(macOS)
import UIKit

open class ActivityView: UIView {
    
    public enum State {
        case loading(String?)
        case loaded
    }
    public var state: State = .loaded {
        didSet {
            switch state {
            case .loaded:
                activityIndicator.stopAnimating()
                statusLabel.text = nil
                statusLabel.isHidden = true
            case .loading(let message):
                activityIndicator.startAnimating()
                statusLabel.isHidden = (message == nil)
                statusLabel.text = message
                statusLabel.sizeToFit()
            }
        }
    }
    private let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    private let statusLabel = UILabel(text: "Loading...", font: .systemFont(ofSize: 12.0))
    
    fileprivate func setupView() {
        activityIndicator.color = .gray
        activityIndicator.hidesWhenStopped = true
        statusLabel.setContentCompressionResistancePriority(.init(1000), for: .horizontal)
        let stack = UIStackView(arrangedSubviews: [activityIndicator, statusLabel])
        stack.axis = .vertical
        stack.spacing = 12.0
        addSubview(stack)
        stack.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
#endif
