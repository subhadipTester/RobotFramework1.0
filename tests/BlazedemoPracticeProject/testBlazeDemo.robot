*** Settings ***
Documentation     A test suite with a single test for BlazeDemo
...               Created by Subhadip Roy
Library           SeleniumLibrary    timeout=10
Test Setup       Open the browser with the url
Test Teardown    Close existing Browser session
Resource         ../../PageObjects/BlazedemoPracticePage_PageObjects/CommonMethod.robot
Resource         ../../PageObjects/BlazedemoPracticePage_PageObjects/HomePage.robot
Resource         ../../PageObjects/BlazedemoPracticePage_PageObjects/ReservationPage.robot
Resource         ../../PageObjects/BlazedemoPracticePage_PageObjects/FlightPurchasePage.robot
Resource         ../../PageObjects/BlazedemoPracticePage_PageObjects/FlightConfirmationPage.robot

*** Variables ***


*** Test Cases ***
E2E BlazeDemo Functional Test
    [Tags]    REGRESSION
    [Documentation]    This Testcase executes entire E2E workflow for Blazedemo Sample Page
    HomePage.Verify Departure City Dropdown list items in the Homepage
    HomePage.Verify Destination City Dropdown list items in the Homepage
    HomePage.Wait until Element is located in the page
    HomePage.Select Departure and Destination City and Navigate to Flight Reservation Page    ${Departure_City}    ${Destination_City}
    ReservationPage.Wait until Element is located in the page
    ReservationPage.Extract Data From Flight Table and click to book Flight
    FlightPurchasePage.Wait until Element is located in the page
    FlightPurchasePage.Verify Credit Card Type in the Purchase page
    FlightPurchasePage.Enter Passenger Details and Click on Purchase Flight Button to Confirmation Page
    FlightConfirmationPage.Confirm the Purchase

