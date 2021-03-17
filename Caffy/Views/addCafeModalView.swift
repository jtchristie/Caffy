//
//  addCafeModal.swift
//  Caffy
//
//  Created by Jonathan Christie on 4/1/20.
//  Copyright © 2020 Jonathan Christie. All rights reserved.
//

import SwiftUI

struct addCafeModalView: View {
    @State var cafeName: String = ""
    @State var address: String = ""
    @State var city: String = ""
    @State var state: String = ""
    @State var pressed: Bool = false
    @ObservedObject var session: SessionStore

    func addCafe() {
        session.uploadCafe(cafeName: cafeName, address: address, city: city, state: state)
                
    }
    func getUser () {
        session.listen()
    }

    var body: some View {
        NavigationView{

            ZStack{
                Color("Primary")
                VStack{
                    if ((session.session) == nil){
                        Text("You're not signed in")
                            .font(Font.custom("GT Eesti Pro Text", size: 30))
                            .foregroundColor(.white)
                            .padding(.bottom, CGFloat(10))
                        
                        NavigationLink(destination: SignInView()){

                            Text("SIGN IN")
                                .padding(.horizontal, CGFloat(70))
                                .padding(.vertical, CGFloat(5))
                                .background(Color("Charcoal"))
                                .cornerRadius(40)
                                .foregroundColor(.white)
                                .font(Font.custom("GT Eesti Pro Text", size: 30))
                                .padding(.top, CGFloat(200))
                                .padding(.bottom, CGFloat(20))

                            
                            
                        }
                        
                        NavigationLink(destination: SignUpView()){
                            
                            Text("SIGN UP")
                                .padding(.horizontal, CGFloat(70))
                                .padding(.vertical, CGFloat(5))
                                .background(Color("Charcoal"))
                                .cornerRadius(40)
                                .foregroundColor(.white)
                                .font(Font.custom("GT Eesti Pro Text", size: 30))
                                .padding(.vertical, CGFloat(5))
                                .padding(.bottom, CGFloat(35))

                            
                            
                        }
                        
                    } else {
                        Text("Add a cafe")
                            .multilineTextAlignment(.center)
                            .font(Font.custom("GT Eesti Pro Text", size: 50))
                            .foregroundColor(.white)
                            .padding(.bottom, 50.0)
                            .padding(.top, 20)
                        TextField("Cafe name", text: $cafeName)
                            .padding(.horizontal, CGFloat(90))
                            .foregroundColor(Color("Charcoal"))
                            .multilineTextAlignment(.center)
                            .font(Font.custom("GT Eesti Pro Text", size: 20))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        TextField("address", text: $address)
                            .padding(.horizontal, CGFloat(90))
                            .foregroundColor(Color("Charcoal"))
                            .multilineTextAlignment(.center)
                            .font(Font.custom("GT Eesti Pro Text", size: 20))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        TextField("City", text: $city)
                            .padding(.horizontal, CGFloat(90))
                            .foregroundColor(Color("Charcoal"))
                            .multilineTextAlignment(.center)
                            .font(Font.custom("GT Eesti Pro Text", size: 20))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        TextField("State", text: $state)
                            .padding(.horizontal, CGFloat(90))
                            .foregroundColor(Color("Charcoal"))
                            .multilineTextAlignment(.center)
                            .font(Font.custom("GT Eesti Pro Text", size: 20))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.bottom)
                        
                        if pressed == true {
                            Text("Thank you, we will review your entry and display it within 24 hours")
                                .multilineTextAlignment(.center)
                                .font(Font.custom("GT Eesti Pro Text", size: 20))
                                .foregroundColor(.white)
                                .padding(.bottom, CGFloat(10))
                        }
                        Button(action: {
                            print("pressed")
                            self.addCafe()
                            self.pressed = true
                        }){
                            
                            Text("Submit")
                                .padding(.horizontal, CGFloat(70))
                                .padding(.vertical, CGFloat(5))
                                .background(Color(.white))
                                .cornerRadius(40)
                                .foregroundColor(Color("Primary"))
                                .font(Font.custom("GT Eesti Pro Text", size: 30))
                                .padding(.bottom, CGFloat(30))
                            
                        }
                        
                    }
                }
            }.edgesIgnoringSafeArea(.all)
        }
    }
}

