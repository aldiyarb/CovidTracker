//
//  DirectionsUnavailable.swift
//  CovidTracker
//
//  Created by Aldiyar Bekturganov on 07.12.2020.
//

import SwiftUI

struct DirectionsUnavailable: View {
    @State var navBarHidden: Bool = true
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 66/255, green: 193/255, blue: 247/255).opacity(0.5).edgesIgnoringSafeArea(.all)
                VStack {
                    Image(systemName: "exclamationmark.triangle")
                        .imageScale(.large)
                        .font(Font.title.weight(.medium))
                        .foregroundColor(.red)
                        .padding()
                    Text("After you've selected the Test Center to Navigate to in \"Get Tested\" Tab by tapping \"Get Coordinates\" of the selected Center, press \"Get Directions\"\n\n You will be returned to this view until a Test Center is chosen.")
                        .fixedSize(horizontal: false, vertical: true)   // Allow lines to wrap around
                        .multilineTextAlignment(.center)
                        .padding()
                        .foregroundColor(.black)
                    NavigationLink(destination: MapDirectionsView()) {
                        Text("Get Directions")
                    }
                    .navigationBarTitle("Navigate Again")
                    .navigationBarHidden(self.navBarHidden)
                    .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                        self.navBarHidden = true
                    }
                    .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                        self.navBarHidden = false
                    }
                }
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                
            }
            
        }
        .navigationBarTitle(Text(""))
        .navigationBarTitle("")
        .navigationBarHidden(self.navBarHidden)
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            self.navBarHidden = true
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            self.navBarHidden = false
        }
        
    }
    
    
    
}



struct DirectionsUnavailable_Previews: PreviewProvider {
    static var previews: some View {
        DirectionsUnavailable()
    }
}
