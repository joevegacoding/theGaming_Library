//
//  TGLEmptyStateView.swift
//  TheGaming_Library
//
//  Created by Joseph Bouhanef on 2022-09-13.
//

import UIKit

class TGLEmptyStateView: UIView {
    let messageLabel = TGLTitleLabel(textAlignment: .center, fontSize: 28)
    
    let logoImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureMessageLabel()
        configureLogoImageView()
        
    }
    
    init(message: String) {
        super.init(frame: .zero)
        messageLabel.text = message
    }
    
    func configureMessageLabel() {
        addSubview(messageLabel)
        
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -50),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo:  self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200)])
    }
    
    func configureLogoImageView() {
        addSubview(logoImageView)
        
        logoImageView.image = UIImage(named: "")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170),
            logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 140)
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        
    }
    
}
