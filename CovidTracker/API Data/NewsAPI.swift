//
//  NewsAPI.swift
//  CovidTracker
//
//  Created by Aldiyar Bekturganov on 09.12.2020.
//

import SwiftUI
import Foundation
 

 

// Declare newArticle as a global mutable variable accessible in all Swift files
var newArticle = News(id: UUID(), title: "", url: "")
var dailyArticles = [News]()
public func getDailyArticle() {
  
   
    var newArticle = News(id: UUID(), title: "", url: "")
    
    let apiKey = "ea887e27657142a0837af16a07e6d45d"
    let apiUrl = "https://newsapi.org/v2/top-headlines?country=us&q=coronavirus&apiKey=\(apiKey)"
   
 
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
        "x-api-key": apiKey,
        "accept": "application/json",
        "cache-control": "no-cache",
        "connection": "keep-alive",
        "host": "newsapi.org"
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
            if let jsonObject = jsonResponse as? [String: Any] {
                if let articlesDictionary = jsonObject["articles"] as? [Any] {
                    for article in articlesDictionary {
                        jsonDataDictionary = article as! [String: Any]
                        
                        var id = UUID(), title = "", url = ""
            
                        if let articleTitle = jsonDataDictionary["title"] as? String {
                            title = articleTitle
                        }
                        if let articleUrl = jsonDataDictionary["url"] as? String {
                            url = articleUrl
                        }
                        
                        newArticle = News(id: id, title: title, url: url)
                        dailyArticles.append(newArticle)
                        
                    }
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
 

 

