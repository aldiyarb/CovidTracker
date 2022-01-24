//
//  MapDirectionsView.swift
//  CovidTracker
//
//  Created by Aldiyar Bekturganov on 07.12.2020.
//

import SwiftUI
import MapKit

public var testDirections = TestCenter(id: UUID(), name: "", address: "", city: "", state: "", lat: "", lon: 0.0, url: "", phone: "")

struct MapDirectionsView: View {
    var body: some View {
        //If the test center has not been chosen yet redirect to DirectionsUnavailable() View
        if testDirections.name == "" {
            DirectionsUnavailable()
            
        }
        else {
            //If the test center has been chosen show directions if available
            mapView()
            
        }
        
    }
    
}

struct MapDirectionsView_Previews: PreviewProvider {
    static var previews: some View {
        MapDirectionsView()
    }
}

struct mapView : UIViewRepresentable {
    //Creates the custom instance of the map view with polyline overlay
    func makeCoordinator() -> mapView.Coordinator {
        return mapView.Coordinator()
    }
    func makeUIView(context: UIViewRepresentableContext<mapView>) -> MKMapView {
        //Obtain the user's current location
        let currentGeolocation = currentLocation()
        let latitudeOfCurrentLocation  = currentGeolocation.latitude
        let longitudeOfCurrentLocation = currentGeolocation.longitude
        //Convert latitude read as String from API to a Double
        let latitude = (testDirections.lat as NSString).doubleValue
    
        //Initialize a map view
        let map = MKMapView()
        //Obtain the coordinates of the source, i.e user's current location
        let sourceCoordinate = CLLocationCoordinate2D(latitude: latitudeOfCurrentLocation, longitude: longitudeOfCurrentLocation)
//      For Testing:  let sourceCoordinate = CLLocationCoordinate2D(latitude: 39.7, longitude: -75.67)
        //Obtain the coordinates of the destination, i.e the test center
        let destinationCoordinate =  CLLocationCoordinate2D(latitude: latitude, longitude: testDirections.lon)
        
        // Instantiate an object from the MKCoordinateRegion() class and
        // store its object reference into local variable region centered at current location
        let region =  MKCoordinateRegion(center: sourceCoordinate, latitudinalMeters: 10000, longitudinalMeters: 100000)
        
        //Create a pin for the user's current location
        let sourcePin = MKPointAnnotation()
        sourcePin.coordinate = sourceCoordinate
        sourcePin.title = "Current Location"
        map.addAnnotation(sourcePin)
        
        //Create a pin for the test center that is the destination
        let destinationPin = MKPointAnnotation()
        destinationPin.coordinate = destinationCoordinate
        destinationPin.title = "\(testDirections.name)"
        map.addAnnotation(destinationPin)
        
        //Specify the map's region
        map.region = region
        map.delegate = context.coordinator
        
        let req = MKDirections.Request()
        req.source = MKMapItem(placemark: MKPlacemark(coordinate: sourceCoordinate))
        req.destination = MKMapItem(placemark: MKPlacemark(coordinate: destinationCoordinate))
        
        //Obtain Directions of the map
        let directions = MKDirections(request: req)
        directions.calculate { (direct, err) in
            
            if err != nil {
                //If error is present, i.e unable to get directions, the error is printed and only the source pin is displayed
                print((err?.localizedDescription)!)
                return
            }
            //Create a polyline based on directions received from the user's location to the test center
            let polyline = direct?.routes.first?.polyline
            //Add the polyline object to the map that will show the directions as a line
            map.addOverlay(polyline!)
            map.setRegion(MKCoordinateRegion(polyline!.boundingMapRect), animated: true)
        }
        //Return the complete map
        return map
    }
    
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<mapView>) {
        
    }
    
    //Class that coordinates with the MapView that renders the overlay object on the map
    //In this case it is the polyline that shows directions
    class Coordinator : NSObject, MKMapViewDelegate {
        //Returns the map with the overlayed rendered object
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) ->
            MKOverlayRenderer{
            //Strokes the polyline and returns the render
            let render = MKPolylineRenderer(overlay: overlay)
            render.strokeColor = .orange
            render.lineWidth = 2
            return render
        }
    }
    
}

