*** Settings ***
Documentation    A resource file with reusable keywords and variables.
...
...     The system specific keywords created here from our own
...     domain specific language.They utilized keywords provided
...     by the imported Selenium Library.
Library    SeleniumLibrary

*** Variables ***
${user_name}           rahulshettyacademy
${invalid_password}    learning123
${valid_password}      learning
${url}                 https://rahulshettyacademy.com/loginpagePractise/
${browser_name}        Chrome

*** Keywords ***
open the browser with login page url
    Create Webdriver    Chrome
    Go To               ${url}

open the browser with the url
    Create Webdriver    ${browser_name}
    Go To   ${url}

Close existing Browser session
    Close Browser

Wait Until element passed is located on Page
    [Arguments]         ${page_locator}
    Wait Until Element Is Visible        ${page_locator}        timeout=10
