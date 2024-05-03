*** Settings ***
Documentation    To validate login form
Library    SeleniumLibrary
Library    Collections
Library    String
Test Setup       open the browser with login page url
Test Teardown    Close existing Browser session
Resource    ../../PageObjects/PracticePage_PageObjects/Generic.robot


*** Variables ***
${Error_Message_Login}    css:.alert-danger
${Shop_Page_Load}         css:.nav-link




*** Test Cases ***

Select the Form and Navigate to child window
    [Tags]    SMOKE
    Fill the Login Details and validate Login Form        ${user_name}    ${valid_password}
Validate Child window Functionality
    [Tags]    NEWFEATURE
    Select the link for Child Window
    Verify User is switched to Child Window
    Grab Email id in the child window
    Switch to parent window and enter email id

*** Keywords ***

Fill the Login Details and validate Login Form
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

Select the link for Child Window
    Click Element    css:.blinkingText
    Sleep            5




Verify User is switched to Child Window
    Switch Window    NEW
    Element Text Should Be    css:div[class='inner-box'] h1    DOCUMENTS REQUEST




Grab Email id in the child window
    ${text}=            Get Text            css:.im-para.red
    @{words}=           Split String        ${text}        at
    ${text_split}=      Get From List       ${words}       1
    Log                 ${text_split}
    @{words_2}=         Split String    ${text_split}
    ${email}=           Get From List   ${words_2}     0
    Set Global Variable    ${email} 











Switch to parent window and enter email id
    Switch Window        MAIN
    Title Should Be      LoginPage Practise | Rahul Shetty Academy
    Input Text           id:username            ${email}
