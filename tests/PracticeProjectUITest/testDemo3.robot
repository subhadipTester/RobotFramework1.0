*** Settings ***
Documentation    To validate login form
Library    SeleniumLibrary
Library    Collections
Test Setup       open the browser with login page url
Test Teardown    Close existing Browser session
Resource    ../../PageObjects/PracticePage_PageObjects/Generic.robot


*** Variables ***
${Error_Message_Login}    css:.alert-danger
${Shop_Page_Load}         css:.nav-link




*** Test Cases ***

Validate Unsuccessful login
    [Tags]    SMOKE
    Fill the login form                          ${user_name}    ${invalid_password}
    Wait until Element is located in the page    ${Error_Message_Login}
    Verify error message is correct

Validate Cards display in the shopping page
    [Tags]    SMOKE
     Fill the login form                          ${user_name}    ${valid_password}
     Wait until Element is located in the page    ${Shop_Page_Load}
     Verify Card titles in the Shop page
     Select the card    Blackberry

Select the Form and Navigate to child window
    [Tags]    SMOKE
    Fill the Login Details and Login Form        ${user_name}    ${valid_password}

*** Keywords ***

Fill the login form
    [Arguments]       ${username}    ${password}
    Input Text        id:username    ${username}
    Input Password    id:password    ${password}
    Click Button      id:signInBtn

Wait until Element is located in the page
    [Arguments]    ${element}
    Wait Until Element Is Visible    ${element}

Verify Card titles in the Shop page
   @{expectedList} =    Create List     iphone X    Samsung Note 8      Nokia Edge       Blackberry
   ${elements} =  Get WebElements     css:.card-title
   @{actualList} =   Create List
   FOR  ${element}  IN      @{elements}
      Log   ${element.text}
      Append To List    ${actualList}     ${element.text}
   END
   Lists Should Be Equal   ${expectedList}    ${actualList}


Select the Card
    [Arguments]     ${cardName}
    ${elements} =  Get WebElements     css:.card-title
    ${index}=   Set Variable    1
     FOR  ${element}  IN      @{elements}
         Exit For Loop If      '${cardName}' == '${element.text}'
         ${index}=  Evaluate   ${index} + 1
     END
    Click Button    xpath:(//*[@class='card-footer'])[${index}]/button

    
Fill the Login Details and Login Form
    [Arguments]       ${username}    ${password}
    Input Text        id:username    ${username}
    Input Password    id:password    ${password}
    Click Element     css:input[value='user']
    Wait Until Element Is Visible    css:.modal-body
    Click Button      id:okayBtn
    Click Button      id:okayBtn
    Wait Until Element Is Not Visible    css:.modal-body
    Select From List By Value    css:select[class='form-control']    teach
    Select Checkbox    css:#terms
    Checkbox Should Be Selected    id:terms


    



Verify error message is correct
    ${result}=    Get Text        ${Error_Message_Login}
    Should Be Equal As Strings    ${result}                 Incorrect username/password.
    Element Text Should Be        ${Error_Message_Login}    Incorrect username/password.






