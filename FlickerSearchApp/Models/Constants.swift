//
//  Constants.swift
//  FlickerSearchApp
//
//  Created by Admin on 03/03/2022.
//

import Foundation

struct Constants {

  struct FlickrURLParams {
    static let APIScheme = "https"
    static let APIHost = "api.flickr.com"
  static let APIPath = "/services/rest"
  }
    struct FlickrAPIKeys {
        static let SearchMethod = "method"
        static let APIKey = "api_key"
        static let Extras = "extras"
        static let ResponseFormat = "format"
        static let DisableJSONCallback = "nojsoncallback"
        static let SafeSearch = "safe_search"
        static let Text = "text"
    }
    
    struct FlickrAPIValues {
        static let SearchMethod = "flickr.photos.search"
        static let APIKey = "d255f7b0212e9fad472242ecec195cf6"
        static let ResponseFormat = "json"
        static let DisableJSONCallback = "1"
        static let MediumURL = "url_m"
        static let SafeSearch = "1"
    }

}

