//
//  CHSwiftCodingTests.swift
//  CHSwiftCodingTests
//
//  Created by Setu Desai on 2/16/24.
//

import XCTest
@testable import CHSwiftCoding

class CHSwiftCodingTests: XCTestCase {

    var solveModel: CHSolution!
    var sut: CHPathVC!
    var sutVM: CHPathViewModel!
    
    override func setUp() {
        super.setUp()
        let matrixValue = [[3,4,1,2,8,6], [6,1,8,2,7,4], [5,9,3,9,9,5],[8,4,1,3,2,6],[3,7,2,8,6,4]]
        solveModel = CHSolution(mat: matrixValue)
        sut = CHPathVC()
        sutVM = CHPathViewModel()
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        solveModel = nil
    }
    
    func testSolutionLogic() {
        XCTAssertNotNil(solveModel)
        XCTAssertNotNil(solveModel?.solve())
        XCTAssertTrue(solveModel?.solve().1 ?? false)
        XCTAssertEqual(solveModel?.solve().0 ?? 0, 16)
    }
    
    func testPathViewLogic() {
        sut.CHTextView.text = "2,1,3\n1,2,3\n3,2,1"
        sut.perform(#selector(sut.onPressOfButton))
        
        XCTAssertEqual(sut.CHResponseLabel.text, "3 \ntrue \n [2, 1, 3]")
        
        sut.CHTextView.text = "19,10,19,10,19\n21,23,20,19,12\n20,21,20,11,10"
        sut.perform(#selector(sut.onPressOfButton))
        
        XCTAssertEqual(sut.CHResponseLabel.text, "48 \nfalse \n [1, 1, 1]")
    }
    
    func testPathViewModelLogic() {
        sut.CHTextView.text = "2,1,3\n1,2,3\n3,2,1"
        sut.perform(#selector(sut.onPressOfButton))
        
        XCTAssertEqual(sut.CHResponseLabel.text, "3 \ntrue \n [2, 1, 3]")
        let inputArray = sutVM.convertFromStringToGridArray(input: sut.CHTextView.text ?? "")
        XCTAssertEqual(inputArray, [[2,1,3],[1,2,3],[3,2,1]])
        XCTAssertEqual(sutVM.getResponseLabelText(inputArray: inputArray ?? []), "3 \ntrue \n [2, 1, 3]")
        
        sut.CHTextView.text = "19,10,19,10,19\n21,23,20,19,12\n20,21,20,11,10"
        sut.perform(#selector(sut.onPressOfButton))
        
        let inputArray1 = sutVM.convertFromStringToGridArray(input: sut.CHTextView.text ?? "")
        XCTAssertEqual(inputArray1, [[19,10,19,10,19],[21,23,20,19,12],[20,21,20,11,10]])
        XCTAssertEqual(sutVM.getResponseLabelText(inputArray: inputArray1 ?? []), "48 \nfalse \n [1, 1, 1]")
        
        
        sut.CHTextView.text = ""
        sut.perform(#selector(sut.onPressOfButton))
        XCTAssertNotNil(sutVM.showAlertView(.emptyInput))
        
        sut.CHTextView.text = "1,2,3,4,,,\n\n1,2,3"
        sut.perform(#selector(sut.onPressOfButton))
        XCTAssertNotNil(sutVM.showAlertView(.invalidArray))
    }
}
