//
//  ListView.swift
//  Caffy
//
//  Created by Jonathan Christie on 3/17/20.
//  Copyright © 2020 Jonathan Christie. All rights reserved.
//
import Foundation
import SwiftUI
import Combine
import CoreLocation
import MapKit

public class PlaceFetcher: ObservableObject {
    
    var locationManager = CLLocationManager()

    var locationName: String = ""
    
    var Starbucks: String = "Starbucks"
    
    var searchRadius : Int = 700
        
    
    @Published var places: [Place] = []
    
    @State var googleClient: GoogleClientRequest = GoogleClient()

    init(){
        load()
    }
    func appendPlace(places: [Place]) {
           for place in places {
               print("*******NEW PLACE********")
               let name = place.name
               let address = place.address
               let location = ("lat: \(place.geometry.location.latitude), lng: \(place.geometry.location.longitude)")
             
             
                self.places.append(place)
            
            
            print(name, address, location)
            
     
            }
        print("places", places)
    }

  
    
    func load(){
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        
        let location = locationManager.location
                         
           guard let lat = location?.coordinate.latitude else { print("no lat")
                                                               return }
           guard let long = location?.coordinate.longitude else { print("no long")
                                                                   return }
        
        var newLocation: CLLocation = CLLocation(latitude: lat, longitude: long)
        
        func fetchGoogleData(forLocation: CLLocation, locationName: String, searchRadius: Int) {
              
              googleClient.getGooglePlacesData(forKeyword: locationName, location: newLocation, withinMeters: 50) { (response) in
                  
                  self.appendPlace(places: response.results)
            
                  print("fetch data called")
                  
                  
              }
              googleClient.getGooglePlacesData(forKeyword: Starbucks, location: newLocation, withinMeters: 50) { (response) in
                    
                  self.appendPlace(places: response.results)
              
                    print("Starbucks fetch data called")
                    
                    
                } 
          }
        
        fetchGoogleData(forLocation: newLocation, locationName: locationName, searchRadius: searchRadius )
        
    }
}
