//
//  ViewModel.swift
//  MusicAppMVVM
//
//  Created by Consultant on 11/28/22.
//

import Foundation



class MusicAppViewModel {
    typealias UpdateHandler = (() -> Void)
    let network = Network()
    var refreshData = {() -> () in }
    let myGlobalConstants = MyGlobalConstats()
    var updateHandler: UpdateHandler?
    var results1 : [Songs] = []{
        didSet{
            refreshData()
        }
    }
    var images : [Data] = []
    
//
    
    func litleFunc(){
        print("View wiil appear this moment")
        self.fetchResults(){allAboutMusic in
//            print("\(allAboutMusic?.feed.results) we mad it work")
            guard let results = allAboutMusic?.feed.results else {return}
            self.results1 = results
//            print("\(self.results1) we mad it work")
            DispatchQueue.main.async {
                self.refreshData()
                TopMusicViewController().collectionView1?.reloadData()
            }
         
           
        }
        
        
    }
    
    
    
    func fetchResults (returnAtCompletion : @escaping(MainsStruct?) ->Void) {
        guard let url1 =  URL(string:self.myGlobalConstants.songsUrl ) else {return}
        
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
    
    
    
    func imageData(for index: Int, completion: @escaping (Data?) -> Void) {
//        var datta : Data?
//        guard index < self.counter else { return }
        guard let urlImgDat = TopMusicViewController().results?[index].artworkUrl100 else {return}
        
        self.network.fetchImageData(path: urlImgDat) { Data in
            guard let Data = Data else {return}
            self.images[index] = Data
            
        }
        
    }
        
    
}
