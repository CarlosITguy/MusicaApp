//
//  File.swift
//  MusicAppMVVM
//
//  Created by Consultant on 11/27/22.
//

import Foundation

protocol NetworkManagerType {
    
    func fetchModel <W> (request1 : URLRequest? , completion: @escaping (Result <W , NetworkError >) -> Void) where W: Decodable
    
    func fetchDataRaw (request2: URLRequest? , completion: @escaping (Result <Data , Error >)-> Void )
    
    
    
}
