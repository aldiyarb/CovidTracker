//
//  ContentView.swift
//  CovidTracker
//
//  Created by Aldiyar Bekturganov on 03.12.2020.
//

import SwiftUI
 
struct ContentView: View {
    @State var showMenu = false

    var body: some View {
        TabView {
            NavigationView {
                GeometryReader{geometry in
                    ZStack(alignment: .leading){
                        Home()
                            //Sets the frame of the Home() view to full screen
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            //Moves to the right if showMenu is true
                            .offset(x: self.showMenu ? geometry.size.width/2 + 100 : 0)
                            //Disables any functionality of the view if showMenu is true
                            .disabled(self.showMenu ? true : false)
                            
                        //Displays the side menu if showMenu is true
                        if self.showMenu {
                            MenuView()
                                //Side View frame is specified to approximately a half
                                .frame(width: geometry.size.width / 2 + 100)
                                //Slides the side menu from the left edge of the current view
                                .transition(.move(edge: .leading))
                        }
                    }
                }
                .navigationBarTitle("Coronavirus in the USA: Overview", displayMode: .inline)
                //Button that changes the value of showMenu to true or false after it is tapped
                .navigationBarItems(leading: (
                    Button(action: {
                        withAnimation {
                            //Change the value of showMenu after tapping
                            self.showMenu.toggle()
                        }
                    }) {
                        Image(systemName: "line.horizontal.3")
                            .imageScale(.large)
                    }
                ))
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Overview")
            }
            
            
            CasesList(state: allStates.first!)
                .tabItem {
                    Image(systemName: "list.bullet.rectangle")
                    Text("By-State Data")
                }
            SearchByState()
                .tabItem {
                    Image(systemName: "cross.circle.fill")
                    Text("Get Tested")
                }
            MapDirectionsView()
                .tabItem {
                    Image(systemName: "map")
                    Text("Directions to Test")
                }
            
        }   // End of TabView
            .font(.headline)
            .imageScale(.medium)
            .font(Font.title.weight(.regular))
    }
}
 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

