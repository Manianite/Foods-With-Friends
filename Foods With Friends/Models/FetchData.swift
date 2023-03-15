//
//  FetchData.swift
//  Foods With Friends
//
//  Created by Julia Zorc (student LM) on 3/14/23.
//

import Foundation

class FetchData: ObservableObject{
    
    @Published var response = Response()
    
    func getData(_ query: String) async{
        let URLString = "https://api.spoonacular.com/food/restaurants/search?query=\(query)&lat=40.0&lng=-75.0&distance=50&apiKey=5bda8656862e4cc6a0ec14511cc56fae"
        guard let url = URL(string: URLString) else {return}
        
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let dataString = String(data: data, encoding: .utf8)
            print(dataString)
            
            let response = try JSONDecoder().decode(Response.self, from: data)
           // print(response.restaurants[0].name)
            
            self.response = response
        } catch {
            print(error)
        }

    }
}

struct Response: Codable{
    var restaurants: [Restaurant] = []
}

struct Restaurant: Codable{
    var name: String = ""
    var address: Address = Address()
    var cuisines: [String] = [""]
    var logo_photos: [String] = [""]
    var is_open: Bool = false
}

struct Address: Codable{
    var state: String = ""
    var city: String = ""
    var street_addr: String = ""
}

extension Restaurant: Identifiable{
    var id: String {name+address.street_addr}
}
