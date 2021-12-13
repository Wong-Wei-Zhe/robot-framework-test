*** Settings ***

Library  SeleniumLibrary
Resource    loginres.robot

*** Variable ***
#${login_btn}    dt_login_button
#${email_field}  name=email
#${password_field}   //*[@type="password"]
#${login_oauth_btn}  //*[text()="Log in"]
#${my_email}     wong+1@besquare.com.my
#${my_pw}    KenTrade123

*** Keyword ***

*** Test Cases ***

Open Deriv
    Login  ${my_email}  ${my_pw}


#    Close Browser]