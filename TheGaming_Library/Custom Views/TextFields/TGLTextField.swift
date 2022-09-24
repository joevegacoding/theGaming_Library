//
//  TGLTextField.swift
//  TheGaming_Library
//
//  Created by Joseph Bouhanef on 2022-09-08.
//

import UIKit

class TGLTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor
        
        textColor = .label
        tintColor = .label
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title2)
        // this will make the font shrink if it's too big to fit the textfield
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        
        backgroundColor = .tertiarySystemBackground
        // we don't want to autocorrect usernames
        autocorrectionType = .no
//        keyboardType = .numberPad
        returnKeyType = .go
        placeholder = "Enter a username"
    }
}

