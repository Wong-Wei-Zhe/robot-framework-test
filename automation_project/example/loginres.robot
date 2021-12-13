*** Settings ***
Library  SeleniumLibrary

*** Variable ***
${login_btn}    dt_login_button
${email_field}  name=email
${password_field}   //*[@type="password"]
${login_oauth_btn}  //*[text()="Log in"]

*** Keywords ***
Login
    [arguments]  ${email}  ${pw}
    Open Browser  url=https://app.deriv.com/  browser=chrome
    Set Window Size  1280  1280
    wait until page does not contain element  dt_core_header_acc-info-preloader  60
    wait until page contains element  ${login_btn}  60
    Click Element  ${login_btn}
    wait until page contains element  ${email_field}  15
    Input Text  ${email_field}  ${email}
    Input Text  ${password_field}  ${pw}
    Click Element  ${login_oauth_btn}