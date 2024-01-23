*** Settings ***
Library    SeleniumLibrary

*** Variables ***

#Login data 
${login_value}  ******
${password_value}  ********


${URL}    https://test-orto-opr.azurewebsites.net/#/login
${login_locator}    xpath://input[@class='v-field__input']
${password_locator}  xpath://input[@placeholder='Ievadiet paroli']
${button_locator}    class:v-btn--block
${error_locator}    xpath://div[@role='alert']
${expected_text}   The username field is required when email is not present. (and 2 more errors)
${successful_url}   https://test-orto-opr.azurewebsites.net/#/home  
${successful_div}   id:app
${logout_button}   xpath://i[@class='mdi-logout-variant mdi v-icon notranslate v-theme--customLightTheme v-icon--size-default']
${modal}   xpath://div[@class='v-card-actions d-flex justify-end']
${cancel-logout_button}   xpath://button[@class='v-btn v-btn--slim v-theme--customLightTheme text-green-darken-1 v-btn--density-default v-btn--size-default v-btn--variant-text']
${confirm-logout_button}   xpath://button[@class='v-btn v-btn--slim v-theme--customLightTheme text-danger v-btn--density-default v-btn--size-default v-btn--variant-text']
${login_form}   xpath://form[@class='v-form']
*** Test Cases ***
Logout test
    Open Browser    ${URL}    Chrome
    Sleep    3s 
    Maximize Browser Window
    Sleep    3s 
    Input Text    ${login_locator}    ${login_value}
    Input Text    ${password_locator}    ${password_value}
   

    Sleep    2s    
    Click Element    ${button_locator}
 
    Sleep    2s
    Location Should Be    ${successful_url}
    Page Should Contain Element    ${successful_div}
    Click Element    ${logout_button} 
    Sleep    2s

    Page Should Contain Element    ${modal} 
    # Element Should Contain    ${modal}    ${cancel-logout_button}
    # Element Should Contain    ${modal}    ${confirm-logout_button}
    Click Element    ${cancel-logout_button} 
    Page Should Contain Element    ${successful_div}
    Sleep    2s
    Click Element    ${logout_button} 
    Page Should Contain Element    ${modal} 

    Sleep    2s
    # Element Should Contain    ${modal}    ${cancel-logout_button}
    # Element Should Contain    ${modal}    ${confirm-logout_button}
    Click Element    ${confirm-logout_button} 
     Sleep    2s
    Page Should Contain Element    ${login_form}
    Sleep    2s
    Close Browser