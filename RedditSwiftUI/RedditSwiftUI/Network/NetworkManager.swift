//
//  NetworkManager.swift
//  RedditSwiftUI
//
//  Created by jianli on 4/22/22.
//

import Foundation

class NetworkManager{
    func downloadStoryModel<RespondType:Decodable>(_ respondType:RespondType.Type,url:String) async throws->RespondType{
        guard let url = URL(string:url)
        else{throw NSError(domain: "Bad URL: "+url, code: 0)}
        let (data,_) = try await URLSession.shared.data(from: url)
        let res = try JSONDecoder().decode(RespondType.self, from: data)
        return res
    }
}
