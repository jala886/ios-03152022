//
//  ImageSequency.swift
//  RedditSwiftUI
//
//  Created by jianli on 4/25/22.
//

import Foundation


struct ImageSequence: AsyncSequence, AsyncIteratorProtocol{
    
    var idurls:[(String,String)]
    var index = 0
    
    
    typealias Element = (String,Data)
    
    func makeAsyncIterator() -> ImageSequence {
        ImageSequence(idurls:idurls)
    }
    
    mutating func next()async throws->(String,Data)?{
        guard index < idurls.count else{
            return nil
        }
        let id = idurls[index].0
        let url = idurls[index].1
        if let url = URL(string:url){
            index += 1
            let (data,_) = try await URLSession.shared.data(from:url)
            return (id,data)
        }else{
            return try await next()
        }
    }
    
    
}
