//
//  TestCenterStruct.swift
//  CovidTracker
//
//  Created by Aldiyar Bekturganov on 06.12.2020.
//

import SwiftUI

public struct TestCenter: Hashable, Codable, Identifiable {
    public var id: UUID
    public var name: String
    public var address: String
    public var city: String
    public var state: String
    public var lat: String
    public var lon: Double
    public var url: String
    public var phone: String
    
    /*
     {
             "lastupdateddate": "3/18/2020",
             "centername": "Collaborative Effort of Health Care Providers",
             "address": "4115 Lake Otis Pkwy., Anchorage, Alaska 99508",
             "city": "Anchorage",
             "state": "AK",
             "lat": "61.1828699",
             "lon": -149.837269,
             "url": "https://www.adn.com/alaska-news/anchorage/2020/03/17/anchorage-drive-thru-coronavirus-testing-site-now-open/",
             "telephone": null,
             "moreinfo": "The site is a collaborative effort between Providence Alaska Medical Center, Alaska Native Medical Center, Alaska Regional Hospital and Anchorage Neighborhood Health Center.",
             "drivethru": "O"
         }
     */
}
