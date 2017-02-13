//
//  UserTests.swift
//  SaitamaCycleRent
//
//  Created by Devanshu Saini on 13/02/17.
//  Copyright © 2017 Devanshu Saini devanshu2@gmail.com. All rights reserved.
//

import XCTest

class UserTests: XCTestCase {
    
    var userModel:User!
    
    override func setUp() {
        super.setUp()
        self.userModel = User()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testClearCredentials() {
        self.userModel.email = "devanshu2@gmail.com"
        self.userModel.password = "somepassword"
        self.userModel.clearCredentials()
        XCTAssertNil(self.userModel.email, "User email is not flushed")
        XCTAssertNil(self.userModel.password, "User password is not flushed")
    }
    
    func testValidAuthenticateUser() {
        self.userModel.email = "devanshu2@gmail.com"
        self.userModel.password = "somepassword"
        var isThereError = false
        do {
            try self.userModel.authentication(withCompletionHandler: { (accessToken, error, errorMessage) in
                
            })
        } catch UserAuthenticationCallError.blankEmail {
            isThereError = true
        } catch UserAuthenticationCallError.largeEmail {
            isThereError = true
        } catch UserAuthenticationCallError.invalidEmail {
            isThereError = true
        } catch UserAuthenticationCallError.blankPassword {
            isThereError = true
        } catch UserAuthenticationCallError.largePassword {
            isThereError = true
        } catch {
            isThereError = true
        }
        
        XCTAssertFalse(isThereError, "Expected was false")
    }
    
    func testInValidAuthenticateUser() {
        self.userModel.email = "devanshu"
        self.userModel.password = "somepassword"
        var isThereError = false
        do {
            try self.userModel.authentication(withCompletionHandler: { (accessToken, error, errorMessage) in
                
            })
        } catch UserAuthenticationCallError.blankEmail {
            isThereError = true
        } catch UserAuthenticationCallError.largeEmail {
            isThereError = true
        } catch UserAuthenticationCallError.invalidEmail {
            isThereError = true
        } catch UserAuthenticationCallError.blankPassword {
            isThereError = true
        } catch UserAuthenticationCallError.largePassword {
            isThereError = true
        } catch {
            isThereError = true
        }
        
        XCTAssertTrue(isThereError, "Expected was true")
    }
    
    func testInValidOutboundAuthenticateUser() {
        self.userModel.email = "devanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudvanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshu@gmail.com"
        self.userModel.password = "somepasswordsomepasswordsomepasswordsomepasswordsomepasswordsomepasswordsomepasswordomepasswordsomepasswordsomepasswordsomepasswordsomepassword"
        var isThereError = false
        do {
            try self.userModel.authentication(withCompletionHandler: { (accessToken, error, errorMessage) in
                
            })
        } catch UserAuthenticationCallError.blankEmail {
            isThereError = true
        } catch UserAuthenticationCallError.largeEmail {
            isThereError = true
        } catch UserAuthenticationCallError.invalidEmail {
            isThereError = true
        } catch UserAuthenticationCallError.blankPassword {
            isThereError = true
        } catch UserAuthenticationCallError.largePassword {
            isThereError = true
        } catch {
            isThereError = true
        }
        
        XCTAssertTrue(isThereError, "Expected was true")
    }
    
    
    func testValidRegisterUser() {
        self.userModel.email = "devanshu2@gmail.com"
        self.userModel.password = "somepassword"
        var isThereError = false
        do {
            try self.userModel.register(withCompletionHandler: { (accessToken, error, errorMessage) in
                
            })
        } catch UserRegisterCallError.blankEmail {
            isThereError = true
        } catch UserRegisterCallError.largeEmail {
            isThereError = true
        } catch UserRegisterCallError.invalidEmail {
            isThereError = true
        } catch UserRegisterCallError.blankPassword {
            isThereError = true
        } catch UserRegisterCallError.largePassword {
            isThereError = true
        } catch {
            isThereError = true
        }
        
        XCTAssertFalse(isThereError, "Expected was false")
    }
    
    func testInValidRegisterUser() {
        self.userModel.email = "devanshu"
        self.userModel.password = "somepassword"
        var isThereError = false
        do {
            try self.userModel.register(withCompletionHandler: { (accessToken, error, errorMessage) in
                
            })
        } catch UserRegisterCallError.blankEmail {
            isThereError = true
        } catch UserRegisterCallError.largeEmail {
            isThereError = true
        } catch UserRegisterCallError.invalidEmail {
            isThereError = true
        } catch UserRegisterCallError.blankPassword {
            isThereError = true
        } catch UserRegisterCallError.largePassword {
            isThereError = true
        } catch {
            isThereError = true
        }
        
        XCTAssertTrue(isThereError, "Expected was true")
    }
    
    func testInValidOutboundRegisterUser() {
        self.userModel.email = "devanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudvanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshudevanshu@gmail.com"
        self.userModel.password = "somepasswordsomepasswordsomepasswordsomepasswordsomepasswordsomepasswordsomepasswordomepasswordsomepasswordsomepasswordsomepasswordsomepassword"
        var isThereError = false
        do {
            try self.userModel.register(withCompletionHandler: { (accessToken, error, errorMessage) in
                
            })
        } catch UserRegisterCallError.blankEmail {
            isThereError = true
        } catch UserRegisterCallError.largeEmail {
            isThereError = true
        } catch UserRegisterCallError.invalidEmail {
            isThereError = true
        } catch UserRegisterCallError.blankPassword {
            isThereError = true
        } catch UserRegisterCallError.largePassword {
            isThereError = true
        } catch {
            isThereError = true
        }
        
        XCTAssertTrue(isThereError, "Expected was true")
    }
}
