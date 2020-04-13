//
//  AccountView.swift
//  Caffy
//
//  Created by Jonathan Christie on 1/25/20.
//  Copyright © 2020 Jonathan Christie. All rights reserved.
//

import SwiftUI
import Firebase

struct AccountView: View {
    
    @EnvironmentObject var session: SessionStore
    @State var loading = false
    @State var error = false
    @State private var complete: Bool = false
    @State private var show_modal: Bool = false
    @State private var isNotSignedIn: Bool = false
    func signOut(){
        print("sign me out")
        session.signOut()
        if error == error {
            self.complete = false
        }
        
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
                        if (error) {
                            Text("Error signing out")
                                .font(Font.custom("GT Eesti Pro Text", size: 20))
                                .foregroundColor(.white)
                                .padding(.bottom, CGFloat(10))
                            
                        }
                        if complete == true {
                            Text("Success")
                                .font(Font.custom("GT Eesti Pro Text", size: 20))
                                .foregroundColor(.white)
                                .padding(.bottom, CGFloat(10))
                            
                        }
                        Button(action: {
                            self.signOut()
                            self.complete = true
                            
                        }){
                            
                            Text("SIGN OUT")
                                .padding(.horizontal, CGFloat(70))
                                .padding(.vertical, CGFloat(5))
                                .background(Color("Charcoal"))
                                .cornerRadius(40)
                                .foregroundColor(.white)
                                .font(Font.custom("GT Eesti Pro Text", size: 30))
                                .padding(.bottom, CGFloat(30))
                            
                        }
                        
                        Button(action: {
                            self.show_modal = true
                            
                        }){
                            
                            Text("DELETE ACCOUNT")
                                .padding(.horizontal, CGFloat(70))
                                .padding(.vertical, CGFloat(5))
                                .background(Color("Charcoal"))
                                .cornerRadius(40)
                                .foregroundColor(.white)
                                .font(Font.custom("GT Eesti Pro Text", size: 30))
                                .padding(.bottom, CGFloat(30))
                            
                        }.sheet(isPresented: self.$show_modal){
                            deleteAccountModalView().environmentObject(self.session)
                        }
                        Text("After you delete an account, it's permanently deleted. Accounts can't be undeleted.")
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, CGFloat(30))
                            .padding(.vertical, CGFloat(5))
                            .font(Font.custom("GT Eesti Pro Text", size: 20))
                            .foregroundColor(.white)
                    }
                    
                }.onAppear(perform: getUser)
                 .navigationBarTitle(Text(""))
                
            }.onAppear(perform: getUser)
             .edgesIgnoringSafeArea(.all)
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
