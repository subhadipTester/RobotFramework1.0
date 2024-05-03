*** Settings ***
Documentation    To validate login form
Library    SeleniumLibrary
Library     DataDriver      file=../resources/data.csv    encoding=utf_8   dialect=unix
Test Teardown    Close Browser
Test Template    Validate Unsuccessful login

*** Variables ***
${Error_Message_Login}    css:.alert-danger

*** Test Cases ***
Login with parameterised user ${username} and password ${password}    rahulshetty789    78963

*** Keywords ***

Validate Unsuccessful login
    [Arguments]    ${username}    ${password}
    open the browser with login page url
    Fill the login form    ${username}    ${password}
    Wait until it checks and display error message
    Verify error message is correct

open the browser with login page url
    Create Webdriver    Chrome
    Go To    https://rahulshettyacademy.com/loginpagePractise/

Fill the login form
    [Arguments]       ${username}    ${password}
    Input Text        id:username    ${username}
    Input Password    id:password    ${password}
    Click Button      id:signInBtn

Wait until it checks and display error message
    Wait Until Element Is Visible    ${Error_Message_Login}

Verify error message is correct
    ${result}=    Get Text    ${Error_Message_Login}
    Should Be Equal As Strings    ${result}             Incorrect username/password.
    Element Text Should Be    ${Error_Message_Login}    Incorrect username/password.