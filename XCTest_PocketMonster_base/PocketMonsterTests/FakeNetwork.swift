//
//  FakeNetwork.swift
//  PocketMonsterTests
//
//  Created by jianli on 4/29/22.
//

import Foundation
@testable import PocketMonster

class FakeNetworkManager:NetworkManager {
    
    
    final override func getResponseType<ResponseType: Decodable>(_ type: ResponseType.Type) async throws -> ResponseType {
        var fileName:String = ""
        if type == FakeNetworkManager.self{
            fileName = "Pocket_veiw"
        }else if type == NetworkManager.self{
            fileName = "Pocket_view_details"
        }
        let data = try await getData(fileName:fileName)
        let result = try JSONDecoder().decode(ResponseType.self, from: data)
        return result
    }
    
    final func getData(fileName:String = "Pocket_view") async throws -> Data {
        //let url = Bundle.init(for: FakeNetworkManager).url(forResource: "Pocket_view", withExtension: ".json")
        let url = Bundle.main.url(forResource: fileName, withExtension: ".json")
        let data = try Data(contentsOf: url!)
        return data
    }
    
    private func createURL() throws -> URL {
        guard let url =  URL(string: self.url) else {
            throw NSError(domain: "can not create url", code: 500)
        }
        return url
    }
}
