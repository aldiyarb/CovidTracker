//
//  TestCentersAPI.swift
//  CovidTracker
//
//  Created by Aldiyar Bekturganov on 06.12.2020.
//

import SwiftUI
import Foundation
 
// Declare testCenterFound as a global mutable variable accessible in all Swift files
var testCenterFound = TestCenter(id: UUID(), name: "", address: "", city: "", state: "", lat: "", lon: 0.0, url: "", phone: "")
var testCenters = [TestCenter]()
let stateDictionary = [
    "Alaska" : "AK",
    "Alabama" : "AL",
    "Arkansas" : "AR",
    "American Samoa" : "AS",
    "Arizona" : "AZ",
    "California" : "CA",
    "Colorado" : "CO",
    "Connecticut" : "CT",
    "District of Columbia" : "DC",
    "Delaware" : "DE",
    "Florida" : "FL",
    "Georgia" : "GA",
    "Guam" : "GU",
    "Hawaii" : "HI",
    "Iowa" : "IA",
    "Idaho" : "ID",
    "Illinois" : "IL",
    "Indiana" : "IN",
    "Kansas" : "KS",
    "Kentucky" : "KY",
    "Louisiana" : "LA",
    "Massachusetts" : "MA",
    "Maryland" : "MD",
    "Maine" : "ME",
    "Michigan" : "MI",
    "Minnesota" : "MN",
    "Missouri" : "MO",
    "Mississippi" : "MS",
    "Montana" : "MT",
    "North Carolina" : "NC",
    "North Dakota" : "ND",
    "Nebraska" : "NE",
    "New Hampshire" : "NH",
    "New Jersey" : "NJ",
    "New Mexico" : "NM",
    "Nevada" : "NV",
    "New York" : "NY",
    "Ohio" : "OH",
    "Oklahoma" : "OK",
    "Oregon" : "OR",
    "Pennsylvania" : "PA",
    "Puerto Rico" : "PR",
    "Rhode Island" : "RI",
    "South Carolina" : "SC",
    "South Dakota" : "SD",
    "Tennessee" : "TN",
    "Texas" : "TX",
    "Utah" : "UT",
    "Virginia" : "VA",
    "Virgin Islands" : "VI",
    "Vermont" : "VT",
    "Washington" : "WA",
    "Wisconsin" : "WI",
    "West Virginia" : "WV",
    "Wyoming" : "WY"
  ]
fileprivate var previousQuery = ""

public func getTestCentersData(query: String) {
  
    
    if query == previousQuery {
        return
    } else {
        previousQuery = query
    }
    let stateName = stateDictionary.index(forKey: query)
    /*
     Create an empty instance of testCenter struct defined in TestCenterStruct.swift
     */
    testCenterFound = TestCenter(id: UUID(), name: "", address: "", city: "", state: "", lat: "", lon: 0.0, url: "", phone: "")
    
    let apiUrl = "https://sheetlabs.com/NCOR/covidtestcentersinUS?state=\((stateDictionary[stateName!].value))"
    
   
    /*
    *********************************************
    *   Obtaining API Search Query URL Struct   *
    *********************************************
    */
  
    var apiQueryUrlStruct: URL?
  
     if let urlStruct = URL(string: apiUrl) {
         apiQueryUrlStruct = urlStruct
     } else {
         return
     }
  
    /*
    *******************************
    *   HTTP GET Request Set Up   *
    *******************************
    */
 
    let headers = [
        "accept": "application/json",
        "cache-control": "no-cache",
        "connection": "keep-alive",
        "host": "sheetlabs.com"
    ]
  
    let request = NSMutableURLRequest(url: apiQueryUrlStruct!,
                                      cachePolicy: .useProtocolCachePolicy,
                                      timeoutInterval: 10.0)
  
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers
  
    /*
    *********************************************************************
    *  Setting Up a URL Session to Fetch the JSON File from the API     *
    *  in an Asynchronous Manner and Processing the Received JSON File  *
    *********************************************************************
    */
  
    /*
     Create a semaphore to control getting and processing API data.
     signal() -> Int    Signals (increments) a semaphore.
     wait()             Waits for, or decrements, a semaphore.
     */
    let semaphore = DispatchSemaphore(value: 0)
  
    URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
        /*
        URLSession is established and the JSON file from the API is set to be fetched
        in an asynchronous manner. After the file is fetched, data, response, error
        are returned as the input parameter values of this Completion Handler Closure.
        */
      
        // Process input parameter 'error'
        guard error == nil else {
            semaphore.signal()
            return
        }
      
        // Process input parameter 'response'. HTTP response status codes from 200 to 299 indicate success.
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            semaphore.signal()
            return
        }
      
        // Process input parameter 'data'. Unwrap Optional 'data' if it has a value.
        guard let jsonDataFromApi = data else {
            semaphore.signal()
            return
        }
 
        //------------------------------------------------
        // JSON data is obtained from the API. Process it.
        //------------------------------------------------
        do {
            /*
            Foundation framework’s JSONSerialization class is used to convert JSON data
            into Swift data types such as Dictionary, Array, String, Number, or Bool.
            */
            let jsonResponse = try JSONSerialization.jsonObject(with: jsonDataFromApi,
                              options: JSONSerialization.ReadingOptions.mutableContainers)
 
            /*
             JSON object with Attribute-Value pairs corresponds to Swift Dictionary type with
             Key-Value pairs. Therefore, we use a Dictionary to represent a JSON object
             where Dictionary Key type is String and Value type is Any (instance of any type)
             */
            var jsonDataDictionary = Dictionary<String, Any>()
           
            if let jsonObject = jsonResponse as? [Any] {
                for center in jsonObject {
                    jsonDataDictionary = center as! [String: Any]
                    
                    var id = UUID(), name = "", address = "", city = "", lat = "", lon = 0.0, url = "", phone = "", state = ""
        
        
                    if let centerName = jsonDataDictionary["centername"] as? String {
                        name = centerName
                    }
                    if let centerAddress = jsonDataDictionary["address"] as? String {
                        address = centerAddress
                    }
                    if let centerCity = jsonDataDictionary["city"] as? String {
                        city = centerCity
                    }
                    if let centerState = jsonDataDictionary["state"] as? String {
                        state = centerState
                    }
                    if let centerLat = jsonDataDictionary["lat"] as? String {
                        lat = centerLat
                    }
                    if let centerLon = jsonDataDictionary["lon"] as? Double {
                        lon = centerLon
                    }
                    if let centerUrl = jsonDataDictionary["url"] as? String {
                        url = centerUrl
                    }
                    if let centerPhone = jsonDataDictionary["telephone"] as? String {
                        phone = centerPhone
                    }
                    
                    testCenterFound = TestCenter(id: id, name: name, address: address, city: city, state: state, lat: lat, lon: lon, url: url, phone: phone)
                    testCenters.append(testCenterFound)
                }
            } else {
                semaphore.signal()
                return
            }
              
        } catch {
            semaphore.signal()
            return
        }
      
        semaphore.signal()
    }).resume()
  
    /*
     The URLSession task above is set up. It begins in a suspended state.
     The resume() method starts processing the task in an execution thread.
   
     The semaphore.wait blocks the execution thread and starts waiting.
     Upon completion of the task, the Completion Handler code is executed.
     The waiting ends when .signal() fires or timeout period of 60 seconds expires.
    */
 
    _ = semaphore.wait(timeout: .now() + 60)
}
