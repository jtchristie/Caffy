//
//  CafeArray.swift
//  Caffy
//
//  Created by Jonathan Christie on 4/8/20.
//  Copyright © 2020 Jonathan Christie. All rights reserved.
//

import Foundation
import MapKit

class CafeArray: ObservableObject{
    @Published var cafes: [MKAnnotation] = []
}
