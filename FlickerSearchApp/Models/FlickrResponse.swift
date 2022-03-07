//
//  FlickrResponse.swift
//  FlickerSearchApp
//
//  Created by Admin on 03/03/2022.
//

import Foundation

struct FlickrResponse: Decodable {
    let photos: FlickrPhotos
}

struct FlickrPhotos: Decodable {
    let page: Int
    let pages: Int
    let perpage: Int
    let total: Int
    let photo: [Photo]
}

struct Photo: Decodable {
    let id: String
    let url_m: String?
    let title: String
}
