//
//  GameInfoViewController.swift
//  TheGaming_Library
//
//  Created by Joseph Bouhanef on 2022-09-16.
//

import UIKit

class GameInfoViewController: UIViewController {
    
    let headerView = UIView()
    
    var gameTitle: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
        view.backgroundColor = UIColor(red: 19/255, green: 0/255, blue: 20/255, alpha: 1)
        NetworkManager.shared.getGameInfo(for: gameTitle) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let game):
//                print(game.description ?? "No description available")
                
                DispatchQueue.main.async {
                    self.add(childVC: TGLGameInfoHeaderVC(game: game), to: self.headerView)
                }
                
                
            case .failure(let error):
                self.presentTGLAlertOnMainThread(title: "Somethig went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func layoutUI() {
        view.addSubview(headerView)
       
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    func add(childVC: UIViewController, to containerView: UIView ) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }

}
