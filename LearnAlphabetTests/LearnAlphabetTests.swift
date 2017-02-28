//
//  LearnAlphabetTests.swift
//  LearnAlphabetTests
//
//  Created by Bratislav Ljubisic on 3/12/16.
//  Copyright © 2016 Bratislav Ljubisic. All rights reserved.
//

import XCTest
@testable import LearnAlphabet

class LearnAlphabetTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testReadAlphabets() {
        let alphabetJSONReader: LearnAlphabetJSONReader = LearnAlphabetJSONReader()
        
        let arrayOfAlphabets:[Alphabet]? = alphabetJSONReader.readAlphabets()
        
        assert(arrayOfAlphabets != nil, "Array is nil")
        
        
    }
    
    func testReadAvatars() {
        let alphabetJSONReader: LearnAlphabetJSONReader = LearnAlphabetJSONReader()
        
        let arrayOfAvatars:[Avatar]? = alphabetJSONReader.readJSONAvatars()
        
        assert(arrayOfAvatars != nil, "Array is nil")
        
        
    }
    
}
