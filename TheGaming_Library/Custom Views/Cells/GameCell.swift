//
//  GameCell.swift
//  TheGaming_Library
//
//  Created by Joseph Bouhanef on 2022-09-08.
//

import UIKit

class GameCell: UICollectionViewCell {
    
    static let reuseID = "GameCell"
    let avatarImageView = TGLAvatarImageView(frame: .zero)
    let usernameLabel   = TGLTitleLabel(textAlignment: .left, fontSize: 18)
    let platformsLabel = TGLSecondaryTitleLabel(fontSize: 12)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(game: Results) {
        usernameLabel.text = game.name
        print(game.platforms)
        var platformArray = [String]()
        for fol in game.platforms {
            
            platformArray.append(fol.platform.name)
        }
        
        platformsLabel.text = platformArray.joined(separator: ", ")
        
        avatarImageView.downloadImage(from: game.backgroundImage )
    }
    
    
    private func configure() {
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        //UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        layer.cornerRadius = 10
        avatarImageView.contentMode = .scaleAspectFill
        usernameLabel.numberOfLines = 0
        platformsLabel.numberOfLines = 0
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        addSubview(platformsLabel)
        
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 14),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            avatarImageView.widthAnchor.constraint(equalToConstant: 180),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor, multiplier: 0.56),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor, constant: padding),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 40),
            
            platformsLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: padding),
            platformsLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: padding),
            platformsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            platformsLabel.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
}
