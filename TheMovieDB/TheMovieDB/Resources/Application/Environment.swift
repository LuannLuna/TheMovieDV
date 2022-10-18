//
//  Environment.swift
//  TheMovieDB
//
//  Created by Luann Luna on 14/10/22.
//

import Foundation

var apiKey: String {
    get {
        guard let filePath = Bundle.main.path(forResource: "GlobalInfo", ofType: "plist") else {
            fatalError("Couldn't find file 'GlobaInfo.plist'.")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
            fatalError("Couldn't find key 'API_KEY' in 'GlobaInfo.plist'.")
        }
        return value
    }
}

var baseURL: String {
    get {
        guard let filePath = Bundle.main.path(forResource: "GlobalInfo", ofType: "plist") else {
            fatalError("Couldn't find file 'GlobaInfo.plist'.")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "BaseURL") as? String else {
            fatalError("Couldn't find key 'BaseURL' in 'GlobaInfo.plist'.")
        }
        return value
    }
}


var imgBaseUrl: String {
    get {
        guard let filePath = Bundle.main.path(forResource: "GlobalInfo", ofType: "plist") else {
            fatalError("Couldn't find file 'GlobaInfo.plist'.")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "ImgBaseURL") as? String else {
            fatalError("Couldn't find key 'ImgBaseURL' in 'GlobaInfo.plist'.")
        }
        return value
    }
}
