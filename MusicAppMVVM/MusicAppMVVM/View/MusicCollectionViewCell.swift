//
//  MusicCollectionViewCell.swift
//  MusicAppMVVM
//
//  Created by Consultant on 11/22/22.
//

import UIKit

class MusicCollectionViewCell: UICollectionViewCell {
    
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
//        addSubview(self.songNameLabel)
        contentView.addSubview(self.songImage)
        

        
        self.songImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        self.songImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        self.songImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        self.songImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true

        self.songImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        self.songImage.heightAnchor.constraint(equalToConstant: 100).isActive = true

        
    }
    
    
    
    
}
