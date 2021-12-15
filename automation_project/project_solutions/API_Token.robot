*** Settings ***

Library  SeleniumLibrary
Resource  common/common.robot

*** Variable ***
#Data
${BADINPUTLESS}  A
${BADINPUTMORE}  AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
${GOODINPUT} AA  AAA  AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA  AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA


${url}  https://app.deriv.com/account/api-token

${scope_checkbox_container}  //div[@class="da-api-token__checkbox-wrapper"]
${token_input_field}  //input[@name="token_name"]
${tokenlist_first}  //tr[@class="da-api-token__table-cell-row"][1]
${token_create_btn}  //span[text()="Create"]/parent::button[@type="submit"]
#//div[@class="da-api-token__checkbox-wrapper"]/child::div[1]/descendant::span[@class="dc-text dc-checkbox__label"]
#//button[@type="submit"]/child::span[text()="Create"]
*** Keyword ***

Reload
    reload page
    wait until page contains element  ${scope_checkbox_container}  60

Perform Check Box
    [arguments]  ${check_box}
    click element  ${check_box}  #/descendant::input[@class="dc-checkbox__input"]

Create Test Token
    input text  ${token_input_field}  test
    click element  ${token_create_btn}
    wait until page contains element  ${tokenlist_first}  60

Verify Scope Items
    [arguments]  ${scope_items}
    page should contain element  ${tokenlist_first}/descendant::span[text()="${scope_items}"]
    sleep  1

Delete Token
    page should contain element  ${tokenlist_first}/descendant::button
    click element  ${tokenlist_first}/descendant::button
    sleep  1
    click element  ${tokenlist_first}/descendant::button/child::span[text()="Yes"]/parent::button
    wait until page does not contain element  ${tokenlist_first}
    page should not contain element  ${tokenlist_first}

Check Box and Create Verify
    [arguments]  ${index}
    Perform Check Box  ${scope_checkbox_container}/child::div[${index}]
    sleep  1
    Create Test Token
    ${scope_text}=  get text  ${scope_checkbox_container}/child::div[${index}]/descendant::span[@class="dc-text dc-checkbox__label"]
    Verify Scope Items  ${scope_text}
    Delete Token

Error Message Check
    [arguments]  ${errmsg}
    page should contain element  //*[text()="${errmsg}"]
    sleep  1

Clear Token Name Field
    press keys  ${token_input_field}  CONTROL+A  BACKSPACE

*** Test Cases ***

Open Token API Deriv
    Login Direct  ${my_email}  ${my_pw}  ${url}

Test Individual Token Creation
    wait until page contains element  ${scope_checkbox_container}  60
    ${index}=  Set Variable  1
    FOR  ${i}  IN RANGE  5
         Check Box and Create Verify  ${index}
         ${index}=  Evaluate  ${index} + 1
    END

Test All Scope Token Creation
    Reload
    ${index}=  Set Variable  1
    FOR  ${i}  IN RANGE  5
         Perform Check Box  ${scope_checkbox_container}/child::div[${index}]
         ${index}=  Evaluate  ${index} + 1
    END
    Create Test Token
    Verify Scope Items  All
    Delete Token

Test Create Must Have One Scope Selected
    Reload
    input text  ${token_input_field}  test
    element should be disabled  ${token_create_btn}

Test Token Name Input
    Reload
    Perform Check Box  ${scope_checkbox_container}/child::div[1]

    input text  ${token_input_field}  ${BADINPUTLESS}
         error message check  Length of token name must be between 2 and 32 characters.

    Clear Token Name Field

    input text  ${token_input_field}  ${BADINPUTMORE}
         error message check  Maximum 32 characters.

    Clear Token Name Field


End Test
    Close Browser
