//
//  TaskManagerUITests.swift
//  TaskManagerUITests
//
//  Created by mhaashim on 26/02/25.
//

import XCTest

final class TaskManagerUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testTaskCreationFlow() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        let addItemButton = app.buttons["Add Item"]
        XCTAssertTrue(addItemButton.exists, "The 'Add Item' button should exist on the screen")
        addItemButton.tap()
        
        let titleTextField = app.textFields["titleTextField"]
        XCTAssertTrue(titleTextField.exists, "Title TextField should exist")
        titleTextField.tap()
        titleTextField.typeText("My New Task")
        
        
        let descriptionTextField = app.textFields["descriptionTextField"]
        XCTAssertTrue(descriptionTextField.exists, "Description TextField should exist")
        descriptionTextField.tap()
        descriptionTextField.typeText("test description.")
        
        let saveButton = app.buttons["Save"]
        XCTAssertTrue(saveButton.exists, "The 'Save' button should exist on the screen")
        saveButton.tap()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    @MainActor
    func testFilterFunctionality() throws {
        let app = XCUIApplication()
        app.launch()
        
        let completedButton = app.buttons["Completed"]
        XCTAssertTrue(completedButton.exists, "The 'Completed' button should exist on the screen")
        completedButton.tap()
        
        let pendingButton = app.buttons["Pending"]
        XCTAssertTrue(pendingButton.exists, "The 'Pending' button should exist on the screen")
        pendingButton.tap()
        
        let allTasksButton = app.buttons["All"]
        XCTAssertTrue(allTasksButton.exists, "The 'All' button should exist on the screen")
        allTasksButton.tap()
    }

    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
