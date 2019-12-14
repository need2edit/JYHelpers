//
//  MessageView.swift
//  CoreDataTest
//
//  Created by Jake Young on 7/8/19.
//  Copyright © 2019 Nous Foundation. All rights reserved.
//

#if !os(macOS)
import UIKit

open class MessageView: UIView {
    
    public func updateMessage(_ title: String?, subtitle: String?, callToActionLabel: String?) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        callToActionButton.setTitle(callToActionLabel, for: .normal)
        callToActionButton.isHidden = callToActionLabel == nil
        sizeToFit()
    }
    
    public func setCallToAction(handler: @escaping () -> Void) {
        callToActionHandler = handler
    }
    
    private var callToActionHandler: (() -> Void)! {
        didSet {
            callToActionButton.addTarget(self, action: #selector(callToActionButtonTapped), for: .touchUpInside)
        }
    }
    
    public let titleLabel = UILabel(text: "Title", font: .boldSystemFont(ofSize: 24))
    public let subtitleLabel = UILabel(text: "Subtitle", font: .systemFont(ofSize: 12.0))
    
    public let callToActionButton = UIButton(title: "Try Again")
    
    @objc func callToActionButtonTapped(_ sender: UIButton) {
        callToActionHandler()
    }
    
    fileprivate func setupView() {
        
        titleLabel.setContentCompressionResistancePriority(.init(1000), for: .horizontal)
        titleLabel.textAlignment = .center
        subtitleLabel.textAlignment = .center
        
        subtitleLabel.setContentCompressionResistancePriority(.init(1000), for: .horizontal)
        let stack = UIStackView(arrangedSubviews: [
            titleLabel,
            subtitleLabel,
            callToActionButton])
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
