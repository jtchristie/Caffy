//
//  AuthenticationScreen.swift
//  Caffy
//
//  Created by Jonathan Christie on 1/27/20.
//  Copyright © 2020 Jonathan Christie. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct TitleView: View {
    
    @EnvironmentObject var session: SessionStore
    
    func getUser() {
        session.listen()
    }

    var body: some View {
        
        NavigationView {
           
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("Primary"), Color("Charcoal")]), startPoint: .top, endPoint: .bottom)
            VStack{
                
             
                Text("Caffy")
                    .multilineTextAlignment(.center)
                    .font(Font.custom("GT Eesti Pro Text", size: 96))
                    .foregroundColor(Color("Accent"))
                    .padding(.bottom, 100.0)
                
                NavigationLink(destination: SignInView()){

                        Text("SIGN IN")
                            .padding(.horizontal, CGFloat(70))
                            .padding(.vertical, CGFloat(5))
                            .background(Color("Primary"))
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
                         .background(Color("Primary"))
                         .cornerRadius(40)
                         .foregroundColor(.white)
                         .font(Font.custom("GT Eesti Pro Text", size: 30))
                         .padding(.vertical, CGFloat(5))
                         .padding(.bottom, CGFloat(35))

                                   
                                   
                 }
                
                NavigationLink(destination: HomeView()
                               .navigationBarTitle(Text("x"))
                               .navigationBarHidden(true)) {
                       Text("Get Coffee")
                               .padding(.horizontal, 50.0)
                               .padding(.vertical, 5)
                               .background(Color(.white))
                               .cornerRadius(40)
                               .foregroundColor(Color("Primary"))
                               .font(Font.custom("GT Eesti Pro Text", size: CGFloat(30)))
                               .padding(.vertical, CGFloat(10))
                       }
                    

        
            }
            
        }.edgesIgnoringSafeArea(.all)
            
    }
}

struct AuthenticationScreen_Previews: PreviewProvider {
    static var previews: some View {
        TitleView()
    }
}
}
