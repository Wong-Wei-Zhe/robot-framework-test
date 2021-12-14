*** Settings ***

Library  SeleniumLibrary
Resource  common/common.robot

*** Variable ***
# REFERENCE //*[@class="cq-symbol-info"]/child::div[text()="Volatility 10 (1s) Index"]
${market_type_dropdown}  //*[@class="cq-symbol-select-btn"]
${dropdown_market_box}  class:sc-dialog.cq-menu-dropdown.cq-menu-dropdown-enter-done
${dropdown_market_box_searchbox}  //*[@type="text"]
${money_value_input}  //input[@id="dt_amount_input"]
${date_value_input}  //input[@name="duration"]

*** Keyword ***

Loading Wait
    wait until page does not contain element  chart-container__loader  60
    wait until page contains element  //div[@class="ciq-menu ciq-enabled cq-chart-title stx-show cq-symbols-display"]  60
    #wait until page contains element  class:sc-dialog.cq-menu-dropdown  60
    wait until page contains element  //div[@class="chartContainer"]
    wait until page contains element  ${market_type_dropdown}  60
    wait until page does not contain element  //*[text()="Loading interface..."]
    wait until page does not contain element  //div[@class="btn-purchase__shadow-wrapper btn-purchase__shadow-wrapper--disabled"]
    sleep  1  #WILL FAIL IF WEBSITE TAKES TOO LONG TO LOAD CHART
    #set browser implicit wait  10

Underlying Switch
    [arguments]  ${underlying}
    Loading Wait
    Click Element  ${market_type_dropdown}
    wait until page contains element  ${dropdown_market_box}  60
    wait until page contains element  ${dropdown_market_box_searchbox}  60
    Input Text  ${dropdown_market_box_searchbox}  ${underlying}
    # Ask about multiple xpath
    Click Element  //*[text()="${underlying}"]
    Loading Wait

Trade Type Switch
    [arguments]  ${trade_type}
    wait until page contains element  //div[@id="dt_contract_dropdown"]
    Click Element  //div[@id="dt_contract_dropdown"]
    wait until page contains element  class:contract-type-dialog.contract-type-dialog--enterDone  30
    Click Element  //*[text()="${trade_type}"]

Purchase Contract Type
    [arguments]  ${contract_type}
    Click Element  //button[@id="${contract_type}"]
    sleep  5

*** Test Cases ***

Open App Deriv
    Login  ${my_email}  ${my_pw}

Switch to Demo Account
    Switch to Demo Account

Navigate
    Underlying Switch  AUD/USD
    Trade Type Switch  Higher/Lower
    Click Element  //*[@class="dc-button-menu__wrapper"]/child::button[@id="dc_payout_toggle_item"]
    press keys  ${date_value_input}  CONTROL+A  BACKSPACE
    press keys  ${date_value_input}  2
    press keys  ${money_value_input}  CONTROL+A  BACKSPACE
    Input Text  ${money_value_input}  15.5
    wait until page does not contain element  //button[@class="btn-purchase btn-purchase--disabled btn-purchase--animated--fade btn-purchase--1"]
    Purchase Contract Type  dt_purchase_put_button


End Test
    Close Browser

