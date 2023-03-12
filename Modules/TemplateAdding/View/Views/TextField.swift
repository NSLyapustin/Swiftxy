//
//  TextField.swift
//  Swiftxy
//
//  Created by n.lyapustin on 05.03.2023.
//

import UIKit

class TextField: UITextField {
    let insetConstant = UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10)

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 4)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 4)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 4)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor(white: 2/3, alpha: 0.5).cgColor
        self.layer.borderWidth = 1
        self.clearButtonMode = .whileEditing
        self.keyboardType = UIKeyboardType.decimalPad
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
