//
//  MenuView.swift
//  CovidTracker
//
//  Created by Aldiyar Bekturganov on 07.12.2020.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack(alignment: .leading) {
                //Add the title of the side menu
                Text("Helpful Information: ")
                    .padding(.top, 100)
                    .font(Font.title.weight(.bold))
                    .foregroundColor(.black)
                //Add elements to be displayed in the side view
                Link(destination: URL(string: "https://www.who.int/emergencies/diseases/novel-coronavirus-2019/advice-for-public")!) {
                    HStack {
                        Image(systemName: "person.fill")
                            .imageScale(.large)
                            .font(Font.title.weight(.regular))
                        Text("WHO Protection Guidelines")
                            .font(.headline)
                    } // End of HStack
                    .foregroundColor(.white)
                }
                .padding(.top, 30)
                Link(destination: URL(string: "https://www.cdc.gov/coronavirus/2019-ncov/symptoms-testing/coronavirus-self-checker.html")!) {
                    HStack {
                        Image(systemName: "cross.case.fill")
                            .imageScale(.large)
                            .font(Font.title.weight(.regular))
                        Text("CDC's Coronavirus Self Checker")
                            .font(.headline)
                    } // End of HStack
                    .foregroundColor(.white)
                }
                .padding(.top, 30)
                Link(destination: URL(string: "https://travel.state.gov/content/travel/en/traveladvisories/ea/covid-19-information.html")!) {
                    HStack {
                        Image(systemName: "airplane")
                            .imageScale(.large)
                            .font(Font.title.weight(.regular))
                        Text("COVID-19 Travel Information")
                            .font(.headline)
                    } // End of HStack
                    .foregroundColor(.white)
                }
                .padding(.top, 30)
                Link(destination: URL(string: "https://www.bbc.com/news/coronavirus")!) {
                    HStack {
                        Image(systemName: "newspaper.fill")
                            .imageScale(.large)
                            .font(Font.title.weight(.regular))
                        Text("BBC's Coronavirus Latest News")
                            .font(.headline)
                    } // End of HStack
                    .foregroundColor(.white)
                }
                .padding(.top, 30)
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
        }
    }
}



struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
