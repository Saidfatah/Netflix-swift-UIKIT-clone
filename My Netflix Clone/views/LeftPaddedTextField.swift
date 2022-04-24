//
//  LeftPaddedTextField.swift
//  My Netflix Clone
//
//  Created by said fatah on 24/4/2022.
//

import UIKit

class LeftPaddedTextField: UITextField {

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width, height: bounds.height)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width, height: bounds.height)
    }

}
