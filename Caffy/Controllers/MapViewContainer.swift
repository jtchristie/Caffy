//
//  MapViewContainer.swift
//  Caffy
//
//  Created by Jonathan Christie on 2/26/20.
//  Copyright © 2020 Jonathan Christie. All rights reserved.
//

import Foundation
import MapKit

class MapViewContainer: ObservableObject {

    @Published public private(set) var mapView = MKMapView(frame: .zero)
    
    @Published public var cafes: [MKAnnotation] = []

}
