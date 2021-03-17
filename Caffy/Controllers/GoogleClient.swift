
//GoogleClient.swift
import Foundation
import CoreLocation

protocol GoogleClientRequest {
    var googlePlacesKey : String { get set }
    func getGooglePlacesData(forKeyword keyword: String, location: CLLocation,withinMeters radius: Int, using completionHandler: @escaping (GooglePlacesResponse) -> ())
}

class GoogleClient: GoogleClientRequest {
    
    let session = URLSession(configuration: .default)
    var googlePlacesKey: String = "API_KEY"
     
    func getGooglePlacesData(forKeyword keyword: String, location: CLLocation, withinMeters radius: Int, using completionHandler: @escaping (GooglePlacesResponse) -> ())  {
         
        let url = googlePlacesDataURL(forKey: googlePlacesKey, location: location, keyword: keyword)
         let task = session.dataTask(with: url) { (responseData, _, error) in
             if let error = error {
                print(error.localizedDescription)
                  return
             }
          guard let data = responseData, let response = try? JSONDecoder().decode(GooglePlacesResponse.self, from: data) else {
                        completionHandler(GooglePlacesResponse(results:[]))
                        return
                    }
            completionHandler(response)
            print("complete")
        }
        task.resume()
        print(url)
        print("resume")
        print("task", task)

    }
    
    
    func googlePlacesDataURL(forKey apiKey: String, location: CLLocation, keyword: String) -> URL {
    
         let baseURL = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?type=cafe"
         let locationString = "location=" +     String(location.coordinate.latitude) + "," + String(location.coordinate.longitude)
         let radius = "radius=700"
         let keywrd = "keyword=" + keyword
         let key = "key=" + apiKey
    
         return URL(string: baseURL + "&" + locationString + "&" + radius + "&" + keywrd + "&" + key)!
    }
    
}
