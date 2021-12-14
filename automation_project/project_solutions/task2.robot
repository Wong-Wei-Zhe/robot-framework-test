*** Settings ***

Library  SeleniumLibrary
Resource  common/common.robot

*** Variable ***
# REFERENCE //*[@class="cq-symbol-info"]/child::div[text()="Volatility 10 (1s) Index"]
${market_type_dropdown}  //*[@class="cq-symbol-select-btn"]
${dropdown_market_box}  class:sc-dialog.cq-menu-dropdown.cq-menu-dropdown-enter-done
${dropdown_market_box_searchbox}  //*[@type="text"]
${money_value_input}  //input[@id="dt_amount_input"]

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

*** Test Cases ***

Open App Deriv
    Login  ${my_email}  ${my_pw}

Switch to Demo Account
    Switch to Demo Account

Navigate to Volatility 10 (1s) index
    Loading Wait
    Click Element  ${market_type_dropdown}
    wait until page contains element  ${dropdown_market_box}  60
    wait until page contains element  ${dropdown_market_box_searchbox}  60
    Input Text  ${dropdown_market_box_searchbox}  Volatility 10 (1s) index
    # Ask about multiple xpath
    Click Element  //*[text()="Volatility 10 (1s) Index"]
    Loading Wait
    wait until page contains element  //div[@id="dt_contract_dropdown"]
    Click Element  //div[@id="dt_contract_dropdown"]
    wait until page contains element  class:contract-type-dialog.contract-type-dialog--enterDone  30
    Click Element  //*[text()="Rise/Fall"]
    Click Element  //*[contains(@class,"range-slider__ticks-step")][4]
    Click Element  //*[contains(@class,"range-slider__ticks-step")][5]
    Click Element  //*[@class="dc-button-menu__wrapper"]/child::button[@id="dc_stake_toggle_item"]
    #Clear Element Text  //input[@id="dt_amount_input"]
    #Click Element  //input[@id="dt_amount_input"]
    press keys  ${money_value_input}  CONTROL+A  BACKSPACE
    Input Text  ${money_value_input}  10
    wait until page does not contain element  //button[@class="btn-purchase btn-purchase--disabled btn-purchase--animated--fade btn-purchase--1"]
    Click Element  //button[@id="dt_purchase_call_button"]
    sleep  5


End Test
    Close Browser
