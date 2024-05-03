*** Settings ***
Library    Collections
Library    RequestsLibrary





*** Variables ***
${base_url}         https://rahulshettyacademy.com
${book_id}
${book_name}        RobotFramework
${isbn}             824905
${aisle}            2352707
${author_name}      Javier Moreno







*** Test Cases ***
Play around with Dictionary
    [Tags]      API
    &{data}=    Create Dictionary      name=rahulshetty     course=robot       website=rahulshettyacademy.com
    log     ${data}
    Dictionary Should Contain Key     ${data}     name
    log     ${data}[name]
    ${url}=     Get From Dictionary     ${data}     website
    log   ${url}

Add Book into Library Database
   [Tags]    API
   &{req_body}=    Create Dictionary    name=${book_name}    isbn=${isbn}    aisle=${aisle}    author=${author_name}
   ${response}=    POST      ${base_url}/Library/Addbook.php    json=${req_body}    expected_status=200
   log    ${response.json()}
   Dictionary Should Contain Key         ${response.json()}    ID
   ${book_id}=    Get From Dictionary    ${response.json()}    ID
   Set Global Variable    ${book_id}
   log    ${book_id}
   Should Be Equal As Strings    successfully added    ${response.json()}[Msg]
   Status Should Be              200                   ${response}
   
Retrieve the Book Details which got added using BookID
    [Tags]    API
    ${get_response}=    GET       ${base_url}/Library/GetBook.php    params=ID=${book_id}    expected_status=200
    log    ${get_response.json()}
    Should Be Equal As Strings    ${book_name}    ${get_response.json()}[0][book_name]

Retrieve the Book Details which got added using AuthorName
    [Tags]    API
    ${get_response}=    GET       ${base_url}/Library/GetBook.php    params=AuthorName=${author_name}    expected_status=200
    log    ${get_response.json()}
    Should Be Equal As Strings    ${isbn}    ${get_response.json()}[0][isbn]
    Should Be Equal As Strings    ${aisle}    ${get_response.json()}[0][aisle]

Delete the Book from database
        [Tags]      API
        &{delete_req}=      Create Dictionary       ID=${book_id}
        ${delete_resp}=   POST    ${base_url}/Library/DeleteBook.php      json=${delete_req}      expected_status=200
        log      ${delete_resp.json()}
        Should be Equal as Strings   book is successfully deleted    ${delete_resp.json()}[msg]
    


   
        
