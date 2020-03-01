//
//  YanikPerera_cobsccomp182p_007UITests.swift
//  YanikPerera-cobsccomp182p-007UITests
//
//  Created by Yanik Perera on 2/20/20.
//  Copyright © 2020 Yanik Perera. All rights reserved.
//

import XCTest

class YanikPerera_cobsccomp182p_007UITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
        
    


    func testExample() {
        // Use recording to get started writing UI tests.
        
        
        let app = XCUIApplication()
        let scrollViewsQuery = app.scrollViews
        let elementsQuery = scrollViewsQuery.otherElements
        elementsQuery.buttons["Home Page"].tap()
        app.navigationBars["YanikPerera_cobsccomp182p_007.UiTabBarHomeView"].buttons["Back"].tap()
        
        let loginButton = elementsQuery.buttons["Login"]
        loginButton.tap()
        
        let userNameTextField = elementsQuery.textFields["User Name"]
        userNameTextField.tap()
        loginButton.tap()
        
        let errorWithSaveAlert = app.alerts["Error with Save"]
        let addMissingFieldButton = errorWithSaveAlert.buttons["Add Missing Field"]
        addMissingFieldButton.tap()
        loginButton.tap()
        userNameTextField.tap()
        loginButton.tap()
        
        let passwordSecureTextField = elementsQuery.secureTextFields["Password"]
        passwordSecureTextField.tap()
        loginButton.tap()
        passwordSecureTextField.tap()
       // app.alerts["Error occured"].buttons["Okay"].tap()
        
        let forgotPasswordButton = elementsQuery.buttons["Forgot Password ?"]
        forgotPasswordButton.tap()
        
        let resetPasswordButton = app.alerts["Forgot password?"].buttons["Reset Password"]
        resetPasswordButton.tap()
        
        let okButton = app.alerts["Reset Failed"].buttons["OK"]
        okButton.tap()
        forgotPasswordButton.tap()
        resetPasswordButton.tap()
        passwordSecureTextField.tap()
        okButton.tap()
        forgotPasswordButton.tap()
        resetPasswordButton.tap()
        passwordSecureTextField.tap()
        okButton.tap()
        forgotPasswordButton.tap()
        resetPasswordButton.tap()
        passwordSecureTextField.tap()
       // app.alerts["Reset email sent successfully"].buttons["OK"].tap()
      //  app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).tap()
        app.navigationBars["YanikPerera_cobsccomp182p_007.UiUserLoginView"].buttons["Back"].tap()
        elementsQuery.buttons["Sign In"].tap()
        elementsQuery.images["User profile img.jpg"].tap()
        app.navigationBars["Photos"].buttons["Cancel"].tap()
        
        let firstnameTextField = elementsQuery.textFields["FirstName"]
       // firstnameTextField.tap()
        
        let registerButton = elementsQuery.buttons["Register"]
        registerButton.tap()
        
        let registerButton2 = app.alerts["Error"].buttons["Register"]
        registerButton2.tap()
        
        let eMailTextField = elementsQuery.textFields["E-mail"]
        eMailTextField.tap()
        registerButton.tap()
        eMailTextField.tap()
        registerButton.tap()
        passwordSecureTextField.tap()
        registerButton.tap()
        passwordSecureTextField.tap()
        registerButton.tap()
        
        let contactNumberTextField = elementsQuery.textFields["Contact Number"]
        contactNumberTextField.tap()
        registerButton.tap()
        contactNumberTextField.tap()
        registerButton.tap()
        firstnameTextField.tap()
        
        let element = scrollViewsQuery.children(matching: .other).element
        element.tap()
        registerButton.tap()
        firstnameTextField.tap()
        registerButton.tap()
        element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).tap()
        
        let lastnameTextField = elementsQuery.textFields["LastName"]
        lastnameTextField.tap()
        registerButton.tap()
        lastnameTextField.tap()
        registerButton.tap()
        
        let departmentTextField = elementsQuery.textFields["Department"]
        departmentTextField.tap()
        registerButton.tap()
        departmentTextField.tap()
        registerButton.tap()
        
        let confirmPasswordSecureTextField = elementsQuery.secureTextFields["Confirm Password"]
        confirmPasswordSecureTextField.tap()
        registerButton.tap()
        confirmPasswordSecureTextField.tap()
        //errorWithSaveAlert.buttons["Fix Error"].tap()
        app.navigationBars["YanikPerera_cobsccomp182p_007.UiUserRegisterView"].buttons["Back"].tap()
 
       //app.alerts["Reset email sent successfully"].buttons["OK"].tap()
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    

}
   
}
