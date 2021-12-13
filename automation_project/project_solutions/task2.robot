*** Settings ***

Library  SeleniumLibrary
Resource  common/common.robot

*** Variable ***
# REFERENCE //*[@class="cq-symbol-info"]/child::div[text()="Volatility 10 (1s) Index"]
${market_type_dropdown}  class:cq-symbol-select-btn
${dropdown_market_box}  class:sc-dialog.cq-menu-dropdown.cq-menu-dropdown-enter-done
${dropdown_market_box_searchbox}  //*[@type="text"]

*** Keyword ***

Loading Wait
    wait until page does not contain element  chart-container__loader  60
    wait until page contains element  class:ciq-menu.ciq-enabled.cq-chart-title.stx-show.cq-symbols-display  30
    wait until page contains element  class:sc-dialog.cq-menu-dropdown  30
    wait until page contains element  ${market_type_dropdown}  30

*** Test Cases ***

Open App Deriv
    Login  ${my_email}  ${my_pw}

Navigate to Volatility 10 (1s) index
    Loading Wait
    Click Element  ${market_type_dropdown}
    wait until page contains element  ${dropdown_market_box}  30
    wait until page contains element  ${dropdown_market_box_searchbox}  30
    Input Text  ${dropdown_market_box_searchbox}  Volatility 10 (1s) index
    # Ask about multiple xpath
    Click Element  //*[text()="Volatility 10 (1s) Index"]
    Loading Wait
    Click Element  id:dt_contract_dropdown
    wait until page contains element  class:contract-type-dialog.contract-type-dialog--enterDone  30
    Click Element  //*[text()="Rise/Fall"]
    Click Element  //*[contains(@class,"range-slider__ticks-step")][5]



End Test
    Close Browser
