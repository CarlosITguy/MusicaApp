//
//  MusicCollectionViewCell.swift
//  MusicAppMVVM
//
//  Created by Consultant on 11/22/22.
//

import UIKit

class MusicCollectionViewCell: UICollectionViewCell {
//
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
   
        return image
        
    }()
    
    var movieID: Int?
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        self.setUpCell()
        
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    
    func setUpCell(){
        backgroundColor = .blue
        contentView.backgroundColor = .brown
        
//        contentView.addSubview(self.songImage)
        contentView.addSubview(self.songNameLabel)
        contentView.addSubview(self.songImage)
        contentView.addSubview(self.likeButtom)
        
        
    
       
        
        self.songImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        self.songImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        self.songImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50).isActive = true
        self.songImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true

        self.songImage.widthAnchor.constraint(equalToConstant: 150).isActive = true
        self.songImage.heightAnchor.constraint(equalToConstant: 100).isActive = true

        self.songNameLabel.topAnchor.constraint(equalTo: self.songImage.bottomAnchor, constant: 8).isActive = true
        self.songNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        self.songNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        self.songNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        
        self.likeButtom.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        self.likeButtom.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -0).isActive = true
        self.likeButtom.layer.opacity = 0.6
//        self.likeButtom.inputViewController?.rotatingFooterView()
        self.likeButtom.transform = CGAffineTransformMakeRotation(-3.1416/180*90); // 90 degrees

    }
//    @objc func switchLike(){
//        
//    
//    }
    
    
    
}
