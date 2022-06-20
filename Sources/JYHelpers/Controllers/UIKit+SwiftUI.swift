//
//  File.swift
//  
//
//  Created by Jake Young on 2/21/21.
//

#if !os(macOS)
import UIKit
import SwiftUI

open class CustomView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    func setUp() {
        fatalError("Override in subclass.")
    }
}

final class BadgeView: CustomView {

    let container = UIView()

    lazy var label: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 13.0)
        label.text = "1"
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()

    override func setUp() {

        container.backgroundColor = .red
        container.translatesAutoresizingMaskIntoConstraints = false

        addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),
            container.widthAnchor.constraint(greaterThanOrEqualTo: container.heightAnchor, multiplier: 1.0),
            container.heightAnchor.constraint(equalToConstant: 24.0)
        ])
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.bounds.height / 2
    }
}

extension BadgeView: UIViewRepresentable {

    func makeUIView(context: Context) -> some UIView {
        BadgeView()
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {

    }
}

struct BadgeView_Preview: PreviewProvider {
    static var previews: some View {
        Group {
            BadgeView()
                .previewLayout(.fixed(width: 24, height: 24))
                .padding()
                .previewDisplayName("Default Value 1")

        }
    }
}
#endif
