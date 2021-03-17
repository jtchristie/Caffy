//
//  MapView.swift
//  Caffy
//
//  Created by Jonathan Christie on 1/25/20.
//  Copyright © 2020 Jonathan Christie. All rights reserved.
//


import SwiftUI
import MapKit
import GoogleMapsTileOverlay
import CoreLocation
import UIKit

struct MapView: UIViewRepresentable{
    
    var userTrackingMode: Binding<MKUserTrackingMode>

    @EnvironmentObject private var mapViewContainer: MapViewContainer
    @EnvironmentObject private var CafeArray: CafeArray
    
    @State var googleClient: GoogleClientRequest = GoogleClient()

    var locationManager = CLLocationManager()

    var locationName : String = ""
    
    var Starbucks: String = "Starbucks"
    
    var searchRadius : Int = 50
    
    
    @Binding var centerCoordinate: CLLocationCoordinate2D

    
  //  @EnvironmentObject private var cafes: MapViewContainer
    

   
    
    func setupManager(){
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()

    }
    
  
    func makeUIView(context: Context) -> MKMapView {
        
        
        setupManager()
        let mapView = MKMapView(frame: UIScreen.main.bounds)
        mapView.showsCompass = false
        
        let categories:[MKPointOfInterestCategory] = [.cafe]
        let filters = MKPointOfInterestFilter(including: categories)
        mapView.pointOfInterestFilter = .some(filters)
        
        //changes map type
        mapView.mapType = MKMapType.satellite
        
       
        //camera zoom range
        mapView.cameraZoomRange = MKMapView.CameraZoomRange(minCenterCoordinateDistance: 0 ,maxCenterCoordinateDistance: 10000)

        //shows user's location
        mapView.showsUserLocation = true
        
        mapView.delegate = context.coordinator
        
        //changes map theme
        guard let jsonURL = Bundle.main.url(forResource: "MapStyle", withExtension: "json") else { return mapView}
        let tileOverlay = try? GoogleMapsTileOverlay(jsonURL: jsonURL)
        tileOverlay!.canReplaceMapContent = true
        mapView.addOverlay(tileOverlay!, level: .aboveRoads)
        
        //adds cafes to Cafe object and adds annotations
        func appendCafe(places: [Place]) {
              for place in places {
                  print("*******NEW PLACE********")
                  let name = place.name
                  let address = place.address
                  let location = ("lat: \(place.geometry.location.latitude), lng: \(place.geometry.location.longitude)")
                  guard let open = place.openingHours?.open else {
                          return
                  }
                 let openString: String = ""
                 
                 let cafe = CafeMarker(title: name, locationName: address, open: open, openString: openString, coordinate: CLLocationCoordinate2D(latitude: place.geometry.location.latitude, longitude: place.geometry.location.longitude))
                
                if (place.name != "McDonald's"){
                    CafeArray.cafes.append(cafe)
                }
                mapView.addAnnotations(CafeArray.cafes)
                print(name, address, location)
                
                
               }
            print("cafes", CafeArray.cafes)
            }
        
         mapView.showsUserLocation = true
         mapView.userTrackingMode = .follow

         //gets user location
         let location = locationManager.location
                        
         let lat = location?.coordinate.latitude ?? 70
         let long = location?.coordinate.longitude ?? 40
         
         var newLocation: CLLocation = CLLocation(latitude: lat, longitude: long)
         var newLocationN: CLLocation = CLLocation(latitude: lat , longitude: long + 0.01)
         var newLocationS: CLLocation = CLLocation(latitude: lat , longitude: long - 0.01)
         var newLocationE: CLLocation = CLLocation(latitude: lat + 0.01 , longitude: long)
         var newLocationW: CLLocation = CLLocation(latitude: lat - 0.01 , longitude: long)

         let newLocation2D: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: lat, longitude: long)
         //gets camera location
         let cameraLat = centerCoordinate.latitude
         let cameraLong = centerCoordinate.longitude
          
         mapView.cameraBoundary = MKMapView.CameraBoundary(coordinateRegion: MKCoordinateRegion(center: newLocation2D, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)))
          //fetches JSON data
          func fetchGoogleData(forLocation: CLLocation, locationName: String, searchRadius: Int) {
              
              googleClient.getGooglePlacesData(forKeyword: locationName, location: newLocation, withinMeters: 700) { (response) in
                  
                  appendCafe(places: response.results)
                
            
                  print("fetch data called")
                  
                  
              }
            googleClient.getGooglePlacesData(forKeyword: locationName, location: newLocationN, withinMeters: 700) { (response) in
                  
                  appendCafe(places: response.results)
                
            
                  print("North fetch data called")
                  
                  
              }
            googleClient.getGooglePlacesData(forKeyword: locationName, location: newLocationS, withinMeters: 700) { (response) in
                  
                  appendCafe(places: response.results)
                
            
                  print("South fetch data called")
                  
                  
              }
            googleClient.getGooglePlacesData(forKeyword: locationName, location: newLocationE, withinMeters: 700) { (response) in
                  
                  appendCafe(places: response.results)
                
            
                  print("East fetch data called")
                  
                  
              }
            googleClient.getGooglePlacesData(forKeyword: locationName, location: newLocationW, withinMeters: 700) { (response) in
                  
                  appendCafe(places: response.results)
                
            
                  print("West fetch data called")
                  
                  
              }

              googleClient.getGooglePlacesData(forKeyword: Starbucks, location: newLocation, withinMeters: 700) { (response) in
                    
                    appendCafe(places: response.results)
              
                    print("Starbucks fetch data called")
                    
                    
                }
          }
          
          mapView.register(CafeMarkerView.self,
          forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
          
          if (cameraLat != lat && cameraLong != long){
                print("cameraLat", cameraLat, "cameraLong", cameraLong)
           }
           fetchGoogleData(forLocation: newLocation, locationName: locationName, searchRadius: searchRadius )
          print("cafes", CafeArray.cafes)
        

        return mapView
        

    }

    func updateUIView(_ view: MKMapView, context: Context) {
        
          if view.userTrackingMode == userTrackingMode.wrappedValue {
              view.setUserTrackingMode(userTrackingMode.wrappedValue, animated: true)
          }

          let cameraLat = centerCoordinate.latitude
          let cameraLong = centerCoordinate.longitude
          
          print("cameraLat", cameraLat, "cameraLong", cameraLong)
          
          view.showsUserLocation = true
         

        view.addAnnotations(CafeArray.cafes)

    }

    func makeCoordinator() -> Coordinator {
    Coordinator(self)
        
        
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            parent.centerCoordinate = mapView.centerCoordinate
            
        }
        var parent: MapView

        init(_ parent: MapView) {
        self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
           if let tileOverlay = overlay as? MKTileOverlay {
                return MKTileOverlayRenderer(tileOverlay: tileOverlay)
            }
            return MKOverlayRenderer(overlay: overlay)
        }
    }


}


struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
