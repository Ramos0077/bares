//
//  Bar.swift
//  Meu primeiro app
//
//  Created by Jonathan on 03/02/20.
//  Copyright © 2020 hbsis. All rights reserved.
//
import UIKit
import os.log

class Bar: NSObject, NSCoding {
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let photo = aDecoder.decodeObject(forKey: PropertyKey.photo)as? UIImage else{
            os_log("Erro photo",log:OSLog.default,type:.debug)
            return nil
        }
        guard let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)as? Int else{
            os_log("Erro rating",log:OSLog.default,type:.debug)
            return nil
        }
        guard let latitude = aDecoder.decodeFloat(forKey: PropertyKey.latitude)as? Float else{
            os_log("Erro latitude",log:OSLog.default,type:.debug)
            return nil
        }
        guard let longitude = aDecoder.decodeFloat(forKey: PropertyKey.longitude)as? Float else{
            os_log("Erro longitude",log:OSLog.default,type:.debug)
            return nil
        }
        guard let telefone = aDecoder.decodeObject(forKey: PropertyKey.telefone)as? String else{
            os_log("Erro telefone",log:OSLog.default,type:.debug)
            return nil
        }
    
        // Must call designated initializer.
        self.init(name: name, photo: photo, rating: rating, latitude: latitude, longitude:longitude, telefone: telefone)
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(rating, forKey: PropertyKey.rating)
        aCoder.encode(telefone, forKey: PropertyKey.telefone)
        aCoder.encode(longitude,forKey: PropertyKey.longitude)
        aCoder.encode(latitude, forKey: PropertyKey.latitude)

        
    }
    
    
    //MARK: Properties
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    
    
    //MARK: Types
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
        static let telefone = "telefone"
        static let endereco = "endereco"
        static let longitude = "longitude"
        static let latitude = "latitude"
    }
    
    var name: String
    var photo: UIImage?
    var rating: Int
    var latitude: Float
    var longitude: Float
    var telefone: String
    
    //MARK: Initialization
    
    init?(name: String, photo: UIImage?, rating: Int, latitude:  Float, longitude:  Float, telefone: String) {
        
        if telefone.isEmpty || telefone.count < 0 || telefone.count > 18 {
            return nil
        }
        
        if name.isEmpty || rating < 0 || rating > 5 {
            return nil
        }
    
    self.name = name
    self.photo = photo
    self.rating = rating
    self.latitude = latitude
    self.longitude = longitude
    self.telefone = telefone
    
    
   }
  
}
