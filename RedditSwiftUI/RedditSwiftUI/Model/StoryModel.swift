//
//  StoryModel.swift
//  RedditSwiftUI
//
//  Created by jianli on 4/22/22.
//

import Foundation

typealias StoryModel = RedditRespond.DataRespond.ChildRespond.StoryModel

struct RedditRespond:Decodable{
    let data:DataRespond
    
    struct DataRespond:Decodable{
        let children:[ChildRespond]
        let after:String?
        
        struct ChildRespond:Decodable{
            let data:StoryModel
            
            struct StoryModel:Decodable,Identifiable{
                let id:String?
                let title:String?
                let thumbnail:String?
                let url_overridden_by_dest:String?
            }
        }
    }
}
