*** Settings ***
Documentation    To validate login form
Library    SeleniumLibrary
Library    Collections
Library    ../../customLibraries/Shop.py
Test Setup       open the browser with the url
Test Teardown    Close existing Browser session
Suite Setup
Suite Teardown
Resource    ../../PageObjects/PracticePage_PageObjects/Generic.robot
Resource    ../../PageObjects/PracticePage_PageObjects/LandingPage.robot
Resource    ../../PageObjects/PracticePage_PageObjects/ShopPage.robot
Resource    ../../PageObjects/PracticePage_PageObjects/CheckoutPage.robot
Resource    ../../PageObjects/PracticePage_PageObjects/ConfirmationPage.robot


*** Variables ***
@{listofProducts}           Blackberry      Nokia Edge
${country_name}             India



*** Test Cases ***

Validate Unsuccessful login
    [Tags]    SMOKE    REGRESSION
    LandingPage.Fill the login form                          ${user_name}    ${invalid_password}
    LandingPage.Wait until Element is located in the page
    LandingPage.Verify error message is correct

End to End ecommerce Product validation
    [Tags]    REGRESSION
     LandingPage.Fill the login form              ${user_name}    ${valid_password}
     ShopPage.Wait until Element is located in the page
     ShopPage.Verify Card titles in the Shop page
     ShopPage.Select the card    Samsung Note 8
     Add Items To Cart And Checkout    ${listofProducts}
     CheckoutPage.Verify items in the Checkout Page and proceed
     ConfirmationPage.Enter the Country and select the terms    ${country_name}
     ConfirmationPage.Purchase the Product and Confirm the Purchase


Select the Form and Navigate to child window
    [Tags]    SMOKE    REGRESSION
    LandingPage.Fill the Login Details and Login Form








