*** Settings ***
Documentation     All the page objects and keywords of Blazedemo Homepage
Library           SeleniumLibrary
Library           Collections
Resource          CommonMethod.robot


*** Variables ***
${Departure_City}      Boston
${Destination_City}    London
${FindFlights_Btn}     //input[@class="btn btn-primary"]

*** Keywords ***
Select Departure and Destination City and Navigate to Flight Reservation Page
    [Arguments]    ${Departure_City}    ${Destination_City}
    Page Should Contain          Welcome to the Simple Travel Agency!
    Select From List By Value    //select[@name="fromPort"]    ${Departure_City}
    Select From List By Value    //select[@name="toPort"]      ${Destination_City}
    Set Global Variable          ${Departure_City}
    Set Global Variable          ${Destination_City}
    Click Element                ${FindFlights_Btn}

Wait until Element is located in the page
    Wait Until element passed is located on Page    ${FindFlights_Btn}


Verify Departure City Dropdown list items in the Homepage
   @{expectedList} =    Create List     Paris        Philadelphia        Boston    Portland    San Diego    Mexico City    São Paolo
   ${elements} =        Get List Items     xpath://select[@name="fromPort"]
   @{actualList} =      Create List
   FOR  ${element}  IN      @{elements}
      Log   ${element}
      Append To List    ${actualList}     ${element}
   END
   Lists Should Be Equal   ${expectedList}    ${actualList}

Verify Destination City Dropdown list items in the Homepage
   @{expectedList} =    Create List     Buenos Aires        Rome        London    Berlin    New York    Dublin    Cairo
   ${elements} =        Get List Items     xpath://select[@name="toPort"]
   @{actualList} =      Create List
   FOR  ${element}  IN      @{elements}
      Log   ${element}
      Append To List    ${actualList}     ${element}
   END
   Lists Should Be Equal   ${expectedList}    ${actualList}