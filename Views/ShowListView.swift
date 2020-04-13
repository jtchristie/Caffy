//
//  ListView.swift
//  Caffy
//
//  Created by Jonathan Christie on 1/25/20.
//  Copyright © 2020 Jonathan Christie. All rights reserved.
//
import SwiftUI
import Firebase
import Foundation
import Combine
import CoreLocation


struct ShowListView: View {


    var locationManager = CLLocationManager()

    @State var googleClient: GoogleClientRequest = GoogleClient()
    @EnvironmentObject var session: SessionStore
    @ObservedObject var cafeSession = SessionStore()
    @ObservedObject var fetcher = PlaceFetcher()
    @State private var show_modal: Bool = false


    init() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().barTintColor = UIColor(red:0.44, green:0.49, blue:0.65, alpha:1.00)

        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        
    }
    func getUser() {
        session.listen()
    }
    
    
    var body: some View {

        ZStack(alignment: .top){
            Color("Primary")
                      
      
                        ScrollView(.vertical, showsIndicators: false) {
                           
                            VStack{
                                Text("Cafes near you")
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Color.white)
                                    .font(Font.custom("GT Eesti Pro Text", size: CGFloat(40)))
                                    .padding(.top, 50.0)
                                    .padding(.bottom, 20)

                            }
                               VStack(alignment: .leading, spacing: 0) {
                               
                                ForEach(fetcher.places) { place in
                                    VStack{
                                      Text(place.name)
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(Color.white)
                                        .font(Font.custom("GT Eesti Pro Text", size: CGFloat(25)))
                                      Text(place.address)
                                        .multilineTextAlignment(.center)

                                        .foregroundColor(Color.white)
                                        .font(.system(size: 11))
                                        .fixedSize(horizontal: false, vertical: true)

                                        if (place.openingHours?.open != false){
                                                Text("open")
                                                    .font(.system(size: 11))
                                                    .foregroundColor(Color.white)
                                                }
                                    }
                                    .padding(.horizontal, CGFloat(90))
                                    .padding(.vertical, CGFloat(20))
                                    .background(Color("Primary-Active"))
                                    .cornerRadius(15)
                                    .frame(width: 300)
                                    .padding(.bottom, CGFloat(20))
                                     .shadow(color: Color.gray, radius: 20, x: 0, y: 5)

                                }
                                
                               }
                }.onAppear(perform: getUser)
                            
                
         
        }
        .edgesIgnoringSafeArea(.top)
        .navigationBarTitle(Text("Cafes"))

                
                
                    
                    
                    

        
        
    }

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ShowListView()
    }
}

}
