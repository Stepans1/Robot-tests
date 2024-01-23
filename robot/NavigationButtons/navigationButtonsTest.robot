*** Settings ***
Library    SeleniumLibrary

*** Variables ***

#Login data
${login_value}  *****
${password_value}  *******


${URL}    https://test-orto-opr.azurewebsites.net/#/login
${login_locator}    xpath://input[@class='v-field__input']
${password_locator}  xpath://input[@placeholder='Ievadiet paroli']
${button_locator}    class:v-btn--block
${error_locator}    xpath://div[@role='alert']
${expected_text_operations}   OPERĀCIJU KALENDĀRS
${expected_text_ward}   PALĀTU KALENDĀRS
${expected_text_operationList}   VISAS OPERĀCIJAS
${expected_text_dayReport}   OPERĀCIJU SARAKSTS
${successful_url}   https://test-orto-opr.azurewebsites.net/#/home  
${successful_div}   id:app
${operation_button}   xpath://button[@value='basic_calendar']
${ward_button}   xpath://button[@value='ward']
${operation-list_button}   xpath://button[@value='operation-list']
${day-report_button}   xpath://button[@value='day-report']
${account_button}   xpath://button[@aria-haspopup='menu']
${navigation_line}   xpath://div[@role='tablist']   
${operation_span}      xpath://button[@value='basic_calendar']
${close_button}   xpath://i[@role='button']  
${ward_span}      xpath://button[@value='ward']
${ward_list}   xpath://div[@role='presentation']
${operationList_button}   xpath://button[@value='operation-list']
${operationList_span}      xpath://button[@value='operation-list']
${operationList_div}      xpath://div[@class='container-fluid ms-5 my-5']
${day-report_button}      xpath://button[@value='day-report']    
${day-report_list}      xpath://div[@class='v-table__wrapper'] 
*** Test Cases ***
Navigation buttons test 
    Open Browser    ${URL}    Chrome
    Sleep    3s 
    Maximize Browser Window

    #Authorization
    Sleep    3s 
    Input Text    ${login_locator}    ${login_value}
    Input Text    ${password_locator}    ${password_value}
    Sleep    2s    
    Click Element    ${button_locator}
    Sleep    2s

    #Check if main page exists 
    Location Should Be    ${successful_url}
    Page Should Contain Element    ${successful_div}
    Page Should Contain Element    ${operation_button}
    Page Should Contain Element    ${ward_button}
    Page Should Contain Element    ${operation-list_button}
    Page Should Contain Element    ${day-report_button}
    Page Should Contain Element    ${operation-list_button}
    Page Should Contain Element    ${account_button}

    #Opens the operations calendar and checks whether a tab with text appears(OPERĀCIJU KALENDĀRS) 
    # Also check the ability to close the tab
    Click Element    ${operation_button}
    Sleep   3s
    ${actual_text}    Get Text    ${operation_span}
    Should Be Equal As Strings    ${actual_text}    ${expected_text_operations}
    Element Should Contain    ${navigation_line}    ${actual_text}
    Click Element    ${close_button}
    Sleep   3s
   



    #Opens ward calendar and checks if the  text tab(PALĀTU KALENDĀRS) and ward list appears
    # Also check the ability to close the tab 
    Click Element    ${ward_button}
    Sleep   3s
    ${actual_text}    Get Text    ${ward_span}
    Should Be Equal As Strings    ${actual_text}    ${expected_text_ward}
    Element Should Contain    ${navigation_line}    ${actual_text}
    Page Should Contain Element    ${ward_list}
    Click Element    ${close_button}
    Sleep   3s


   
    
    #Opens all operations  and checks if the  text tab(VISAS OPERĀCIJAS) and operations list appears
    # Also check the ability to close the tab  
    Click Element    ${operationList_span}
    Sleep   3s
    ${actual_text}    Get Text    ${operationList_button}
    Should Be Equal As Strings    ${actual_text}    ${expected_text_operationList}
    Element Should Contain    ${navigation_line}    ${actual_text}
    Page Should Contain Element    ${operationList_div}
    Click Element    ${close_button}
    Sleep   3s

    #Opens  operations list and checks if the  text tab(OPERĀCIJU SARAKSTS) and operations list appears
    # Also check the ability to close the tab  
    Click Element    ${day-report_button}
    Sleep   3s
    ${actual_text}    Get Text    ${day-report_button}
    Should Be Equal As Strings    ${actual_text}    ${expected_text_dayReport}
    Element Should Contain    ${navigation_line}    ${actual_text}
    Page Should Contain Element    ${day-report_list}
    Click Element    ${close_button}
    Sleep   3s


    Close Browser