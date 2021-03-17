//
//  CafeViews.swift
//  Caffy
//
//  Created by Jonathan Christie on 2/19/20.
//  Copyright © 2020 Jonathan Christie. All rights reserved.
//

import Foundation
import MapKit

class CafeMarkerView: MKMarkerAnnotationView {
  override var annotation: MKAnnotation? {
    willSet {
      // 1
      guard let cafe = newValue as? CafeMarker else { return }
      canShowCallout = true
      calloutOffset = CGPoint(x: -5, y: 5)
      self.displayPriority = .required
      rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
      // 2
      markerTintColor = cafe.markerTintColor
        glyphText = String((cafe.title?.first!)!)
    }
  }
}
