//
//  TextView.swift
//  Swiftxy
//
//  Created by n.lyapustin on 26.03.2023.
//

import Foundation

class TextView: UITextView {

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        self.layer.borderColor = UIColor(white: 2/3, alpha: 0.5).cgColor
        self.layer.borderWidth = 1
        self.font = .systemFont(ofSize: 17)
    }
}
