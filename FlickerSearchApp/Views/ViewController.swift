//
//  ViewController.swift
//  FlickerSearchApp
//
//  Created by Admin on 03/03/2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var flickrImageView: UIImageView!
    @IBOutlet weak var searchTextField: UITextField!
    
   
    @IBAction func searchButtonAction(_ sender: Any) {
       
        let searchText = searchTextField.text
        if (searchText!.isEmpty)
        {
            displayAlert("Search text cannot be empty")
            return;
        }
        
        let searchURL = flickrURLFromParameters(searchString: searchText!)
        print("URL: \(searchURL)")
        
        performFlickrSearch(searchURL)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    private func performFlickrSearch(_ searchURL: URL) {
        
        let session = URLSession.shared
        let request = URLRequest(url: searchURL)
        let task = session.dataTask(with: request){
            (data, response, error) in
            if (error == nil)
            {
                let status = (response as! HTTPURLResponse).statusCode
                if (status < 200 || status > 300)
                {
                    self.displayAlert("Server returned an error")
                    return;
                }
                
                guard let data = data else {
                    self.displayAlert("No data was returned by the request!")
                    return
                }
                
                let parsedResult: FlickrResponse
                do {
                    parsedResult = try JSONDecoder().decode(FlickrResponse.self, from: data)
                } catch (let error) {
                    print(error)
                    self.displayAlert("Could not parse the data as JSON: '\(data)'")
                    return
                }
                print("Result: \(parsedResult)")
                
                let photosArray = parsedResult.photos.photo
                
                
                // Check number of ophotos
                if photosArray.count == 0 {
                    self.displayAlert("No Photos Found. Search Again.")
                    return
                } else {
                    // Get the first image
                    let photo = photosArray[0]
                    
                    // Fetch the image
                    self.fetchImage(photo.url_m);
                }
            
            }
            else{
                self.displayAlert((error?.localizedDescription)!)
            }
        }
        task.resume()
    }
    
    private func fetchImage(_ url: String?) {
        
        guard let url = url else { return }
        
        let imageURL = URL(string: url)
        
        let task = URLSession.shared.dataTask(with: imageURL!) { (data, response, error) in
            if error == nil {
                let downloadImage = UIImage(data: data!)!
                
                DispatchQueue.main.async(){
                    self.flickrImageView.image = downloadImage
                }
            }
        }
        
        task.resume()
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



