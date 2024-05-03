*** Settings ***
Documentation     All the page objects and keywords of Confirmation page
Library           SeleniumLibrary
Library           Collections
Resource          Generic.robot

*** Variables ***
${Shop_Page_Load}         css:.nav-link
${country_location}       //a[text()='India']

*** Keywords ***

Enter the Country and select the terms
    [Arguments]      ${country_name}
    input text       id:country     ${country_name}
    Wait Until element passed is located on Page        //a[text()='${country_name}']
    click element       //a[text()='${country_name}']
    Sleep               2
    click element       css:.checkbox label


Purchase the Product and Confirm the Purchase
    click button            css:.btn-success
    page should contain     Success! Thank you! Your order will be delivered in next few weeks :-)