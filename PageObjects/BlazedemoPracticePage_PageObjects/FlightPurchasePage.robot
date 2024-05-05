*** Settings ***
Documentation     All the page objects and keywords of Blazedemo purchase.php page
Library           SeleniumLibrary
Library           Collections
Resource          CommonMethod.robot

*** Variables ***
${Purchase_Flight_Btn}    //input[@class="btn btn-primary"]
${Passenger_Full_Name}    Heinrich Fuchs
${Passenger_Address}      78963 Parksdale Avenue
${Passenger_City}         New Jersey
${Passenger_State}        Alabama
${Passenger_zipCode}      789632
${creditCard}             74185296378945612
${creditCardMonth}        12
${creditCardYear}         2022
${creditCardType}         amex



*** Keywords ***

Wait until Element is located in the page
    Wait Until element passed is located on Page    ${Purchase_Flight_Btn}

Enter Passenger Details and Click on Purchase Flight Button to Confirmation Page
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


Verify Credit Card Type in the Purchase page
   @{expectedList} =    Create List     Visa        American Express        Diner's Club
   ${elements} =        Get List Items     xpath://select[@name="cardType"]
   @{actualList} =      Create List
   FOR  ${element}  IN      @{elements}
      Log   ${element}
      Append To List    ${actualList}     ${element}
   END
   Lists Should Be Equal   ${expectedList}    ${actualList}


