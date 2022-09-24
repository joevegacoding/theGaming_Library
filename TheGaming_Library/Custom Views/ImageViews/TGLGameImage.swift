//
//  TGLGameImage.swift
//  TheGaming_Library
//
//  Created by Joseph Bouhanef on 2022-09-08.
//

import UIKit

class TGLAvatarImageView: UIImageView {
    
    let cache = NetworkManager.shared.cache
    
    //TODO: add a cusom default image for games that don't have an image and a force unwrap since we will already have a default value for sure.
    let placeholderImage = UIImage(named: "")

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    private func configure() {
        layer.cornerRadius = 10
    
        //this fills the the image to the view to make the image look with a corner radius
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func downloadImage(from url: String) {
        
        let cacheKey = NSString(string: url)
        
        if let image = cache.object(forKey: cacheKey ) {
            self.image = image
            return
        }
        guard let url = URL(string: url) else { return }
                
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            if error != nil { return }
            guard let self = self else { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }

            guard let image = UIImage(data: data) else { return }
            
            self.cache.setObject(image, forKey: cacheKey)
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
        task.resume()
        
    }
    
    
}

