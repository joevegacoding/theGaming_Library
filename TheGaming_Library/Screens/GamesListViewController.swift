//
//  GamesListViewController.swift
//  TheGaming_Library
//
//  Created by Joseph Bouhanef on 2022-09-08.
//


import UIKit

class GamesListViewController: UIViewController {
    
    enum Section { case main }
    
    var username: String!
    var games: [Results] = []
    var filteredGames: [Results] = []
    var page = 2
    var hasMoreGames: Bool = true
    var isSearching: Bool = false
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Results>!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getGames(game: username, page: page)
        configureDataSource()
        configureSearchController()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    func configureViewController() {
        view.backgroundColor = .red
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor(red: 20/255, green: 0/255, blue: 20/255, alpha: 1)
        collectionView.heightAnchor.constraint(equalToConstant: 500).isActive = true
        collectionView.register(GameCell.self, forCellWithReuseIdentifier: GameCell.reuseID)
    }
    
    
    func configureSearchController() {
        let searchController  = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search game"
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        
    }
    
    
    func getGames(game: String, page: Int) {
        showLoadingView()
        NetworkManager.shared.getGames(for: username, page: page) { [weak self] result in
           
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case .success(let games):
                if games.results.count < 20 { self.hasMoreGames = false }
                self.games.append(contentsOf: games.results)
                
//                if self.games.isEmpty {
//                    let message = "No game found...☹️👾"
//                    DispatchQueue.main.async {
//                        self.showEmptyStateView(with: message, in: self.view)
//                        return
//                    }
//                    
//                }
                self.updateData(on: self.games)
                
            case .failure(let error):
                self.presentTGLAlertOnMainThread(title: "Bad Stuff Happend", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Results>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, game) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCell.reuseID, for: indexPath) as! GameCell

            cell.set(game: game)
            return cell
        })
    }
    
    
    func updateData(on games: [Results]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Results>()
        snapshot.appendSections([.main])
        snapshot.appendItems(games)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
     
    }
}


extension GamesListViewController: UICollectionViewDelegate {
    
    // this method waits for us to end the scroll to perform an aciton
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard hasMoreGames else { return }
        let offsetY  = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            page += 1
            getGames(game: username, page: page)

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // we need to get the game at the index path to know which game we're actually tapping on
        let activaArray = isSearching ? filteredGames : games
        let game = activaArray[indexPath.item]
        
        let gameInfoVC = GameInfoViewController()
        gameInfoVC.gameTitle = game.id
        
        navigationController?.pushViewController(gameInfoVC, animated: true)
        
//        present(gameInfoVC, animated: true)
    }
    
}

extension GamesListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        isSearching = true
        filteredGames = games.filter({ $0.name.lowercased().contains(filter.lowercased())})
        updateData(on: filteredGames)
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // when we hit the cancel button, it automatically brings the normal games array
        isSearching = false
        updateData(on: games)
    }
    
}
