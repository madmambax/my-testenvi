"""
Build what’s next. Better software. Faster.
Use Google's core infrastructure, data analytics, and machine learning

Protect your data and apps with the same security technology Google uses

Avoid vendor lock-in and run your apps on open source solution
Dream, build, and transform with Google Cloud
Google Cloud documentation
Find guides, code samples, architectural diagrams, best practices, tutorials, API references,
and more to learn how to build on Google Cloud.

http://maps.googleapis.com/
"""





*** Settings ***
Library     RequestsLibrary
Library     Collections

*** Variables ***
${base_url}         http://maps.googleapis.com/
${req_uri}          maps/api/place/nearbysearch/json?
${API_Key}          AIzaSyCOegSa5kJ-E2X87DzecgJKpBYPIDBnpsA

#

*** Test Cases ***
GoogleMap

    GoogleMap       38.788435273660106,20.613207921196267        100     food        Taverna     ${API_Key}

*** Keywords ***


GoogleMap

    [Arguments]         ${locat}   ${radiu}   ${type}   ${nam}   ${API_Key}
    Create Session      googlemaps          ${base_url}        verify=true
    ${params}           Catenate       {"Location"="${locat}","radius"="${radiu}","types"="${type}","name"´="${nam}","key"="${API_Key}"}
    ${response}=        GET On Session          googlemaps         ${req_uri}      params=${params}

    Log To Console      ${response.status_code}
    Log To Console      ${response.content}



*** Comments ***
#odloženo
https://maps.googleapis.com/maps/api/place/nearbysearch/json
?location=38.788435273660106, 20.613207921196267
&radius=500
&types=food
&name= harbor
&key=YOUR_API_KEY

https://maps.googleapis.com/maps/api/...

  ?location=-33.8670522,151.1957362
  &radius=500
  &types=food
  &name=harbour
  &key=YOUR_API_KEY

    Create Session      googlemaps              ${base_url}        verify=true
    ${params}           Catenate       Location=38.788435273660106,20.613207921196267  radius=100  types=food  name=Taverna  key=AIzaSyCOegSa5kJ-E2X87DzecgJKpBYPIDBnpsA
    ${response}=        GET On Session          googlemaps         ${req_uri}      params=${params}

    Log To Console      ${response.status_code}
    Log To Console      ${response.content}