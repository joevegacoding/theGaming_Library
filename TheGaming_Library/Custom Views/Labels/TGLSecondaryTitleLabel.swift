//
//  TGLSecondaryTitleLabel.swift
//  TheGaming_Library
//
//  Created by Joseph Bouhanef on 2022-09-17.
//

import UIKit

class TGLSecondaryTitleLabel: UILabel {
  
    override init(frame: CGRect) {
        super.init(frame: frame)
         configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(fontSize: CGFloat) {
        super.init(frame: .zero)
        font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        configure()
    }
    
    private func configure() {
        textColor = .systemPurple
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints =  false
        
        
    }
    
}
