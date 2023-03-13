*** Settings ***
Library  RequestsLibrary
Library  String

***Variables***
${URL_artist}      https://api.spotify.com/v1/albums/4aawyAB9vmqN3uQ7FjRGTy
${URL}             https://www.spotify.com/CZ
${Client_ID}       521ca683e79749a1ae636cbfac5139fa
${Client_Secret}   d40ce2b670e94b86a11a25dbc8966f4e
${Auth_token}      BQC_IwuPheFcZI-w3IcA1_x0iOpiJTdaoe3wAR7LgJxUsK1jIs4HTIK_zL5CaPmtmA883NU-Crfu8Ph7rV5Nf8XxSdUtYgdWVeGBzEftMGb7h6Igur75G3O8fGbxpkJr6P9UlIdhTcw24rPTfdfPs_VS7WPhxeCrBU7Clc2F26W0gHGxLoDSMC_a6INOUSHOAD7_44Tej5P2fGXrreVInPIANiYAO1cqFd8y5mHcstG_HWsTPYMs0hKCj3pu-SG0lnYiRM4C3SKyQMw9Xk-CPgXyau75ze5_G4UTdTJ67OgqENv8yDbuUuYW57NF5MvhQqq0zm0b8UtJLg
${id}              4aawyAB9vmqN3uQ7FjRGTy
${Authorize}       https://accounts.spotify.com/authorize
***Test cases***
Quick Get A JSON Body Test
   ${response}=    GET  https://jsonplaceholder.typicode.com/posts/1
   log to console  ${response.json()}[id]
   log to console  CONTENT: ${response.content}
   log to console  JSON: "${response.json()}"
   log to console  TEXT: "${response.text}"
   log to console  OK: "${response.ok}"
   log to console  REASON: "${response.reason}"
   Should Be Equal As Strings    1  ${response.json()}[id]