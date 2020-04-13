//
//  CartView.swift
//  Caffy
//
//  Created by Jonathan Christie on 2/9/20.
//  Copyright © 2020 Jonathan Christie. All rights reserved.
//

import SwiftUI

struct CartView: View {
    var body: some View {
        ZStack{
            Color("Primary")
           VStack{
                Text("hello")
            }.navigationBarTitle(Text("accountView"))
            .navigationBarHidden(true)
          
        }.edgesIgnoringSafeArea(.all)
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
