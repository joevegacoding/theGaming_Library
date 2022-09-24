//
//  HomeViewController.swift
//  TheGaming_Library
//
//  Created by Joseph Bouhanef on 2022-09-13.
//

import UIKit

struct CustomImage {
   
    var image: String
}

class HomeViewController: UIViewController {
    
    var titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.sizeToFit()
        label.text = "Popular"
        return label
    }()
    
    let dataImages = [
        CustomImage(image: "cali-photo"),
        CustomImage(image: "cali-photo2"),
        CustomImage(image: "cali-photo3"),
    ]
    
    
    private let verticalStackView: UIStackView = {
         let verticalStackView = UIStackView()
//        verticalStackView.distribution = .
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 5
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
         return verticalStackView
     }()
    
    
    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints =  false
        cv.register(CustomCell.self, forCellWithReuseIdentifier: "cellId")
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
//        titleLabel.text = "Popular"
//        verticalStackView.addArrangedSubview(titleLabel)
//        verticalStackView.addArrangedSubview(collectionView)
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
//        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 0.7).isActive = true
        
        collectionView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: collectionView.topAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor, constant: 20).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: collectionView.topAnchor).isActive = true
        

        
        // this runs the delegate methods below and attaches them to this collection view
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.backgroundColor = .systemPink
     
    }
}



extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! CustomCell
        cell.backgroundColor = .systemBackground
       
        cell.data = self.dataImages[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 60, height: collectionView.frame.width / 2 )
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
       
        if kind == UICollectionView.elementKindSectionHeader {
                let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "cellID", for: indexPath)
//            sectionHeader.titleLabel.text = "Popular"
                return sectionHeader
           } else { //No footer in this case but can add option for that
                return UICollectionReusableView()
           }
    }
    
}


class CustomCell: UICollectionViewCell {
    
    var data: CustomImage? {
        didSet {
            guard let data = data else { return }
            gameImageView.image = UIImage(named: data.image)
        }
    }
    
    fileprivate let gameImageView: UIImageView = {
        let imageView =  UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
       
        imageView.image = UIImage(named: "cali-photo")
        return imageView
    }()
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(gameImageView)
        
        gameImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        gameImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        gameImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        gameImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
