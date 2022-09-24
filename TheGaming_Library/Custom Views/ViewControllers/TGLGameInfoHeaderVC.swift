//
//  TGLGameInfoHeaderVC.swift
//  TheGaming_Library
//
//  Created by Joseph Bouhanef on 2022-09-17.
//

import UIKit

class TGLGameInfoHeaderVC: UIViewController {
    
    let gameImageView = TGLAvatarImageView(frame: .zero)
    let gameTitleLabel = TGLTitleLabel(textAlignment: .left, fontSize: 28)
    let secondaryInfoLabel = TGLSecondaryTitleLabel(fontSize: 18)
    let platformImageView = UIImageView()
    let platformLabel = TGLSecondaryTitleLabel(fontSize: 18)
    let descriptionLabel = TGLBodyLabel(textAlignment: .left)
    
    
    var game: Game!
    
    init(game: Game) {
        super.init(nibName: nil, bundle: nil)
        self.game = game
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        layoutUI()
        configureUIElements()

    }
    
    func configureUIElements() {
        gameImageView.downloadImage(from: game.backgroundImage)
        gameImageView.contentMode = .scaleAspectFill
        gameTitleLabel.text = game.name
        gameTitleLabel.numberOfLines = 2
        secondaryInfoLabel.text = "PC | PS5 | Xbox Series X"
       
        platformLabel.text = "platform"
        descriptionLabel.text = game.descriptionRaw ?? "No description available"
        descriptionLabel.numberOfLines = 0
        platformImageView.image = UIImage(named: SFSymbols.xbox)
        platformImageView.tintColor = .secondaryLabel
        
    }
    
    
    
    func addSubViews() {
        let headerViews = [gameImageView, gameTitleLabel, secondaryInfoLabel, platformImageView, platformLabel, descriptionLabel]
        for headerV in headerViews {
            view.addSubview(headerV)
        }
    }
    
    func layoutUI() {
        let padding: CGFloat = 20
        let textImagePadding: CGFloat = 12
        platformImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            gameImageView.topAnchor.constraint(equalTo: view.topAnchor),
            gameImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gameImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gameImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            //this means they will be alligned
            gameTitleLabel.topAnchor.constraint(equalTo: gameImageView.bottomAnchor, constant: textImagePadding),
            gameTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: textImagePadding),
            gameTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            gameTitleLabel.heightAnchor.constraint(equalToConstant: 100),
//
//            secondaryInfoLabel.centerYAnchor.constraint(equalTo: gameImageView.centerYAnchor, constant: 8),
//            secondaryInfoLabel.leadingAnchor.constraint(equalTo: gameImageView.trailingAnchor, constant: textImagePadding),
//            secondaryInfoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
//            secondaryInfoLabel.heightAnchor.constraint(equalToConstant: 20),
            secondaryInfoLabel.topAnchor.constraint(equalTo: gameTitleLabel.bottomAnchor),
            secondaryInfoLabel.leadingAnchor.constraint(equalTo: gameTitleLabel.leadingAnchor),
            secondaryInfoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 8),
            secondaryInfoLabel.heightAnchor.constraint(equalToConstant: 20),
//
            platformImageView.topAnchor.constraint(equalTo: gameTitleLabel.bottomAnchor),
            platformImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: textImagePadding),
            platformImageView.heightAnchor.constraint(equalToConstant: 25),
            platformImageView.widthAnchor.constraint(equalTo: platformImageView.heightAnchor),
//
//            platformLabel.centerYAnchor.constraint(equalTo: platformImageView.centerYAnchor),
//            platformLabel.leadingAnchor.constraint(equalTo: platformImageView.trailingAnchor, constant: 5),
//            platformLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
//            platformLabel.heightAnchor.constraint(equalToConstant: 20),
//
            descriptionLabel.topAnchor.constraint(equalTo: secondaryInfoLabel.bottomAnchor, constant: textImagePadding),
            descriptionLabel.leadingAnchor.constraint(equalTo: gameTitleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 250)
            
            
            
        ])
        
    }

}
