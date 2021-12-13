*** Settings ***

Library  SeleniumLibrary
Resource  common/loginres.robot

*** Variable ***

*** Keyword ***

*** Test Cases ***

Open Deriv
    Login  ${my_email}  ${my_pw}