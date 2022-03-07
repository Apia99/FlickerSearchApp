//
//  NetworkManager.swift
//  FlickerSearchApp
//
//  Created by Christian Quicano on 3/7/22.
//

import Foundation

class NetworkManager {
    
    func getPhotos(from url: URL, completion: @escaping (Result<[Photo], NetworkError>) -> Void) {
        let session = URLSession.shared
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { (data, response, error) in
            if (error == nil)
            {
                let status = (response as! HTTPURLResponse).statusCode
                if (status < 200 || status > 300)
                {
                    completion(.failure(.serverError))
                    return;
                }
                
                guard let data = data else {
                    completion(.failure(.dataError))
                    return
                }
                
                let parsedResult: FlickrResponse
                do {
                    parsedResult = try JSONDecoder().decode(FlickrResponse.self, from: data)
                } catch (let error) {
                    print(error)
                    completion(.failure(.other(error)))
                    return
                }
                print("Result: \(parsedResult)")
                
                let photosArray = parsedResult.photos.photo
                completion(.success(photosArray))
            }
            else{
                completion(.failure(.other(error!)))
            }
        }
        task.resume()
    }
    
}
