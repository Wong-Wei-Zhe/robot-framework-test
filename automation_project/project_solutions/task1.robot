*** Settings ***

Library  SeleniumLibrary
Resource  common/common.robot

*** Variable ***

${account_type_loader}  dt_core_header_acc-info-preloader
${account_type_dropdown}  dt_core_account-info_acc-info
${real_acc_tab}  real_account_tab
${demo_acc_tab}  dt_core_account-switcher_demo-tab

#${acc_main_tab}  class:dc-tabs__list--header--acc-switcher__list-tabs
#${acc_switcher}  acc-switcher__id
#${acc_list_scroll_area_box}  class:dc-tabs__content dc-tabs__content--acc-switcher__list-tabs
#${acc_list_scroll_area}  .acc-switcher__accounts > div
# domelement > :nth-child(2)


*** Keyword ***

Loading Wait
    wait until page does not contain element  ${account_type_loader}  60
    wait until page contains element  ${account_type_dropdown}  60

*** Test Cases ***

Open App Deriv
    Login  ${my_email}  ${my_pw}

Real Account Landing
    Loading Wait
    Click Element  ${account_type_dropdown}
    wait until page contains element  class:acc-switcher__wrapper.acc-switcher__wrapper--enter-done  60
    Click Element  ${real_acc_tab}
    #wait until page contains element  ${acc_list_scroll_area_box}  60
    wait until page contains element  class:acc-switcher__accounts
    Execute Javascript  document.querySelector('.acc-switcher__accounts > div').scrollIntoView()
    Click Element  class:acc-switcher__accounts > div
    Loading Wait
    Click Element  ${account_type_dropdown}
    wait until page contains element  class:acc-switcher__wrapper--enter-done  60
    Click Element  ${demo_acc_tab}
    wait until page contains element  class:acc-switcher__accounts
    Execute Javascript  document.querySelector('.acc-switcher__accounts > div').scrollIntoView()
    Click Element  class:acc-switcher__accounts > div
    Loading Wait

End Test
    Close Browser





