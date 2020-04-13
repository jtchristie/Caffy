//
//  HomeView.swift
//  Caffy
//
//  Created by Jonathan Christie on 1/25/20.
//  Copyright © 2020 Jonathan Christie. All rights reserved.
//

import SwiftUI
import UIKit

struct HomeView: View {
    
    
    var body: some View {

        ZStack{
            
            TabView {
                ShowListView()
                    .navigationBarTitle(Text("List"))
                    .navigationBarHidden(true)
                    .tabItem{
                        Image(systemName: "eyeglasses")
                        Text("List")
                }
                .tag(0)
                ShowMap().environmentObject(CafeArray())
                    .navigationBarTitle(Text("Map"))
                    .navigationBarHidden(true)
                    .tabItem {
                        Image(systemName: "map.fill")
                        Text("Map")
                    }
                .tag(1)
                AccountView()
                    .navigationBarTitle(Text("Account"))
                    .navigationBarHidden(true)
                    .tabItem {
                        Image(systemName: "person.crop.circle.fill")
                        Text("Account")
                }
               .tag(2)
            }
                .accentColor(Color("Primary-Active"))
               
        }
    }
}

/*extension UITabBarController {
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.hidesBackButton = true
    }
 } */

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
struct ButtonView: View {
    @State var navigationBarBackButtonHidden = true

    var body: some View {
        Button("Show back") {
            self.navigationBarBackButtonHidden = false
        }.navigationBarBackButtonHidden(navigationBarBackButtonHidden)
    }
}
