//
//  NYTimesMostPopularArticlesUITests.swift
//  NYTimesMostPopularArticlesUITests
//
//  Created by ANSAR on 29/11/21.
//

import XCTest

class NYTimesMostPopularArticlesUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testArticleListPageAppeared() throws {
        app.launch()
        let loginNavBarTitle = app.staticTexts["Articles"]
        XCTAssert(loginNavBarTitle.waitForExistence(timeout: 0.5))
    }
    
    func testListViewAppearedAndScrollListViewAndGoToDetailsPage() throws {
        app.launch()
        sleep(10)
        app.tables.firstMatch.swipeUp(velocity: XCUIGestureVelocity.fast)
        app.tables.firstMatch.swipeUp(velocity: XCUIGestureVelocity.fast)

        let cells = app.tables.cells
        print(cells.count)
        // Get an array of cells
        if cells.count > 0 {
            let count: Int = (cells.count - 1)
            
            let expectation = expectation(description: "Wait for table cells")
            
            for i in stride(from: 0, to: count , by: 1) {
                
                // Grab the first cell and verify that it exists and tap it
                let tableCell = cells.element(boundBy: i)
                
                XCTAssertTrue(tableCell.exists, "The \(i) cell is in place on the table")
                
                // Does this actually take us to the next screen
                tableCell.tap()
                
                if i == (count - 1) {
                    expectation.fulfill()
                }
                app.navigationBars.buttons.element(boundBy: 0).tap()
                app.tables.firstMatch.swipeUp(velocity: XCUIGestureVelocity.slow)

                
            }
            
            waitForExpectations(timeout: 50, handler: nil)
            XCTAssertTrue(true, "Finished validating the table cells")
        } else {
            XCTAssert(false, "Was not able to find any table cells")
        }
//        let listView = app.tables["listView"]
//        XCTAssert(listView.waitForExistence(timeout: 0.5))

    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
