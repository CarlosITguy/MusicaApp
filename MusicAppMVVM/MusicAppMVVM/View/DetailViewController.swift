//
//  DetailViewController.swift
//  MusicAppMVVM
//
//  Created by Consultant on 11/22/22.
//

import UIKit

class DetailViewController: UIViewController {
    let musicAppViewModel = MusicAppViewModel()
    var index : Int = 0
    var idRecived : Int?
    var Likelist1 : Bool  = true
    //    var songName : String = "ups recive problems"
    //    var artista : String = "ups recive problems"
    
    
    
    
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
        name1.text = "self.songName"
        //
        return name1
        
    }()
    
    
    lazy var artistName : UILabel = {
        let artist = UILabel(frame: .zero)
        artist.translatesAutoresizingMaskIntoConstraints = false
        artist.backgroundColor = .cyan
        artist.numberOfLines = 0
        //        artist.text = artista
        //        guard let index = self.index else {return name}
        //        let artist = self.results1?[index].artistName
        //        name.text = artist
        return artist
        
    }()
    
    lazy var Geneder : UILabel = {
        let name = UILabel(frame: .zero)
        name.translatesAutoresizingMaskIntoConstraints = false
        name.backgroundColor = .cyan
        name.numberOfLines = 0
        
        return name
        
    }()
    
    lazy var releaseDate : UILabel = {
        let name = UILabel(frame: .zero)
        name.text = "Domi Tex"
        name.translatesAutoresizingMaskIntoConstraints = false
        name.backgroundColor = .cyan
        name.numberOfLines = 0
        
        return name
        
    }()
    
    
    lazy var songImage : UIImageView = {
        let image = UIImageView(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .lightGray
        image.image = UIImage(named: "ImgDemo2")
        return image
        
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will apear")
        setUpCell()
        
        //        print(self.coreDataMusic.recoverdata)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        self.results1 =
        
        
    }
    func setUpCell(){
        view.backgroundColor = .blue
        //        view.safeAreaLayoutGuide.backgroundColor = .brown
        
        //        contentView.addSubview(self.songImage)
        view.addSubview(self.songNameLabel)
        view.addSubview(self.songImage)
        view.addSubview(self.likeButtom)
        view.addSubview(self.artistName)
        view.addSubview(self.Geneder)
        view.addSubview(self.releaseDate)
        
        
        
        
        
        self.songImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        self.songImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        
        self.songImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        
        
        
        self.songNameLabel.topAnchor.constraint(equalTo: self.songImage.bottomAnchor, constant: 8).isActive = true
        self.songNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.songNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        
        
        self.artistName.topAnchor.constraint(equalTo: self.songNameLabel.bottomAnchor, constant: 8).isActive = true
        self.artistName.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.artistName.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        
        
        self.Geneder.topAnchor.constraint(equalTo: self.artistName.bottomAnchor, constant: 8).isActive = true
        self.Geneder.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.Geneder.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        
        self.releaseDate.topAnchor.constraint(equalTo: self.Geneder.bottomAnchor, constant: 8).isActive = true
        self.releaseDate.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.releaseDate.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        self.releaseDate.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        
        self.likeButtom.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        self.likeButtom.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -0).isActive = true
        self.likeButtom.layer.opacity = 0.6
        // != nil
        self.likeButtom.tag = index
        self.likeButtom.addTarget(self, action: #selector(self.switchStateDidChange(_:)), for: .valueChanged)
        
    }
    @objc func switchStateDidChange(_ sender : UISwitch)   {
        print(sender.tag)
        print(self.index)
//        self.musicAppViewModel.forSwitch(senderIsOn: sender.isOn, senderTag: index)
        
    }
    
}
