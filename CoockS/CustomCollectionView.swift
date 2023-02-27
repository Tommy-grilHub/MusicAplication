//
//  CollectionViewCell.swift
//  CoockS
//
//  Created by BigSynt on 22.12.2022.
//  Copyright © 2022 BigSynt. All rights reserved.
//

import UIKit
import SnapKit

class CustomCollectionView: UICollectionViewCell {
    static let identifier = "CustomCollectionView"
    
    var imageLogo = CustomImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.clear
        contentView.addSubview(imageLogo)
        configureCard()
    }
    
    func configureCard() {
        configureImageLogo()
        setImageConstraints()
    }
    
    func configureImageLogo() {
        imageLogo.layer.cornerRadius = 10
        imageLogo.clipsToBounds = true
        //imageLogo.bounds = CGRect(x: 0, y: 0, width: 150, height: 150)
        //transformToLarge()
    }
    
    func setImageConstraints() {
        //imageLogo.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        imageLogo.translatesAutoresizingMaskIntoConstraints = false
        imageLogo.contentMode = .scaleAspectFill
        imageLogo.snp.makeConstraints { maker in
            maker.top.left.equalToSuperview().inset(20)
        }
        //imageLogo.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        //imageLogo.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        //imageLogo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        //imageLogo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        //imageLogo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
