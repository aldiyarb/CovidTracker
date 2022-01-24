//
//  SearchByState.swift
//  CovidTracker
//
//  Created by Aldiyar Bekturganov on 07.12.2020.
//

import SwiftUI
import Foundation

struct SearchByState: View {
    let states =
                    ["Alaska",
                      "Alabama",
                      "Arkansas",
                      "American Samoa",
                      "Arizona",
                      "California",
                      "Colorado",
                      "Connecticut",
                      "District of Columbia",
                      "Delaware",
                      "Florida",
                      "Georgia",
                      "Guam",
                      "Hawaii",
                      "Iowa",
                      "Idaho",
                      "Illinois",
                      "Indiana",
                      "Kansas",
                      "Kentucky",
                      "Louisiana",
                      "Massachusetts",
                      "Maryland",
                      "Maine",
                      "Michigan",
                      "Minnesota",
                      "Missouri",
                      "Mississippi",
                      "Montana",
                      "North Carolina",
                      " North Dakota",
                      "Nebraska",
                      "New Hampshire",
                      "New Jersey",
                      "New Mexico",
                      "Nevada",
                      "New York",
                      "Ohio",
                      "Oklahoma",
                      "Oregon",
                      "Pennsylvania",
                      "Puerto Rico",
                      "Rhode Island",
                      "South Carolina",
                      "South Dakota",
                      "Tennessee",
                      "Texas",
                      "Utah",
                      "Virginia",
                      "Virgin Islands",
                      "Vermont",
                      "Washington",
                      "Wisconsin",
                      "West Virginia",
                      "Wyoming"]
    
   
    @State private var searchFieldValue = ""
    @State private var showMissingInputDataAlert = false
    @State private var searchCompleted = false
    @State private var selectedIndex = 0

    
    var body: some View {
        NavigationView {
            ZStack {
                Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)
            Form {
                Section() {
                Image("Check")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
                }
                Section(header: Text("Select the State")) {
                    Picker("Selected State", selection: $selectedIndex) {
                        ForEach(0 ..< states.count, id: \.self) {
                            Text(self.states[$0])
                        }
                    }
                    .frame(minWidth: 300, maxWidth: 500, alignment: .center)
                }
               
                Section(header: Text("Search Test Centers")) {
                    HStack {
                        Button(action: {
                            self.searchApi()
                            self.searchCompleted = true
                            
                        }) {
                            Text(self.searchCompleted ? "Search Completed" : "Search")
                        }
                        .frame(width: 240, height: 36, alignment: .center)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .strokeBorder(Color.black, lineWidth: 1)
                        )
                        if self.searchCompleted {
                            Button(action: {
                                self.showMissingInputDataAlert = false
                                self.searchCompleted = false
                                testCenters.removeAll()
                            }) {
                                Text("Clear")
                            }
                            .frame(width: 100, height: 36, alignment: .center)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .strokeBorder(Color.black, lineWidth: 1)
                            )
                        }
                    }   // End of HStack
                }
               
                if searchCompleted {
                    Section(header: Text("Show Test Centers Found")) {
                        NavigationLink(destination: showSearchResults) {
                            HStack {
                                Image(systemName: "list.bullet")
                                    .imageScale(.medium)
                                    .font(Font.title.weight(.regular))
                                    .foregroundColor(.blue)
                                Text("Show Test Centers Found")
                                    .font(.system(size: 16))
                            }
                        }
                        .frame(minWidth: 300, maxWidth: 500)
                    }
                }
               
            }   // End of Form
            
                .navigationBarTitle(Text("Search Test Centers"), displayMode: .inline)
            }   // End of ZStack
            
        }   // End of NavigationView
            .customNavigationViewStyle()  // Given in
            
       
    }   // End of body
   
    /*
     ------------------
     MARK: - Search API
     ------------------
     */
    func searchApi() {
        getTestCentersData(query: states[selectedIndex])
       
    }
   
    /*
     ---------------------------
     MARK: - Show Search Results
     ---------------------------
     */
    var showSearchResults: some View {
       
        // Global variable countryFound is given in CountryApiData.swift
        if testCenters.isEmpty {
            return AnyView(notFoundMessage)
        }
       
        return AnyView(TestCentersList())
    }
   
    /*
     ---------------------------------
     MARK: - No Test Centers
     ---------------------------------
     */
    var notFoundMessage: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .imageScale(.large)
                .font(Font.title.weight(.medium))
                .foregroundColor(.red)
                .padding()
            Text("No Test Centers Found In The Selected State")
                .fixedSize(horizontal: false, vertical: true)   // Allow lines to wrap around
                .multilineTextAlignment(.center)
                .padding()
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(Color(red: 1.0, green: 1.0, blue: 240/255))     // Ivory color
    }
   
}
