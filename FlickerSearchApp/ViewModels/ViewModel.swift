//
//  NetworkManager.swift
//  FlickerSearchApp
//
//  Created by Admin on 04/03/2022.
//

import Foundation

// publishers and subscribers - Combine

class ViewModel {
    
    let networkManager = NetworkManager()
    @Published var displayAlert = ""
    
    @Published var photosArray = [Photo]()
    
    func performFlickrSearch(_ searchURL: URL) {
        
        networkManager.getPhotos(from: searchURL) { result in
            switch result {
            case .success(let photos):
                self.photosArray = photos
            case .failure(let error):
                self.displayAlert = error.localizedDescription
            }
        }
        
    }
}
