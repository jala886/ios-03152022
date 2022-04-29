//
//  PocketMonsterUITests.swift
//  PocketMonsterUITests
//
//  Created by jianli on 4/26/22.
//

import XCTest
@testable import PocketMonster
extension PokemonListView{
    func presentAlert(title: String, message : String) {print("alertTest") /* ... */ }
}
class PocketMonsterUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        
        let app = XCUIApplication()
                app.launch()
        
        

        //let app = XCUIApplication()
        let tablesQuery = app.tables
        
        var searchText = app.searchFields["Search pokemon"]
//        searchText.tap()
//        searchText.doubleTap()
//        app.keyboards.buttons["i"].tap()
//        app.keys["v"].tap()
//        sleep(30)
        
        sleep(10)
        tablesQuery.cells["Ivysaur"].tap()
        sleep(1)
        app.navigationBars.buttons["PokeDex"].tap()
        searchText.tap()
        app.searchFields["Search pokemon"].typeText("iv")
        
        UIPasteboard.general.string = "iv"
        searchText.doubleTap()
        //app.menus["Paste"].tap()
        app.menuItems.element(boundBy: 0).tap()
        //searchText.typeText("iv")
        print("****",type(of:searchText))
        
        

//        app.navigationBars["_TtGC7SwiftUI19UIHosting"].buttons["PokeDex"].tap()
//        tablesQuery.cells["Charmeleon"].children(matching: .other).element(boundBy: 0).children(matching: .other).element.tap()
//        app.navigationBars["PokeDex"].buttons["PokeDex"].tap()
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    func testURL() throws {
        
//        let network = NetworkManager()
//        network.url = "^:ht:badurl"
        
    }

}
