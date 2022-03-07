//
//  CollectionViewCell.swift
//  FlickerSearchApp
//
//  Created by Admin on 04/03/22.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
        func fetchImage(_ url: String?) {
    
            guard let url = url else { return }
    
            let imageURL = URL(string: url)
    
            let task = URLSession.shared.dataTask(with: imageURL!) { (data, response, error) in
                if error == nil {
                    let downloadImage = UIImage(data: data!)!
    
                    DispatchQueue.main.async(){
                        self.imageView.image = downloadImage
                    }
                }
            }
    
            task.resume()
        }
        
}
