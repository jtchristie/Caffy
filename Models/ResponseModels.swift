
import Foundation
import CoreLocation
import MapKit

import Foundation
struct GooglePlacesResponse : Codable {
    let results : [Place]
    enum CodingKeys: String,CodingKey {
        case results = "results"
    }
}
class Place : Codable, Identifiable {
    let geometry : Location
    let name : String
    let openingHours : OpenNow?
    let photos : [PhotoInfo]
    let types : [String]
    let address : String
    
    
    enum CodingKeys : String, CodingKey {
        case geometry = "geometry"
        case name = "name"
        case openingHours = "opening_hours"
        case photos = "photos"
        case types = "types"
        case address = "vicinity"
    }
    struct Location : Codable {
        let location : LatLong
        enum CodingKeys: String, CodingKey {
            case location = "location"
        }
        
        struct LatLong: Codable {
            
            let latitude : Double
            let longitude : Double
            enum CodingKeys : String, CodingKey {
                case latitude = "lat"
                case longitude = "lng"
            }
        }
    }
    struct OpenNow: Codable {
        let open : Bool
        enum CodingKeys : String, CodingKey {
            case open = "open_now"
        }
    }
    struct PhotoInfo : Codable {
        let height : Int
        let width : Int
        let photoReference : String
        enum CodingKeys : String, CodingKey {
            case height = "height"
            case width = "width"
            case photoReference = "photo_reference"
        }
    }
}
