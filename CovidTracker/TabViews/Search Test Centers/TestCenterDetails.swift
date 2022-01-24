//
//  TestCenterDetails.swift
//  CovidTracker
//
//  Created by Aldiyar Bekturganov on 07.12.2020.
//

import SwiftUI
import MapKit
import CoreLocation

struct TestCenterDetails: View {
   
    // Input Parameter
    let test: TestCenter
   
    @State private var selectedMapTypeIndex = 0
    @State private var showTestCenterSavedAlert = false

    var mapTypes = ["Standard", "Satellite", "Hybrid"]
   
    var body: some View {
        Form {
            Section() {
                Image("Corona-testing")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(minWidth: 300, maxWidth: 500, alignment: .center)
            }
            Section(header: Text("Test Center Name")) {
                Text(test.name)
            }
            Section(header: Text("Test Center Address")) {
                Text(test.address)
            }
            if test.lat != "" && test.lon != 0 {
                Section(header: Text("Select Map Type")) {
                   
                    Picker("Select Map Type", selection: $selectedMapTypeIndex) {
                        ForEach(0 ..< mapTypes.count, id: \.self) { index in
                           Text(self.mapTypes[index]).tag(index)
                       }
                    }
                    .frame(minWidth: 300, maxWidth: 500, alignment: .center)
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
     
                    NavigationLink(destination: testCenterLocation) {
                        HStack {
                            Image(systemName: "mappin.and.ellipse")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                            Text("Show Place Location on Map")
                                .font(.system(size: 16))
                        }
                        .foregroundColor(.blue)
                    } // End of HStack
                    .frame(minWidth: 300, maxWidth: 500, alignment: .leading)
                }
            }
            else {
                Section(header: Text("Map")) {
                    Text("Coordinatese Unavailable")
                }
            }
            
            if test.lat != "" && test.lon != 0 {
                Section(header: Text("Get Directions to the Test Center")) {
    //                NavigationLink(destination: mapView()) {
                        Button(action: {
                            testDirections = TestCenter(id: test.id, name: test.name, address: test.address, city: test.city, state: test.state, lat: test.lat, lon: test.lon, url: test.url, phone: test.phone)
                            self.showTestCenterSavedAlert = true
                            }) {
                            HStack {
                                Image(systemName: "plus")
                                    .imageScale(.medium)
                                    .font(Font.title.weight(.regular))
                                    .foregroundColor(.blue)
                                Text("Get Coordinates")
                                    .font(.system(size: 16))
                                }
                            }
    //                    }
                }
            }
            else {
                Section(header: Text("Get Directions to the Test Center")) {
                    Text("Coordinates Unavailable")
                }
            }
            
            if test.url != "" {
                Section(header: Text("Test Center Website")) {
                    
                    Link(destination: URL(string: test.url)!) {
                        HStack {
                            Image(systemName: "globe")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                            Text("Show Website")
                                .font(.system(size: 16))
                        } // End of HStack
                        .foregroundColor(.blue)
                    }
                }
            }
            else {
                Section(header: Text("Test Center Website")) {
                    Text("URL Unavailable")
                }
            }
            
           
        }   // End of Form
        .navigationBarTitle(Text("\(test.name)"), displayMode: .inline)
        .alert(isPresented: $showTestCenterSavedAlert, content: { self.testCenterSavedAlert })
        .font(.system(size: 14))    // Set font and size for all Text views in the Form
       
    }   // End of body
   
    var testCenterLocation: some View {
       
        var mapType: MKMapType
      
        switch selectedMapTypeIndex {
        case 0:
            mapType = MKMapType.standard
        case 1:
            mapType = MKMapType.satellite
        case 2:
            mapType = MKMapType.hybrid
        default:
            fatalError("Map type is out of range!")
        }
        let latitude = (test.lat as NSString).doubleValue
        return AnyView( MapView(mapType: mapType, latitude: latitude, longitude: test.lon, delta: 10.0, deltaUnit: "degrees", annotationTitle: test.name, annotationSubtitle: test.city)
                .navigationBarTitle(Text("\(test.name) Map"), displayMode: .inline)
                .edgesIgnoringSafeArea(.all) )
    }
    
    var testCenterSavedAlert: Alert {
        Alert(title: Text("Coordinates Stored!"),
              message: Text("Please Click the \"Directions to Test\" to get Directions to the Test Center!"),
              dismissButton: .default(Text("OK")) )
    }
}
 
