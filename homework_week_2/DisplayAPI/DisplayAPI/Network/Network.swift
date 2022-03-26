//
//  Network.swift
//  DisplayAPI
//
//  Created by jianli on 3/25/22.
//

import Foundation


func downloadAPI(completionHandler:@escaping (NetRespond<[IdStatus], ErrorType>)->Void){
    let urlStr = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?api_key=Q9YNbzmt8C5OpY7L3MV4DHJhrdIGCbjx3tVWxRcf&sol=2000&page=1"
    guard let url=URL(string:urlStr)
    else{completionHandler(NetRespond.failure(ErrorType.url));return}
    
    URLSession.shared.dataTask(with: url){data,res,error in
        if let error = error{
            completionHandler(.failure(.get(error)))
            return
        }
        if let data = data {
            do{
                //let posts = try JSONDecoder().decode([Post].self, from: data)
                let res = try JSONDecoder().decode(photos.self,from:data)
                completionHandler(NetRespond.sucess(res.photos))
            }catch(let error){
                completionHandler(.failure(.json(error)))
            }
        }
    }.resume()
}
