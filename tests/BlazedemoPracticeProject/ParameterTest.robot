*** Settings ***
Documentation     A Testsuite with Parameterised TestCases for BlazeDemo
...               Created by Subhadip Roy
Library           SeleniumLibrary    timeout=10
Library           DataDriver      file=../resources/CustomerDataSet.csv    encoding=utf_8   dialect=unix
Test Setup        Open the browser with the url
Test Teardown     Close existing Browser session
Test Template     Passenger Details fill up and verification


*** Variables ***
${FindFlights_Btn}             //input[@class="btn btn-primary"]
${Reserve_Page_Btn}            xpath:(//input[@class="btn btn-small"])[2]
${First_Flight_Vendor}         xpath:(//table[@class='table'])/tbody/tr[1]/td[3]
${Purchase_Flight_Btn}        //input[@class="btn btn-primary"]
${webtable}                   //table[@class='table']/tbody/tr[1]/td[2]
${url}                        https://blazedemo.com/
${browser_name}               Chrome


*** Test Cases ***
E2E Blazedemo Parametrised Test for user ${Passenger_Full_Name} with ${creditCardType} and ${creditCard}    Hailey Speaks    amex    5108752743344604
    Passenger Details fill up and verification


*** Keywords ***
Open the browser with the url
    Create Webdriver    ${browser_name}
    Go To   ${url}
    Maximize Browser Window

Close existing Browser session
    Close Browser

Wait Until element passed is located on Page
    [Arguments]         ${page_locator}
    Wait Until Element Is Visible        ${page_locator}        timeout=10

Passenger Details fill up and verification
    [Arguments]    ${Departure_City}    ${Destination_City}    ${Passenger_Full_Name}    ${Passenger_Address}    ${Passenger_City}    ${Passenger_State}    ${Passenger_zipCode}    ${creditCardType}    ${creditCard}    ${creditCardMonth}    ${creditCardYear}
    Page Should Contain          Welcome to the Simple Travel Agency!
    Select From List By Value    //select[@name="fromPort"]    ${Departure_City}
    Select From List By Value    //select[@name="toPort"]      ${Destination_City}
    Set Global Variable          ${Departure_City}
    Set Global Variable          ${Destination_City}
    Click Element                ${FindFlights_Btn}
    Page Should Contain    Flights from ${Departure_City} to ${Destination_City}:
    #get the total number of rows in the table
    ${rows}=       Get Element Count    xpath://table[@class='table']/tbody/tr
    Log    ${rows}
    #get the count of columns in a specific row
    ${columns}=    Get Element Count    xpath://table[@class='table']/tbody/tr[1]/td
    Log    ${columns}
    #Capture the data of a specific cell
    ${flight_name}=               Get Text      xpath://table[@class='table']/tbody/tr[2]/td[3]
    Should Be Equal As Strings    ${flight_name}                United Airlines
    Element Text Should Be        ${First_Flight_Vendor}        Virgin America
    #Validate header
    table header should contain      xpath://table[@class='table']     Flight #
    #Validate row
    table row should contain         xpath://table[@class='table']     3   9696
    #Validate column
    table column should contain      xpath://table[@class='table']     6   $472.56
    #Validate cell
    table cell should contain        xpath://table[@class='table']     6   3   Lufthansa
    Click Element                    ${Reserve_Page_Btn}
    Page Should Contain    Your flight from TLV to SFO has been reserved.
    Input Text             //input[@name="inputName"]    ${Passenger_Full_Name}
    Input Text            //input[@name="address"]      ${Passenger_Address}
    Input Text           //input[@name="city"]         ${Passenger_City}
    Input Text          //input[@name="state"]        ${Passenger_State}
    Input Text         //input[@name="zipCode"]      ${Passenger_zipCode}
    Page Should Contain List      //select[@name="cardType"]
    Select From List By Value    //select[@name="cardType"]    ${creditCardType}
    Input Text             //input[@name="creditCardNumber"]   ${creditCard}
    Input Text             //input[@name='creditCardMonth']    ${creditCardMonth}
    Input Text            //input[@name="creditCardYear"]    ${creditCardYear}
    Input Text           //input[@name="nameOnCard"]    ${Passenger_Full_Name}
    Click Element      //input[@name="rememberMe"]
    Click Element     ${Purchase_Flight_Btn}
    page should contain     Thank you for your purchase today!
    ${Purchase_Id}=     Get Text    ${webtable}
    Log  ${Purchase_Id}


