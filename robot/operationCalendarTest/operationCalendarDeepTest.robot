*** Settings ***
Library    SeleniumLibrary
Library    DateTime
Library    date.py





*** Variables ***

#Login data (add your login/password)
${login_value}  
${password_value}    
#_________________________________

#URL
${URL}    https://test-orto-opr.azurewebsites.net/#/login
${successful_url}   https://test-orto-opr.azurewebsites.net/#/home  
#_________________________________

#Login form inputs , button and error
${login_locator}    xpath://input[@class='v-field__input']
${password_locator}  xpath://input[@placeholder='Ievadiet paroli']
${button_login}    class:v-btn--block
 #Place where must be error 
${error_locator}    xpath://div[@role='alert']
#_________________________________


#Variables for "OPERĀCIJU KALENDĀRS"
${expected_text_operations}   OPERĀCIJU KALENDĀRS
  # Main div which must be visible after login 
${successful_div}   id:app
${operation_button}   xpath://button[@value='basic_calendar']
${navigation_line}   xpath://div[@role='tablist']   
${operation_span}      xpath://button[@value='basic_calendar']
${close_button}   xpath://i[@role='button']  
  #Calendar in left side 
${small_calendar}   xpath://div[@class='b-vbox b-box-center b-auto-container-panel b-panel-body-wrap b-sidebar-body-wrap']
${viewPerWeek}   xpath://div[@class='b-dayview-day-container b-widget-scroller b-resize-monitored b-draggable b-droppable']
${viewPerDay}   xpath://div[@class='b-dayview-event-container']
${mainDayView}   xpath://div[@componentkey='basic_calendar']
${month}   xpath://div[@class='b-widget b-container b-datepicker-title b-content-element b-auto-container b-box-item b-flex-row']
${weekButton}   xpath://button[@data-ref='weekShowButton']
${mainViewPerWeek}   xpath://div[@data-owner-cmp='b-weekview-1']
${monthButton}   xpath://button[@data-ref='monthShowButton']
${mainViewPerMonth}   xpath://div[@class='b-hbox b-box-center b-box-container-panel b-panel-body-wrap b-monthview-body-wrap']
${yearButton}   xpath://button[@data-ref='yearShowButton']
${mainYearView}   xpath://div[@class='b-hbox b-box-center b-auto-container-panel b-panel-body-wrap b-yearview-body-wrap']

#_________________________________



#Checkbox
${orto_checkbox1}   xpath://li[@data-index='1']
${orto_checkbox2}   xpath://li[@data-index='2']
${orto_checkbox3}   xpath://li[@data-index='3']
${orto}   xpath://div[@class='b-selected-icon b-icon']
#_________________________________


*** Test Cases ***
Operation calendar test
    Open Browser    ${URL}    Chrome
    Sleep    3s 
    Maximize Browser Window
    ${current_date}=    Get Current Date In Latvia
    #Authorization
    Sleep    3s 
    Input Text    ${login_locator}    ${login_value}
    Input Text    ${password_locator}    ${password_value}
    Sleep    2s    
    Click Element    ${button_login}
    Sleep    2s
    Location Should Be    ${successful_url}
    Page Should Contain Element    ${successful_div}
    Page Should Contain Element    ${operation_button}
 
# __________________________________________


# Opens the operations calendar and check if date in view per day is corect
    Click Element    ${operation_button}
    Sleep   3s
    ${actual_text}    Get Text    ${operation_span}
    Should Be Equal As Strings    ${actual_text}    ${expected_text_operations}
    Element Should Contain    ${navigation_line}    ${actual_text}
    Page Should Contain Element    ${small_calendar}
    Page Should Contain Element    ${month}
    ${actual_text}    Get Text    ${month}
    ${translated_text}=    Translate To English    ${actual_text}
    Should Be Equal As Strings    ${translated_text}    ${current_date}
    Sleep   3s
    ${dedicatedDayInCalendar}=    Get WebElement    xpath://div[contains(@class, 'b-active-date')]
    ${curentDateFromCalendar}    Get Text    ${dedicatedDayInCalendar}
    ${day_curent}=    Get Current Day
    Should Be Equal As Strings    ${curentDateFromCalendar}    ${day_curent}
    Page Should Contain Element    ${mainDayView}
    
#_________________________________



# Check "Orto" checkbox working in view per day
    #First checkbox not active
    ${operationRoom_N1}=  Get Element Count  xpath://div[text()='Operāciju zāle I']
    Click Element    ${orto_checkbox1}
    Sleep   2s
    ${operationRoom_N1}=  Get Element Count  xpath://div[text()='Operāciju zāle I']
    IF    ${operationRoom_N1}>0
      Fail  Operāciju zāle I is still visible 
    END



   #Second checkbox not active
   ${operationRoom_N2}=  Get Element Count  xpath://div[text()='Operāciju zāle II']
    Click Element    ${orto_checkbox2}
    Sleep   2s
    ${operationRoom_N2}=  Get Element Count  xpath://div[text()='Operāciju zāle II']
    IF    ${operationRoom_N2}>0
      Fail  Operāciju zāle II is still visible 
    END


   #Third checkbox not active
   ${operationRoom_N3}=  Get Element Count  xpath://div[text()='Operāciju zāle III']
    Click Element    ${orto_checkbox3}
    Sleep   2s
    ${operationRoom_N3}=  Get Element Count  xpath://div[text()='Operāciju zāle III']
    IF    ${operationRoom_N3}>0
      Fail  Operāciju zāle III is still visible 
    END


  #First checkbox is active
    Click Element    ${orto_checkbox1}
   
    Sleep   2s
    ${operationRoom_N1}=  Get Element Count  xpath://div[text()='Operāciju zāle I']
    IF    ${operationRoom_N1}==0
      Fail  Operāciju zāle I is not visible 
    END

  #Second checkbox is active
    Click Element    ${orto_checkbox2}
 
    Sleep   2s
    ${operationRoom_N2}=  Get Element Count  xpath://div[text()='Operāciju zāle II']
    IF    ${operationRoom_N2}==0
      Fail  Operāciju zāle II is not visible 
    END


  #Third checkbox is active
    Click Element    ${orto_checkbox3}
   
    Sleep   2s
    ${operationRoom_N3}=  Get Element Count  xpath://div[text()='Operāciju zāle III']
    IF    ${operationRoom_N3}==0
      Fail  Operāciju zāle II is not visible 
    END

#___________________________________





    Click Element    ${close_button}
    Sleep   3s
    Close Browser