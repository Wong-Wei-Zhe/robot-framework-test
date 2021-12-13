*** Settings ***

Library  SeleniumLibrary
Resource    loginres.robot

*** Variable ***

*** Keyword ***

*** Test Cases ***

Open Deriv
    Login  ${my_email}  ${my_pw}


#    Close Browser]