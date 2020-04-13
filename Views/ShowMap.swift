//
//  ShowMap.swift
//  Caffy
//
//  Created by Jonathan Christie on 1/25/20.
//  Copyright © 2020 Jonathan Christie. All rights reserved.
//

import SwiftUI
import UIKit
import CoreLocation
import CoreLocation.CLLocation
import MapKit.MKAnnotationView
import MapKit.MKUserLocation

struct ShowMap: View {
    
    
    
    private func followUser() {
           userTrackingMode = .follow
       }
    private func stopFollowUser(){
            userTrackingMode = .none
    }
    
    @State private var userTrackingMode: MKUserTrackingMode = .none
    @State private var centerCoordinate = CLLocationCoordinate2D()

    @EnvironmentObject var mapViewContainer: MapViewContainer
    @EnvironmentObject var CafeArray: CafeArray
    
    @State var googleClient: GoogleClientRequest = GoogleClient()
    
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
        
            CafeArray.cafes.append(cafe)
        
        print(name, address, location)
        
        
       }
        print("cafes", CafeArray.cafes)
    }
    
    var locationName : String = ""
       
    var Starbucks: String = "Starbucks"
       
    var searchRadius : Int = 50
    
    func fetchGoogleData(forLocation: CLLocation, locationName: String, searchRadius: Int) {
        
      let cameraLat = self.centerCoordinate.latitude
      let cameraLong = self.centerCoordinate.longitude
      let newCenterCoordinate: CLLocation = CLLocation(latitude: cameraLat, longitude: cameraLong)
        
      googleClient.getGooglePlacesData(forKeyword: locationName, location: newCenterCoordinate, withinMeters: 50) { (response) in
          
        self.appendCafe(places: response.results)
        
    
          print("fetch data called")
          
          
      }
    }
    var body: some View {
            ZStack{
                MapView(userTrackingMode: $userTrackingMode, centerCoordinate: $centerCoordinate)
                    .environmentObject(MapViewContainer())
                    .edgesIgnoringSafeArea(.top)
                
                if !(userTrackingMode == .follow || userTrackingMode == .followWithHeading) {

                    
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        
                        
                        Button(action: {
                            let cameraLat = self.centerCoordinate.latitude
                            let cameraLong = self.centerCoordinate.longitude
                            let newCenterCoordinate: CLLocation = CLLocation(latitude: cameraLat, longitude: cameraLong)
                            
                            self.fetchGoogleData(forLocation: newCenterCoordinate, locationName: self.locationName, searchRadius: self.searchRadius )

                        }, label: {
                            
                            Image(systemName: "magnifyingglass.circle")
                            
                        })
                
                        .foregroundColor(Color.white)
                        .font(.system(size: 60))
                        .padding()
                        .shadow(color: Color.black.opacity(0.3),
                                radius: 3,
                                x: 3,
                                y: 3)
                        .padding(.bottom, 30)
                    }
                    
                    HStack {
                        Spacer()
                        
                        
                        Button(action: {
                            self.followUser()
                            self.stopFollowUser()
                            
                        }, label: {
                            
                            Image(systemName: "location.circle")
                           
                        })
                 
                        .foregroundColor(Color.white)
                        .font(.system(size: 60))
                        .padding()
                        .shadow(color: Color.black.opacity(0.3),
                                radius: 3,
                                x: 3,
                                y: 3)
                        .padding(.bottom, 150)
                        }
                }
            
                }
           
            }.edgesIgnoringSafeArea(.all)
             .navigationBarTitle(Text("mapView"))
             .navigationBarHidden(true)
    }


class ChildHostingController: UIHostingController<ShowMap> {

    required init?(coder: NSCoder) {
        super.init(coder: coder,rootView: ShowMap());
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
struct ShowMap_Previews: PreviewProvider {
    static var previews: some View {
        ShowMap()
    }
}

}
