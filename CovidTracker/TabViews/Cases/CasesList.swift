//
//  CasesList.swift
//  CovidTracker
//
//  Created by Aldiyar Bekturganov on 05.12.2020.
//

import SwiftUI
 
struct CasesList: View {
    @State private var searchItem = ""
    let state: StateStruct
    var body: some View {
        NavigationView {
            VStack {
                let dateString = String(state.date)
                let year = String(dateString.dropLast(4))
                let daymonth = String(dateString.dropFirst(4))
                let day = String(daymonth.dropFirst(2))
                let month = String(daymonth.dropLast(2))

                Divider()
                Text("Last Updated: \(month)/\(day)/\(year)")
                    .font(.system(size: 20, weight: .bold, design: .monospaced))
                    .foregroundColor(.blue)
                    

                List {
                    SearchBar(searchItem: $searchItem, placeholder: "Search States by State Abbreviation")
                    ForEach(allStates.filter {self.searchItem.isEmpty ? true : $0.state.localizedStandardContains(self.searchItem)}, id: \.self) { stateItem in
                        NavigationLink(destination:
                            CasesDetails(state: stateItem)) {
                            CasesItem(state: stateItem)
                        }
                    }
                }
                .navigationBarTitle(Text("COVID-19 Stastics for all States"), displayMode: .inline)// End of List
            }
        }
        .customNavigationViewStyle()
        


            
    }
   
 
}
 

struct CasesList_Previews: PreviewProvider {
    static var previews: some View {
        CasesList(state: allStates.first!)
    }
}
