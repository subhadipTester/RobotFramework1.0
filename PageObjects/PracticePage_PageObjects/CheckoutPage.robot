*** Settings ***
Documentation     All the page objects and keywords of Checkout page
Library           SeleniumLibrary
Library           Collections

*** Variables ***
${Shop_Page_Load}         css:.nav-link

*** Keywords ***

Verify items in the Checkout Page and proceed
    Click Element    css:.btn-success


