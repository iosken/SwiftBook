//
//  RandomUser.swift
//  SwiftBook
//
//  Created by Yuri Volegov on 31.05.2023.
//

import Foundation


struct Contact: Decodable {
    let gender: String
    let name: Name
    let location: Location
    let email: String
    let login: Login
    let dob: Dob
    let registered: Registered
    let phone: String
    let cell: String
    let id: UserID
    let picture: Picture
    let nat: String
    
    init(data: [String: Any]) {
        let genderData = data["gender"] as? String ?? ""
        self.gender = genderData
        
        let nameData = data["name"] as? [String: String] ?? [:]
        self.name = Name(data: nameData)
        
        let locationData = data["location"] as? [String: Any] ?? [:]
        self.location = Location(data: locationData)
        
        let emailData = data["email"] as? String ?? ""
        self.email = emailData
        
        let loginData = data["login"] as? [String: String] ?? [:]
        self.login = Login(data: loginData)
        
        let dobData = data["dob"] as? [String : Any] ?? [:]
        self.dob = Dob(data: dobData)
        
        let registredData = data["registered"] as? [String : Any] ?? [:]
        self.registered = Registered(data: registredData)
        
        let phoneData = data["phone"] as? String ?? ""
        self.phone = phoneData
        
        self.cell = data["cell"] as? String ?? ""
        
        let idData = data["id"] as? [String : Any] ?? [:]
        self.id = UserID(data: idData)
        
        let pictureData = data["picture"] as? [String : String] ?? [:]
        self.picture = Picture(data: pictureData)
        
        let natData = data["nat"] as? String ?? ""
        self.nat = natData
    }
    
}

extension Contact: ParsingCollection {
    static func getData(from value: Any) -> [Contact] {
        guard let value = value as? [String: Any] else { return []}
        guard let contacts = value["results"] as? [[String: Any]] else { return [] }
        
        return contacts.compactMap { Contact(data: $0) }
    }
    
}

struct Name: Decodable {
    let title: String
    let first: String
    let last: String
    
    init(data: [String: String]) {
        self.title = data["title"] ?? ""
        self.first = data["first"] ?? ""
        self.last = data["last"] ?? ""
    }
}

struct Location: Decodable {
    let street: Street
    let city: String
    let state: String
    let country: String
    let postcode: Int
    let coordinates: Coordinates
    let timezone: Timezone
    
    init(data: [String: Any]) {
        let streetData = data["street"] as? [String: Any] ?? [:]
        self.street = Street(data: streetData)
        
        self.city = data["city"] as? String ?? ""
        self.state = data["state"] as? String ?? ""
        self.country = data["country"] as? String ?? ""
        self.postcode = data["postcode"] as? Int ?? 0
        
        let coordinatesData = data["coordinates"] as? [String: String] ?? [:]
        self.coordinates = Coordinates(data: coordinatesData)
        
        let timezoneData = data["timezone"] as? [String: String] ?? [:]
        self.timezone = Timezone(data: timezoneData)
    }
}

struct Street: Decodable {
    let number: Int
    let name: String
    
    init(data: [String: Any]) {
        let numberData = data["number"] as? Int ?? 0
        self.number = numberData
        
        let nameData = data["name"] as? String ?? ""
        self.name = nameData
    }
}

struct Coordinates: Decodable {
    let latitude: String
    let longitude: String
    
    init(data: [String: String]) {
        self.latitude = data["latitude"] ?? ""
        self.longitude = data["longitude"] ?? ""
    }
}

struct Timezone: Decodable {
    let offset: String
    let description: String
    
    init(data: [String: String]) {
        self.offset = data["offset"] ?? ""
        self.description = data["description"] ?? ""
    }
}

struct Login: Decodable {
    let uuid: String
    let username:String
    let password: String
    let salt: String
    let md5: String
    let sha1: String
    let sha256: String
    
    init(data: [String: String]) {
        self.uuid = data["uuid"] ?? ""
        self.username = data["username"] ?? ""
        self.password = data["password"] ?? ""
        self.salt = data["salt"] ?? ""
        self.md5 = data["md5"] ?? ""
        self.sha1 = data["sha1"] ?? ""
        self.sha256 = data["sha256"] ?? ""
    }
}

struct Dob: Decodable {
    let date: String
    let age: Int
    
    init(data: [String: Any]) {
        let dateData = data["date"] as? String ?? ""
        self.date = dateData
        
        let ageData = data["age"] as? Int ?? 0
        self.age = ageData
    }
}

struct Registered: Decodable {
    let date: String
    let age: Int
    
    init(data: [String: Any]) {
        let dateData = data["date"] as? String ?? ""
        self.date = dateData
        
        let ageData = data["age"] as? Int ?? 0
        self.age = ageData
    }
}

struct UserID: Decodable {
    let name: String
  //  let value: Any?
    
    init(data: [String: Any]) {
        
        let nameData = data["name"] as? String ?? ""
        self.name = nameData
        
   //     self.value = data["value"]
    }
}

struct Picture: Decodable, Parsing {

    let large: String
    let medium: String
    let thumbnail: String
    
    init(data: [String: Any]) {
        self.large = data["large"] as? String ?? ""
        self.medium = data["medium"] as? String ?? ""
        self.thumbnail = data["thumbnail"] as? String ?? ""
    }
    
    static func getData(from value: Any) -> Picture {
        guard let data = value as? [String: Any] else { return Picture(data: [:]) }
        
        return Picture(data: data)
    }
}

//https://randomuser.me/api/

//{
//    "results": [
//        {
//            "gender": "male",
//            "name": {
//                "title": "Mr",
//                "first": "Cooper",
//                "last": "Smith"
//            },
//            "location": {
//                "street": {
//                    "number": 5803,
//                    "name": "Market Street"
//                },
//                "city": "Lower Hutt",
//                "state": "Waikato",
//                "country": "New Zealand",
//                "postcode": 90418,
//                "coordinates": {
//                    "latitude": "54.7101",
//                    "longitude": "-140.1725"
//                },
//                "timezone": {
//                    "offset": "+7:00",
//                    "description": "Bangkok, Hanoi, Jakarta"
//                }
//            },
//            "email": "cooper.smith@example.com",
//            "login": {
//                "uuid": "4ac986de-600f-400e-9c70-4ef798186881",
//                "username": "lazybird370",
//                "password": "shui",
//                "salt": "zdd9ab6Z",
//                "md5": "8f4c838dd27c709e068290f777aeec9e",
//                "sha1": "23d141e5de70bd040736baa44f27f5c3950729d5",
//                "sha256": "d237ce26ac13081926bcaee0ab19f91420191657f16b39af486efc490f8af9ff"
//            },
//            "dob": {
//                "date": "1996-03-10T18:35:38.541Z",
//                "age": 27
//            },
//            "registered": {
//                "date": "2021-12-24T11:53:55.979Z",
//                "age": 1
//            },
//            "phone": "(550)-545-5140",
//            "cell": "(061)-843-9927",
//            "id": {
//                "name": "",
//                "value": null
//            },
//            "picture": {
//                "large": "https://randomuser.me/api/portraits/men/48.jpg",
//                "medium": "https://randomuser.me/api/portraits/med/men/48.jpg",
//                "thumbnail": "https://randomuser.me/api/portraits/thumb/men/48.jpg"
//            },
//            "nat": "NZ"
//        }
//    ],
//    "info": {
//        "seed": "59e620eb548b65b3",
//        "results": 1,
//        "page": 1,
//        "version": "1.4"
//    }
//}
