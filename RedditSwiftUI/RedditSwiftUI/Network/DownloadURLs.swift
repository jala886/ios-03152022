//
//  DownloadURLs.swift
//  RedditSwiftUI
//
//  Created by jianli on 4/22/22.
//

import Foundation


enum DownloadURLs{
    case startUrl
    case nextURL(String)
    
    var string:String{
        switch self{
            case .startUrl:
            return "https://www.reddit.com/.json"
        case .nextURL(let key):
            return DownloadURLs.startUrl.string + "?after=\(key)"
        }
    
    }
}
