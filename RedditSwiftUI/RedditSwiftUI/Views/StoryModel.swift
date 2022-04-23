//
//  StoryModel.swift
//  RedditSwiftUI
//
//  Created by jianli on 4/22/22.
//

import Foundation

typealias StoryModel = StoryRespond.DataRespond.ChildRespond.StoryModel

struct StoryRespond:Decodable{
    let data:[DataRespond]
    
    struct DataRespond:Decodable{
        let children:[ChildRespond]
        struct ChildRespond:Decodable{
            let data:[StoryModel]
            struct StoryModel:Decodable,Identifiable{
                let id:String?
                let title:String?
                let thumbnial:String?
                let url_overridden_by_dest:String?
            }
        }
    }
}
