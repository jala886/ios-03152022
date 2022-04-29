//
//  PocketMonsterTests.swift
//  PocketMonsterTests
//
//  Created by jianli on 4/26/22.
//
import XCTest
@testable import PocketMonster

class PocketMonsterTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testURL() throws {
        
        let network = NetworkManager()
        network.url = "^:ht:badurl"
        //var res:PokemonResponse
        let expectation = expectation(description: "url")
        Task{
            do{
               let res = try await network.getResponseType(PokemonResponse.self)
                print("count count",res.results.count)
                XCTAssertNotNil(res)
                //XCTAssert(res != nil)
                XCTAssert(res.results.count == 100)
                
            }catch(let e){
                print(e.localizedDescription)
                XCTAssertNotNil(e)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 30)
        
    }
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        let network = NetworkManager()
        network.url = NetworkURL.pokemonsNamesURL
        let exp = expectation(description: "test")
        //var res:PokemonResponse
        Task{
            do{
               let res = try await network.getResponseType(PokemonResponse.self)
                print("count count",res.results.count)
                XCTAssertNotNil(res)
                //XCTAssert(res != nil)
                XCTAssert(res.results.count == 100)
                exp.fulfill()
            }catch(let e){
                print(e.localizedDescription)
                fatalError("meet some problems")
            }
        }
        waitForExpectations(timeout: 10)
        
    }
    func testGetData() async throws{
        let network = NetworkManager()
        network.url = NetworkURL.pokemonsNamesURL
        network.url = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"
        
        var tmp = [Data]()
        
        let data = try await Task{() -> Data in
            let data = try await network.getData()
            XCTAssert(data != nil)
//            DispatchQueue.main.async {
            //tmp.append(data)
//            }
            return data
        }.value
    }
    func testListViewModel() async throws{
        let vm = PokemonListViewModel()
            try await vm.loadPokemons()
            print(vm.pokemons.count)
            XCTAssert(vm.pokemons != nil)
            let imgData = vm.pokemons.map{$0.imgData}
            let testRes = imgData.reduce(into: true){
                $0 = $0 && $1==nil
            }
            print("testview",testRes)
            //XCTAssert(testRes)
            XCTAssertNotNil(vm.pokemons.first?.imgData)
    }
//    func testListViewModel2() throws{
//        let vm = PokemonListViewModel()
//        Task{
//            try await vm.loadPokemons()
//            XCTAssertEqual(vm.pokemons.count, 100)
//            let imgData = vm.pokemons.map{$0.imgData}
//            let testRes = imgData.reduce(into: true){
//                $0 = $0 && $1==nil
//            }
//            print("testview",testRes)
//            XCTAssert(testRes)
//
//        }
//    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testDetailView() throws {
        let vm = PokemonListViewModel()
        
        let exp = expectation(description: "details")
        Task{
            try await vm.loadPokemons()
            print(vm.pokemons.count)
            let pokemon = vm.pokemons.first!
            exp.fulfill()
        }
        waitForExpectations(timeout: 30)
        let pokemon = vm.pokemons.first!
        let view = PokemonDetailsView(pokemon:pokemon)
        //let app = XCUIApplication()
        //app.launch()
        XCTAssertNotNil(view)
        XCTAssertNotNil(view.pokemon.imgData)
        
    }
    func testLoadAllImage() async throws{
        let vm = PokemonListViewModel()
            var imageUrls = [String:String]()
            imageUrls["diglett"] = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/50.png"
            imageUrls["bulbasaur"] = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"
            //let data = try await vm.downloadAllImages(from:imageUrls)
    }
    func testImageLoader() async throws{
            var result: [String: Data] = [:]
            var imageUrls = [String:String]()
            imageUrls["diglett"] = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/50.png"
            imageUrls["bulbasaur"] = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"
            let imagesLoader = ImagesLoader(urls: imageUrls, networkManager:NetworkManager())
            for try await response in imagesLoader {
                guard let key = response.keys.first, let value = response.values.first
                else { continue }
                result[key] = value
            XCTAssert(result.count != 0)
        }
    }

}
