//
//  CasesItem.swift
//  CovidTracker
//
//  Created by Aldiyar Bekturganov on 05.12.2020.
//

import SwiftUI

struct CasesItem: View {
    
    let state: StateStruct
    let statesDictionary = ["AL": "al", "AK": "ak", "AZ": "az", "AR": "ar", "CA": "ca", "CO": "co", "CT": "ct", "DE": "de", "FL": "fl", "GA": "ga", "HI": "hi", "ID": "id", "IL": "il", "IN": "in", "IA": "ia", "KS": "ks", "KY": "ky", "LA": "la", "ME": "me", "MD": "md", "MA": "ma", "MI": "mi", "MN": "mn", "MS": "ms", "MO": "mo", "MT": "mt", "NE": "ne", "NV": "nv", "NH": "nh", "NJ": "nj", "NM": "nm", "NY": "ny", "NC": "nc", "ND": "nd", "OH": "oh", "OK": "ok", "OR": "or", "PA": "pa", "RI": "ri", "SC": "sc", "SD": "sd", "TN": "tn", "TX": "tx", "UT": "ut", "VT": "vt", "VA": "va", "WA": "wa", "WV": "wv", "WI": "wi", "WY": "wy", "MP" : "mp", "PR": "pr", "DC" : "dc", "AS" : "as", "GU" : "gu", "VI" : "vi"]
    let statesName = [
        "AK" : "Alaska",
        "AL" : "Alabama",
        "AR" : "Arkansas",
        "AS" : "American Samoa",
        "AZ" : "Arizona",
        "CA" : "California",
        "CO" : "Colorado",
        "CT" : "Connecticut",
        "DC" : "District of Columbia",
        "DE" : "Delaware",
        "FL" : "Florida",
        "GA" : "Georgia",
        "GU" : "Guam",
        "HI" : "Hawaii",
        "IA" : "Iowa",
        "ID" : "Idaho",
        "IL" : "Illinois",
        "IN" : "Indiana",
        "KS" : "Kansas",
        "KY" : "Kentucky",
        "LA" : "Louisiana",
        "MA" : "Massachusetts",
        "MD" : "Maryland",
        "MP" : "Northern Marianas",
        "ME" : "Maine",
        "MI" : "Michigan",
        "MN" : "Minnesota",
        "MO" : "Missouri",
        "MS" : "Mississippi",
        "MT" : "Montana",
        "NC" : "North Carolina",
        "ND" : "North Dakota",
        "NE" : "Nebraska",
        "NH" : "New Hampshire",
        "NJ" : "New Jersey",
        "NM" : "New Mexico",
        "NV" : "Nevada",
        "NY" : "New York",
        "OH" : "Ohio",
        "OK" : "Oklahoma",
        "OR" : "Oregon",
        "PA" : "Pennsylvania",
        "PR" : "Puerto Rico",
        "RI" : "Rhode Island",
        "SC" : "South Carolina",
        "SD" : "South Dakota",
        "TN" : "Tennessee",
        "TX" : "Texas",
        "UT" : "Utah",
        "VA" : "Virginia",
        "VI" : "Virgin Islands",
        "VT" : "Vermont",
        "WA" : "Washington",
        "WI" : "Wisconsin",
        "WV" : "West Virginia",
        "WY" : "Wyoming"
    ]
    
    var body: some View {
        let photoName = state.state
        HStack {
            let name = statesName.index(forKey: photoName)
            let image = statesDictionary.index(forKey: photoName)
            Image((statesDictionary[image!].value))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80.0)
           
            VStack(alignment: .leading) {
                Text((statesName[name!].value))
                if state.state != allStates[3].state {
                    if state.positive == 0 {
                        Text("Total Cases: Unavailable at this moment")
                    }
                    else {
                        Text("Total Cases: \(String(state.positive))")
                    }
                    if state.recovered == 0 {
                        Text("Total Recovered: Unavailable at this moment")
                    }
                    else {
                        Text("Total Recovered: \(String(state.recovered))")
                    }
                    if state.deaths == 0 {
                        Text("Total Deaths: Unavailable at this moment")
                    }
                    else {
                        Text("Total Deaths: \(String(state.deaths))")
                    }
                }
                else {
                    Text("Total Cases: \(String(state.positive))")
                    Text("Total Recovered: \(String(state.recovered))")
                    Text("Total Deaths: \(String(state.deaths))")
                }
            }
            // Set font and size for the whole VStack content
            .font(.system(size: 14))//, design: .monospaced))
        }
        
    }
}

/*
struct CasesItem_Previews: PreviewProvider {
    static var previews: some View {
        CasesItem()
    }
}
 */
