//
//  SignIn.swift
//  Caffy
//
//  Created by Jonathan Christie on 3/25/20.
//  Copyright © 2020 Jonathan Christie. All rights reserved.
//

import SwiftUI

struct SignInView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var loading = false
    @State var error = false
    
    @EnvironmentObject var session: SessionStore
    
    @State private var complete: Bool = false
    
    func signIn () {
        loading = true
        error = false
        session.signIn(email: email, password: password) { (result, error) in
            self.loading = false
            if error != nil {
                self.error = true
                self.complete = false
            } else {
                self.email = ""
                self.password = ""
            }
        }
    }
    var body: some View {
        NavigationView{
                ZStack {
                        LinearGradient(gradient: Gradient(colors: [Color("Primary"), Color("Charcoal")]), startPoint: .top, endPoint: .bottom)
                        VStack{
                            
                            
                            Text("Caffy")
                                .multilineTextAlignment(.center)
                                .font(Font.custom("GT Eesti Pro Text", size: 96))
                                .foregroundColor(.white)
                                .padding(.bottom, 50.0)
                                .padding(.top, 20)
                            
                            Text("Sign in with email")
                                .multilineTextAlignment(.center)
                                .font(Font.custom("GT Eesti Pro Text", size: 30))
                                .foregroundColor(.white)
                                .padding(.bottom, 10)
                            
                            
                            TextField("Email", text: $email)
                                .padding(.horizontal, CGFloat(90))
                                .foregroundColor(Color("Charcoal"))
                                .multilineTextAlignment(.center)
                                .font(Font.custom("GT Eesti Pro Text", size: 20))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            

                            SecureField("Password", text: $password)
                                .padding(.horizontal, CGFloat(90))
                                .foregroundColor(Color("Charcoal"))
                                .multilineTextAlignment(.center)
                                .font(Font.custom("GT Eesti Pro Text", size: 20))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.bottom, CGFloat(10))

                            if (error){
                                
                                Text("Error logging in")
                                    .font(Font.custom("GT Eesti Pro Text", size: 20))
                                    .foregroundColor(.white)
                                    .padding(.bottom, CGFloat(10))
                                

                            }
                            
                            if complete == true{
                                Text("Success")
                                    .font(Font.custom("GT Eesti Pro Text", size: 20))
                                    .foregroundColor(.white)
                                    .padding(.bottom, CGFloat(10))

                               
                            }
                            Button(action: {
                                self.signIn()
                                self.complete = true
                            }){
                                
                                Text("SIGN IN")
                                    .padding(.horizontal, CGFloat(70))
                                    .padding(.vertical, CGFloat(5))
                                    .background(Color("Primary"))
                                    .cornerRadius(40)
                                    .foregroundColor(.white)
                                    .font(Font.custom("GT Eesti Pro Text", size: 30))
                                    .padding(.bottom, CGFloat(30))
                                
                            }
                            Text("or")
                                .multilineTextAlignment(.center)
                                .font(Font.custom("GT Eesti Pro Text", size: 30))
                                .foregroundColor(.white)
                                .padding(.bottom, 100.0)
                            
                            
                    }
                }.edgesIgnoringSafeArea(.all)
            }
        }
}

struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
