//
//  DetailViewController.swift
//  MusicAppMVVM
//
//  Created by Consultant on 11/22/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    var results1 : [Songs]?
    var index : Int?
    var idRecived : Int?
    var dicIdResultsRec : [Int : Songs] = [:]
    var Likelist1 : [Int : Bool] = [:]
    

    
    var likeButtom : UISwitch = {
        let also = UISwitch(frame: .zero)
        also.translatesAutoresizingMaskIntoConstraints = false
        also.backgroundColor = .clear
        return also
    }()
    
    lazy var songNameLabel : UILabel = {
        let name1 = UILabel(frame: .zero)
        name1.translatesAutoresizingMaskIntoConstraints = false
        name1.backgroundColor = .cyan
        name1.numberOfLines = 0
        guard let index = self.index else {return name1}
        let songName = self.results1?[index].name
        name1.text = songName
        return name1
        
    }()
    lazy var artist : UILabel = {
        let name = UILabel(frame: .zero)
        name.translatesAutoresizingMaskIntoConstraints = false
        name.backgroundColor = .cyan
        name.numberOfLines = 0
        guard let index = self.index else {return name}
        let artist = self.results1?[index].artistName
        name.text = artist
        return name
        
    }()
    
    lazy var Geneder : UILabel = {
        let name = UILabel(frame: .zero)
        name.translatesAutoresizingMaskIntoConstraints = false
        name.backgroundColor = .cyan
        name.numberOfLines = 0
        guard let geners = self.results1?[self.index!].genres else {return name}
        name.text = "\(geners.compactMap{$0.name})"
        return name
        
    }()
    
    lazy var releaseDate : UILabel = {
        let name = UILabel(frame: .zero)
        name.text = "Domi Tex"
        name.translatesAutoresizingMaskIntoConstraints = false
        name.backgroundColor = .cyan
        name.numberOfLines = 0
        guard let date = self.results1?[self.index!].releaseDate else {return name}
        name.text = date
        return name
        
    }()
    
    
    lazy var songImage : UIImageView = {
        let image = UIImageView(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .lightGray
        image.image = UIImage(named: "ImgDemo2")
        return image
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCell()
//        self.results1 =

        
    }
    func setUpCell(){
        view.backgroundColor = .blue
//        view.safeAreaLayoutGuide.backgroundColor = .brown
        
//        contentView.addSubview(self.songImage)
        view.addSubview(self.songNameLabel)
        view.addSubview(self.songImage)
        view.addSubview(self.likeButtom)
        view.addSubview(self.artist)
        view.addSubview(self.Geneder)
        view.addSubview(self.releaseDate)
        
        
    
       
        
        self.songImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        self.songImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true

        self.songImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true



        self.songNameLabel.topAnchor.constraint(equalTo: self.songImage.bottomAnchor, constant: 8).isActive = true
        self.songNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.songNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        
        
        self.artist.topAnchor.constraint(equalTo: self.songNameLabel.bottomAnchor, constant: 8).isActive = true
        self.artist.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.artist.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        
        
        self.Geneder.topAnchor.constraint(equalTo: self.artist.bottomAnchor, constant: 8).isActive = true
        self.Geneder.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.Geneder.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        
        self.releaseDate.topAnchor.constraint(equalTo: self.Geneder.bottomAnchor, constant: 8).isActive = true
        self.releaseDate.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.releaseDate.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        self.releaseDate.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true

        self.likeButtom.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        self.likeButtom.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -0).isActive = true
        self.likeButtom.layer.opacity = 0.6
//        self.likeButtom.inputViewController?.rotatingFooterView()
//        self.likeButtom.transform = CGAffineTransformMakeRotation(-3.1416/180*90); // 90 degrees
        guard let ind = self.index else {return}
//        self.songNameLabel.text = "path id\(self.results1?[ind].id ?? "2") pass id \(self.idRecived!)"
        Network().fetchImageData(path: self.results1?[ind].artworkUrl100 ??  MyGlobalConstats().defaultURL) { data in
            guard let data = data else {return}
            print(data)
            DispatchQueue.main.async {
                self.songImage.image = UIImage(data: data)
                
                guard let index = self.index else {return}
                self.likeButtom.isOn = self.Likelist1[index] ?? true

            }
            
        }
//        printContent(self.index)fa

    }
   
    
}
