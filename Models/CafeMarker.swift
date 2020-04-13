import MapKit
import SwiftUI
import Contacts

class CafeMarker: NSObject, MKAnnotation{
  let title: String?
  let locationName: String
  let coordinate: CLLocationCoordinate2D
  let open: Bool?
  var openString: String
    init(title: String, locationName: String, open: Bool?, openString: String, coordinate: CLLocationCoordinate2D) {
    self.title = title
    self.locationName = locationName
    self.coordinate = coordinate
    self.open = open
    
    if open == true{
        self.openString = "Open"
    } else {
        self.openString = "Closed"
    }
    super.init()
  }
  
  var subtitle: String? {
    return "\(locationName)    \(String(describing: openString))"
  }
    var mapItem: MKMapItem? {
      let location = locationName 
      
      let addressDict = [CNPostalAddressStreetKey: location]
      let placemark = MKPlacemark(
        coordinate: coordinate,
        addressDictionary: addressDict)
      let mapItem = MKMapItem(placemark: placemark)
      mapItem.name = title
      return mapItem
    }
    
    var markerTintColor: UIColor  {
      switch title {
      case "Starbucks":
        return UIColor(red: 0.0118, green: 0.4, blue: 0.2078, alpha: 1.0)
      case "Dunkin'":
        return UIColor(red: 1, green: 0.4039, blue: 0.1216, alpha: 1.0)
      case "Irving Farm New York":
        return UIColor(red:0.00, green:0.00, blue:0.00, alpha:1.0)
      
      default:
        return UIColor(red: 3, green: 102, blue: 53, alpha: 1)

      }
    }
}


