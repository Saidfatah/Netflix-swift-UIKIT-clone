//
//  PrimaryUIButton.swift
//  My Netflix Clone
//
//  Created by said fatah on 30/4/2022.
//

import UIKit

class PrimaryUIButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame :CGRect) {
        super.init(frame: frame)
        layer.borderColor = UIColor.systemBackground.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 5
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
