*** Settings ***

Library  SeleniumLibrary

*** Variable ***
#Login
${login_btn}    dt_login_button
${email_field}  name=email
${password_field}   //*[@type="password"]
${login_oauth_btn}  //*[text()="Log in"]
#Accoun Switching
${account_type_loader}  dt_core_header_acc-info-preloader
${account_type_dropdown}  dt_core_account-info_acc-info
${demo_acc_tab}  dt_core_account-switcher_demo-tab

*** Keywords ***

Switch Account Loading Wait
    wait until page does not contain element  ${account_type_loader}  60
    wait until page contains element  ${account_type_dropdown}  60

Login
    [arguments]  ${email}  ${pw}  ${url}
    Open Browser  url=${url}  browser=chrome
    Set Window Size  1280  1280
    wait until page does not contain element  dt_core_header_acc-info-preloader  60
    wait until page contains element  ${login_btn}  60
    Click Element  ${login_btn}
    wait until page contains element  ${email_field}  15
    Input Text  ${email_field}  ${email}
    Input Text  ${password_field}  ${pw}
    Click Element  ${login_oauth_btn}

Login Direct
    [arguments]  ${email}  ${pw}  ${url}
    Open Browser  url=${url}  browser=chrome
    Set Window Size  1280  1280
    wait until page contains element  ${email_field}  15
    Input Text  ${email_field}  ${email}
    Input Text  ${password_field}  ${pw}
    Click Element  ${login_oauth_btn}

Switch to Demo Account
    Switch Account Loading Wait
    Click Element  ${account_type_dropdown}
    wait until page contains element  class:acc-switcher__wrapper--enter-done  60
    Click Element  ${demo_acc_tab}
    wait until page contains element  class:acc-switcher__accounts
    Execute Javascript  document.querySelector('.acc-switcher__accounts > div').scrollIntoView()
    Click Element  class:acc-switcher__accounts > div
    Switch Account Loading Wait