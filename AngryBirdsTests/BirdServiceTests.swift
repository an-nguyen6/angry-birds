//
//  BirdServiceTests.swift
//  AngryBirdsTests
//
//  Created by Chelsea Troy on 4/25/20.
//  Copyright © 2020 Chelsea Troy. All rights reserved.
//

import XCTest
@testable import AngryBirds

class BirdServiceTests: XCTestCase {
    var systemUnderTest: BirdService!
    var listViewController: BirdListViewController!

    override func setUp() {
        self.systemUnderTest = BirdService()
        
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        self.listViewController = navigationController.topViewController as? BirdListViewController
        
        UIApplication.shared.windows
            .filter { $0.isKeyWindow }
            .first!
            .rootViewController = self.listViewController
        
        XCTAssertNotNil(navigationController.view)
        XCTAssertNotNil(self.listViewController.view)
    }


    func testAPI_returnsSuccessfulResult() {
        //Given
        var birds: [Bird]!
        var error: Error?
        
        let promise = expectation(description: "Completion handler is invoked")
        
        //When
        self.systemUnderTest.getBirds(completion: { data, shouldntHappen in
            birds = data
            error = shouldntHappen
            promise.fulfill()
        })
        wait(for: [promise], timeout: 5)
        
        //Then
        XCTAssertNotNil(birds)
        XCTAssertNil(error)
    }

}
