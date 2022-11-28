//
//  MusicStructure.swift
//  MusicAppMVVM
//
//  Created by Consultant on 11/22/22.
//

import Foundation

struct MainsStruct : Decodable {
    
    var feed : Results
    
}


struct Results : Decodable {
    
    var results : [Songs]
    
}

struct Songs : Decodable {
    
    var artistName  : String
    var id          : String
    var name        : String
    var releaseDate : String
    var kind        : String
    var artworkUrl100 : String
    var genres     : [Names]
    
}


struct Names : Decodable {

    var name : String

}
