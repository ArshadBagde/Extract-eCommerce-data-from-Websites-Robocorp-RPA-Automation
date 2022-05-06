*** Settings ***
Documentation     Template robot main suite.
Library           RPA.Browser.Selenium
Library           RPA.Tables
Library           DataScraper
Library           Collections

*** Variables ***
@{headers}        Name    Price    Rating    URL

*** Keywords ***
Opening Amazon Browser
    Open Available Browser    https://www.amazon.in/s?k=Mobiles&crid=4EH3MNIZJLE0&sprefix=mobiles%2Caps%2C460&ref=nb_sb_noss_1    maximized=True    alias=FirstBrowser
    Sleep    2s

DataScraping Results
    ${data}=    Get WebElements    //div[contains(@class, "s-result-item s-asin")]
    ${amazonData}    Create List
    FOR    ${element}    IN    @{data}
        Capture Element Screenshot    ${element}
        ${text}= Get result text    ${element}
        ${price}= Get Result price    ${element}
        ${url}= Get result url    ${element}
        ${rating}= Get Result rating    ${element}
        ${amazonList}=    Create List    ${text}    ${price}    ${rating}    ${url}
        Append To List    ${amazonData}    ${amazonList}
        Log    ${element}
    END

*** Tasks ***
DataScraping Demo
    Opening Amazon Browser
    ${amazonData}= DataScraping Results
    ${Amazontable}= Create Tables    ${amazonData}    columns=@{headers}
    Write table to CSV    ${Amazontable}    ${CURDIR}${/}output${/}AmazonData.csv
#Refernce:-https://www.youtube.com/watch?v=Xn1O4YzuhvE&ab_channel=RPALearners
