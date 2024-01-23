*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    https://test-orto-opr.azurewebsites.net/#/login
${login_locator}    xpath://input[@class='v-field__input']
${login_value}  sdfewfwef
${password_locator}  xpath://input[@placeholder='Ievadiet paroli']
${password_value}    sdsfwef
${button_locator}    class:v-btn--block
${error_locator}    xpath://div[@role='alert']
${expected_text}   not found
*** Test Cases ***
Must be error "Not found"
    Open Browser    ${URL}    Chrome
    Sleep    3s 
    Maximize Browser Window
    Sleep    3s 
    Input Text    ${login_locator}    ${login_value}
    Input Text    ${password_locator}    ${password_value}
   
    Sleep    2s    
    Click Element    ${button_locator}
    Sleep    2s
    Page Should Contain Element    ${error_locator}
    ${actual_text}    Get Text    ${error_locator}
    Should Be Equal As Strings    ${actual_text}    ${expected_text}


    
    
    Close Browser