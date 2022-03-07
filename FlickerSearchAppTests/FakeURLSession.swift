//
//  FakeURLSession.swift
//  FlickerSearchAppTests
//
//  Created by Admin on 04/0322.
//

import Foundation

class FakeURLSession: URLSession {
    
    var data: Data?
    
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        completionHandler(data, nil, nil)
        return URLSessionTask() as! URLSessionDataTask
    }
    
}
