*** Settings ***
Library    SeleniumLibrary

*** Variables ***
#Login data (add your login/password)
${login_value}  ******
${password_value}     ********

${URL}    https://test-orto-opr.azurewebsites.net/#/login
${login_locator}    xpath://input[@class='v-field__input']
${password_locator}  xpath://input[@placeholder='Ievadiet paroli']
${button_locator}    class:v-btn--block
${error_locator}    xpath://div[@role='alert']
${successful_url}   https://test-orto-opr.azurewebsites.net/#/home  
${successful_div}   id:app

*** Test Cases ***
Login success
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
      
    
    Close Browser