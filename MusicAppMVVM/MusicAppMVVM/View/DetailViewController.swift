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
    
    
    var likeButtom : UISwitch = {
        let also = UISwitch(frame: .zero)
        also.translatesAutoresizingMaskIntoConstraints = false
//        also.state = false
        also.backgroundColor = .clear
        return also
    }()
    
    lazy var songNameLabel : UILabel = {
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
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCell()
//        self.results1 = TopMusicViewController().results
        print("Some")
        print(results1 as Any)
        print(TopMusicViewController().results as Any)

        
    }
    func setUpCell(){
        view.backgroundColor = .blue
//        view.safeAreaLayoutGuide.backgroundColor = .brown
        
//        contentView.addSubview(self.songImage)
        view.addSubview(self.songNameLabel)
        view.addSubview(self.songImage)
        view.addSubview(self.likeButtom)
        
        
    
       
        
        self.songImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        self.songImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.songImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        self.songImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true

        self.songImage.widthAnchor.constraint(equalToConstant: 150).isActive = true
        self.songImage.heightAnchor.constraint(equalToConstant: 100).isActive = true

        self.songNameLabel.topAnchor.constraint(equalTo: self.songImage.bottomAnchor, constant: 8).isActive = true
        self.songNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.songNameLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        self.songNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        
        self.likeButtom.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        self.likeButtom.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -0).isActive = true
        self.likeButtom.layer.opacity = 0.6
//        self.likeButtom.inputViewController?.rotatingFooterView()
//        self.likeButtom.transform = CGAffineTransformMakeRotation(-3.1416/180*90); // 90 degrees
        guard let ind = self.index else {return}
        self.songNameLabel.text = self.results1?[ind].name
        Network().fetchImageData(path: self.results1?[ind].artworkUrl100 ??  TopMusicViewController().defaultURL) { data in
            guard let data = data else {return}
            print(data)
            DispatchQueue.main.async {
                self.songImage.image = UIImage(data: data)

            }
            
        }

    }
   
    
}
