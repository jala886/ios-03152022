//
//  IdStatus.swift
//  DisplayAPI
//
//  Created by jianli on 3/25/22.
//

import Foundation


struct IdStatus:Codable{
    let id:Int
    var status:Bool?
    let img_src:String

    enum CodingKeys:String,CodingKey{
        case id
        case status
        case img_src
    }
}

struct photos:Decodable{
    let photos:[IdStatus]
}
