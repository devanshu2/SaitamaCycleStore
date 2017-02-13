//
//  PaymentTests.swift
//  SaitamaCycleRent
//
//  Created by Devanshu Saini on 13/02/17.
//  Copyright © 2017 Devanshu Saini devanshu2@gmail.com. All rights reserved.
//

import XCTest

class PaymentTests: XCTestCase {
    
    var paymentModel:Payment!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.paymentModel = Payment()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testValidCase() {
        self.paymentModel.number = "1234567890123456"
        self.paymentModel.name = "Devanshu"
        self.paymentModel.expirationMonth = "01"
        self.paymentModel.expirationYear = "20"
        self.paymentModel.code = "111"
        var isThereError = false
        do {
            try self.paymentModel.rent(withCompletionHandler: { (accessToken, error, errorMessage) in
                
            })
        } catch RentPaymentCallError.invalidCode {
            isThereError = true
        } catch RentPaymentCallError.invalidNumber {
            isThereError = true
        } catch RentPaymentCallError.blankName {
            isThereError = true
        } catch RentPaymentCallError.invalidExpiry {
            isThereError = true
        } catch {
            isThereError = true
        }
        XCTAssertFalse(isThereError, "Expected was false: \(isThereError)")
    }
    
    func testInValidWithNumber() {
        self.paymentModel.number = "1237890123456"
        self.paymentModel.name = "Devanshu"
        self.paymentModel.expirationMonth = "01"
        self.paymentModel.expirationYear = "20"
        self.paymentModel.code = "111"
        var isThereError = false
        do {
            try self.paymentModel.rent(withCompletionHandler: { (accessToken, error, errorMessage) in
                
            })
        } catch RentPaymentCallError.invalidCode {
            isThereError = true
        } catch RentPaymentCallError.invalidNumber {
            isThereError = true
        } catch RentPaymentCallError.blankName {
            isThereError = true
        } catch RentPaymentCallError.invalidExpiry {
            isThereError = true
        } catch {
            isThereError = true
        }
        
        XCTAssertTrue(isThereError, "Expected was true")
    }
    
    func testInValidWithName() {
        self.paymentModel.number = "1234567890123456"
        self.paymentModel.name = ""
        self.paymentModel.expirationMonth = "01"
        self.paymentModel.expirationYear = "20"
        self.paymentModel.code = "111"
        var isThereError = false
        do {
            try self.paymentModel.rent(withCompletionHandler: { (accessToken, error, errorMessage) in
                
            })
        } catch RentPaymentCallError.invalidCode {
            isThereError = true
        } catch RentPaymentCallError.invalidNumber {
            isThereError = true
        } catch RentPaymentCallError.blankName {
            isThereError = true
        } catch RentPaymentCallError.invalidExpiry {
            isThereError = true
        } catch {
            isThereError = true
        }
        
        XCTAssertTrue(isThereError, "Expected was true")
    }
    
    func testInValidWithCode() {
        self.paymentModel.number = "1234567890123456"
        self.paymentModel.name = "Devanshu"
        self.paymentModel.expirationMonth = "01"
        self.paymentModel.expirationYear = "20"
        self.paymentModel.code = "11"
        var isThereError = false
        do {
            try self.paymentModel.rent(withCompletionHandler: { (accessToken, error, errorMessage) in
                
            })
        } catch RentPaymentCallError.invalidCode {
            isThereError = true
        } catch RentPaymentCallError.invalidNumber {
            isThereError = true
        } catch RentPaymentCallError.blankName {
            isThereError = true
        } catch RentPaymentCallError.invalidExpiry {
            isThereError = true
        } catch {
            isThereError = true
        }
        
        XCTAssertTrue(isThereError, "Expected was true")
    }
    
    func testInValidOutbound() {
        self.paymentModel.number = "123456782343432423423423424234234234234234234234234234290123456"
        self.paymentModel.name = "Devanshu"
        self.paymentModel.expirationMonth = "01"
        self.paymentModel.expirationYear = "20"
        self.paymentModel.code = "11341"
        var isThereError = false
        do {
            try self.paymentModel.rent(withCompletionHandler: { (accessToken, error, errorMessage) in
                
            })
        } catch RentPaymentCallError.invalidCode {
            isThereError = true
        } catch RentPaymentCallError.invalidNumber {
            isThereError = true
        } catch RentPaymentCallError.blankName {
            isThereError = true
        } catch RentPaymentCallError.invalidExpiry {
            isThereError = true
        } catch {
            isThereError = true
        }
        
        XCTAssertTrue(isThereError, "Expected was true")
    }
    
    func testInValidExpiry() {
        self.paymentModel.number = "1234567890123456"
        self.paymentModel.name = "Devanshu"
        self.paymentModel.expirationMonth = "01"
        self.paymentModel.expirationYear = "11"
        self.paymentModel.code = "111"
        var isThereError = false
        do {
            try self.paymentModel.rent(withCompletionHandler: { (accessToken, error, errorMessage) in
                
            })
        } catch RentPaymentCallError.invalidCode {
            isThereError = true
        } catch RentPaymentCallError.invalidNumber {
            isThereError = true
        } catch RentPaymentCallError.blankName {
            isThereError = true
        } catch RentPaymentCallError.invalidExpiry {
            isThereError = true
        } catch {
            isThereError = true
        }
        
        XCTAssertTrue(isThereError, "Expected was true")
    }
    
}
