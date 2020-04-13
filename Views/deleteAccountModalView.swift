//
//  deleteAccountModalView.swift
//  Caffy
//
//  Created by Jonathan Christie on 3/31/20.
//  Copyright © 2020 Jonathan Christie. All rights reserved.
//

import SwiftUI

struct deleteAccountModalView: View {
    @EnvironmentObject var session: SessionStore
    @State private var deleteComplete: Bool = false
    @State var error = false

    func delete(){
        print("delete account")
        session.delete()
        if error == error {
            self.deleteComplete = false
        }
    }
    
    var body: some View {
        ZStack{
            Color("Primary")
            VStack{
                Text("Confirm Deletion")
                    .multilineTextAlignment(.center)
                    .font(Font.custom("GT Eesti Pro Text", size: 40))
                    .foregroundColor(.white)
                Text("After you delete an account, it's permanently deleted. Accounts can't be undeleted.")
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, CGFloat(30))
                    .padding(.vertical, CGFloat(5))
                    .font(Font.custom("GT Eesti Pro Text", size: 20))
                    .foregroundColor(.white)
                Button(action: {
                        self.delete()
                        self.deleteComplete = true

                    }){
                        
                        Text("DELETE")
                            .padding(.horizontal, CGFloat(70))
                            .padding(.vertical, CGFloat(5))
                            .background(Color("Charcoal"))
                            .cornerRadius(40)
                            .foregroundColor(.white)
                            .font(Font.custom("GT Eesti Pro Text", size: 30))
                            .padding(.bottom, CGFloat(30))
                        
                    }
             
            }
        }.edgesIgnoringSafeArea(.all)
        
    }
}

struct deleteAccountModalView_Previews: PreviewProvider {
    static var previews: some View {
        deleteAccountModalView()
    }
}
