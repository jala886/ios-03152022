//
//  NetError.swift
//  DisplayAPI
//
//  Created by jianli on 3/25/22.
//

import Foundation

enum ErrorType:Error{
    case url
    case get(Error)
    case json(Error)
    case other(Error)
}

enum NetRespond<Success,Error>{
    case sucess(Success)
    case failure(Error)
    
}
