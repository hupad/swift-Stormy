//
//  NetworkOperation.swift
//  Stormy
//
//  Created by Harish Upadhyayula on 1/6/16.
//  Copyright © 2016 Harish Upadhyayula. All rights reserved.
//

import Foundation

class NetworkOperation {
    lazy var config: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
    lazy var session: NSURLSession = NSURLSession(configuration: self.config)
    typealias jsonDictionaryCompletion = ([String: AnyObject]? -> ())
    
    let queryURL: NSURL
    
    init(url: NSURL){
        self.queryURL = url
    }
    
    func downloadJsonFromUrl(completion: jsonDictionaryCompletion){
        
        let request = NSURLRequest(URL: queryURL)
        
        let dataTask = session.dataTaskWithRequest(request){
            (let data, let response, let error) in
            
            if let httpResponse = response as? NSHTTPURLResponse {
                switch (httpResponse.statusCode) {
                case 200:
                    do{
                        let jsonDataDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String: AnyObject]
                        completion(jsonDataDictionary)
                    }catch{
                        print("Error, downloading tasks")
                    }
                default:
                    print("Error \(error)")
                }
            }
        }
        dataTask.resume()
    }
}