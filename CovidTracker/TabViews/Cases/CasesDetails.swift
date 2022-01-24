//
//  CasesDetails.swift
//  CovidTracker
//
//  Created by Aldiyar Bekturganov on 05.12.2020.
//

import SwiftUI

struct CasesDetails: View {

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
    let state: StateStruct
    var body: some View {
        
        let photoName = state.state
        let name = statesName.index(forKey: photoName)
        let image = statesDictionary.index(forKey: photoName)
        Form {
            Section(header: Text("State Name")) {
                Text((statesName[name!].value))
            }
            Section(header: Text("State Flag")) {
                Image((statesDictionary[image!].value))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
            }
            Section(header: Text("Total Confirmed Cases")) {
                if state.state != allStates[3].state {
                    if state.positive == 0 {
                        Text("Unavailable at this moment")
                    }
                    else {
                        Text(String(state.positive))
                    }
                }
            }
            
            Section(header: Text("Total Negative Tests")) {
                if state.state != allStates[3].state {
                    if state.negative == 0 {
                        Text("Unavailable at this moment")
                    }
                    else {
                        Text(String(state.negative))
                    }
                }
            }
            Section(header: Text("Total Recovered Patients")) {
                if state.state != allStates[3].state {
                    if state.recovered == 0 {
                        Text("Unavailable at this moment")
                    }
                    else {
                        Text(String(state.recovered))
                    }
                }
            }
            Section(header: Text("Total Deaths")) {
                if state.state != allStates[3].state {
                    if state.deaths == 0 {
                        Text("Unavailable at this moment")
                    }
                    else {
                        Text(String(state.deaths))
                    }
                }
            }
            Section(header: Text("Total Hospitalized Patients")) {
                if state.state != allStates[3].state {
                    if state.hospitalized == 0 {
                        Text("Unavailable at this moment")
                    }
                    else {
                        Text(String(state.hospitalized))
                    }
                }
            }
        }
        .navigationBarTitle(Text((statesName[name!].value)), displayMode: .inline)
    }
}

struct CasesDetails_Previews: PreviewProvider {
    static var previews: some View {
        CasesDetails(state: allStates.first!)
    }
}
