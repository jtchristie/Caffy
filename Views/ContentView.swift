//
//  ContentView.swift
//  Caffy
//
//  Created by Jonathan Christie on 1/24/20.
//  Copyright © 2020 Jonathan Christie. All rights reserved.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    @EnvironmentObject var session: SessionStore
        
        func getUser () {
            session.listen()
        }
        
        var body: some View {
            Group {
                if ((session.session ) != nil) {
                    HomeView()
                    
                } else {
                    TitleView()
                }
            }.onAppear(perform: getUser)
        }
    }
    
   

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(SessionStore())
    }
}

