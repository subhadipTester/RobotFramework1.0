*** Settings ***
Documentation     All the page objects and keywords of Blazedemo Reserve.php page
Library           SeleniumLibrary
Library           Collections
Resource          CommonMethod.robot

*** Variables ***
${Reserve_Page_Btn}         xpath:(//input[@class="btn btn-small"])[2]
${First_Flight_Vendor}       xpath:(//table[@class='table'])/tbody/tr[1]/td[3]
${Departure_City}
${Destination_City}
*** Keywords ***

Wait until Element is located in the page
    Wait Until element passed is located on Page    ${Reserve_Page_Btn}

Extract Data From Flight Table and click to book Flight
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


