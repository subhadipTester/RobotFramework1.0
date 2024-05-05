*** Settings ***
Documentation    A resource file with reusable keywords and variables.
...
...     The system specific keywords created here from our own
...     domain specific language.They utilized keywords provided
...     by the imported Selenium Library.
Library    SeleniumLibrary

*** Variables ***
${url}                 https://blazedemo.com/
${browser_name}        Chrome

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