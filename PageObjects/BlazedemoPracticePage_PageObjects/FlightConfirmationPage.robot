*** Settings ***
Documentation     All the page objects and keywords of Blazedemo confirmation.php page
Library           SeleniumLibrary
Library           Collections

*** Variables ***
${webtable}    //table[@class='table']/tbody/tr[1]/td[2]

*** Keywords ***
Confirm the Purchase
    page should contain     Thank you for your purchase today!
    ${Purchase_Id}=     Get Text    ${webtable}
    Log  ${Purchase_Id}