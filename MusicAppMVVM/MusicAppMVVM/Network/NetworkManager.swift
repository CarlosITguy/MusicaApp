//
//  NetworkManager.swift
//  MusicAppMVVM
//
//  Created by Consultant on 11/27/22.
//

import Foundation


class NetworkManager {
    
    let session: URLSession
    let decoder: JSONDecoder
    
    init(session: URLSession = URLSession.shared,
         decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }
    
}


extension NetworkManager : NetworkManagerType {
    
    func fetchModel<W>(request1: URLRequest?, completion: @escaping (Result<W, NetworkError>) -> Void) where W : Decodable {
        
        guard let request = request1 else {
            completion(.failure(.badURL))
            return
        }
        
        self.session.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(.failure(.serverError(error)))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse,
               !(200..<300).contains(httpResponse.statusCode) {
                completion(.failure(.badStatusCode(httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            
            do {
                let model = try self.decoder.decode(W.self, from: data)
                completion(.success(model))
            } catch {
                if let decodeError = error as?  DecodingError {
                    completion(.failure(.decodeFailure(decodeError)))
                } else {
                    completion(.failure(.other(error)))
                }
            }
            
        }.resume()
        
    }
    
    func fetchDataRaw(request2: URLRequest?, completion: @escaping (Result<Data, Error>) -> Void) {
        return
    }
    
}
