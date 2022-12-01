//
//  ViewModel.swift
//  MusicAppMVVM
//
//  Created by Consultant on 11/28/22.
//

import Foundation

//protocol  MusicAppViewModelType{
////    func fetchMusicResults()
////    func fetchSongImage(urlSongImg : String)->Data?
////    func songName(for index : Int) ->String?
//////    func bind
//
//}


class MusicAppViewModel {
    typealias UpdateHandler = (() -> Void)
    let network = Network()
    let myGlobalConstants = MyGlobalConstats()
    var updateHandler: UpdateHandler?
    var results1 : [Songs] = []
    var images : [Data] = []
    
//    func bind(completion: @escaping UpdateHandler) {
//        print("store ref of binding in ViewModel")
//        self.updateHandler = completion
//    }
    
//    func fetchMusicResults(){
////       let ViewC = self.TMAViewController
//        self.network.fetchMainStruct(url1: self.myGlobalConstants.songsUrl) { MainsStruct in
//            guard let MainsStruct = MainsStruct?.feed.results else {return}
//            DispatchQueue.main.async {
//                self.results1 = MainsStruct
//
//                self.updateHandler?()
//
//            }
//        }
//    }
//    var counter : Int {
//        guard let anonima = TopMusicViewController().results else {return Int(2)}
//         let anonima1 = anonima.count
//       return anonima1
//    }
    
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
