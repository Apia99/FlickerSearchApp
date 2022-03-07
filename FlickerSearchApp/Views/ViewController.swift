//
//  ViewController.swift
//  FlickerSearchApp
//
//  Created by Admin on 03/03/2022.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let viewModel = ViewModel()
    var subscribers = Set<AnyCancellable>()
    
    var performFlickrSearch = [ViewModel].self
    
    var session: URLSession = URLSession.shared
    
    func setURLSession(_ session: URLSession) {
        self.session = session
    }
    
    @IBAction func searchButtonAction(_ sender: Any) {
        
        let searchText = searchTextField.text!
        searchOnFlickr(searchText)
    }
    
    func searchOnFlickr(_ searchText: String) {
        if (searchText.isEmpty)
        {
            displayAlert("Search text cannot be empty")
            return;
        }
        
        let searchURL = flickrURLFromParameters(searchString: searchText)
        print("URL: \(searchURL)")
        
        viewModel.performFlickrSearch(searchURL)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpBinding()
        collectionView.dataSource = self
    }
    
    private func setUpBinding() {
        viewModel
            .$displayAlert
            .dropFirst()
            .sink { message in
                self.displayAlert(message)
            }
            .store(in: &subscribers)
        
        viewModel
            .$photosArray
            .dropFirst()
            .receive(on: RunLoop.main)
            .sink { array in
                self.collectionView.reloadData()
            }
            .store(in: &subscribers)
    }
    
    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    }
    
    private func flickrURLFromParameters(searchString: String) -> URL {
        
        // Build base URL
        var components = URLComponents()
        components.scheme = Constants.FlickrURLParams.APIScheme
        components.host = Constants.FlickrURLParams.APIHost
        components.path = Constants.FlickrURLParams.APIPath
        
        // Build query string
        components.queryItems = [URLQueryItem]()
        
        // Query components
        components.queryItems!.append(URLQueryItem(name: Constants.FlickrAPIKeys.APIKey, value: Constants.FlickrAPIValues.APIKey));
        components.queryItems!.append(URLQueryItem(name: Constants.FlickrAPIKeys.SearchMethod, value: Constants.FlickrAPIValues.SearchMethod));
        components.queryItems!.append(URLQueryItem(name: Constants.FlickrAPIKeys.ResponseFormat, value: Constants.FlickrAPIValues.ResponseFormat));
        components.queryItems!.append(URLQueryItem(name: Constants.FlickrAPIKeys.Extras, value: Constants.FlickrAPIValues.MediumURL));
        components.queryItems!.append(URLQueryItem(name: Constants.FlickrAPIKeys.SafeSearch, value: Constants.FlickrAPIValues.SafeSearch));
        components.queryItems!.append(URLQueryItem(name: Constants.FlickrAPIKeys.DisableJSONCallback, value: Constants.FlickrAPIValues.DisableJSONCallback));
        components.queryItems!.append(URLQueryItem(name: Constants.FlickrAPIKeys.Text, value: searchString));
        
        return components.url!
    }
    
    func displayAlert(_ message: String)
    {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Click", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photosArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        let photo = viewModel.photosArray[indexPath.row]
        cell.fetchImage(photo.url_m)
        return cell
    }
    
}

