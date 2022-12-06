//
//  NetworkManager2.swift
//  MusicAppMVVM
//
//  Created by Consultant on 11/27/22.
//

import Foundation

final class Network{
    
    let session : URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    
    func fetchMainStruct( url1 : String , completion : @escaping (MainsStruct?)->Void){
        
        
        guard let url1 = URL(string: url1) else {completion(nil); return }
        
        
        
        let task = self.session.dataTask(with: url1) { data, response, error in
            
            guard let data = data else{
                completion(nil)
                return
            }
            
            
            do {
                let musicAlbum  = try JSONDecoder().decode(MainsStruct.self, from: data)
                completion(musicAlbum)
            }catch {
                print(error)
                completion(nil)
                
            }
        }
        task.resume()
    }
    
    func fetchImageData(path: String, completion: @escaping (Data?) -> Void)  {
        guard let url = URL(string: path) else{
            completion(nil)
            return
        }
        
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            _ = response as? HTTPURLResponse
                
            if let _ = error {
                completion(nil)
                return
            }
            
            completion(data)
            
        }
        task.resume()
//        return self.tempID!
    }
    
    func fetchResults (returnAtCompletion : @escaping(MainsStruct?) ->Void) {
        guard let url1 =  URL(string: MyGlobalConstats().songsUrl ) else {return}
        
        URLSession.shared.dataTask(with: url1) { data, resoponse, error in
            guard let data = data else {return}
            
            do{
                returnAtCompletion(try JSONDecoder().decode(MainsStruct.self, from: data)
                )
            }catch{
                print("Problems whith un perfectland")
                returnAtCompletion(nil)
            }
        }
        .resume()
    }
}
