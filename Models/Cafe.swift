//
//  Cafe.swift
//  Caffy
//
//  Created by Jonathan Christie on 4/4/20.
//  Copyright © 2020 Jonathan Christie. All rights reserved.
//

import Foundation
import FirebaseDatabase


struct Cafe: Identifiable {
    let ref: DatabaseReference?
    let key: String
    let cafeName: String
    let address: String
    let city: String
    let state: String
    let isComplete: String
    let id: String
    
    init(isComplete: String, cafeName: String, address: String, city: String, state: String, key: String = "") {
        self.ref = nil
        self.key = key
        self.cafeName = cafeName
        self.address = address
        self.city = city
        self.state = state
        self.isComplete = isComplete
        self.id = key
        
    }
    init?(snapshot: DataSnapshot) {
          guard
              let value = snapshot.value as? [String: AnyObject],
              let cafeName = value["cafe"] as? String,
              let address = value["address"] as? String,
              let city = value["city"] as? String,
              let state = value["state"] as? String,
              let isComplete = value["isComplete"] as? String
              else {
                  return nil
              }
          
          self.ref = snapshot.ref
          self.key = snapshot.key
          self.cafeName = cafeName
          self.address = address
          self.city = city
          self.state = state
          self.isComplete = isComplete
          self.id = snapshot.key
          
      }
      
      func toAnyObject() -> Any {
          return [
              "cafeName": cafeName,
              "address": address,
              "city": city,
              "state": state,
              "isComplete": isComplete,
              
          ]
      }
}
