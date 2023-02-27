//
//  CustomCell.swift
//  CoockS
//
//  Created by BigSynt on 10.09.2022.
//  Copyright © 2022 BigSynt. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    //static let identifier = "CustomCell"
    
    //@IBOutlet var imageLogo: CustomImageView!
    //@IBOutlet var nameTrack: UILabel!
    //@IBOutlet var nameArtist: UILabel!
    var imageLogo = CustomImageView()
    var nameTrack = UILabel()
    var nameArtist = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(imageLogo)
        addSubview(nameTrack)
        addSubview(nameArtist)
        cofigureCell()
        //contentView.backgroundColor = .orange
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//
//        cofigureCell()
//    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }

    func cofigureCell() {
        let selectViewColor = UIView()
        selectViewColor.backgroundColor = #colorLiteral(red: 0.09635987133, green: 0.09594345838, blue: 0.09668751806, alpha: 1)
        selectedBackgroundView = selectViewColor
        configureImageLogo()
        configureNameTrack()
        configureNameArtist()
        setImageConstraints()
        setLabelConstraints()
        backgroundColor = #colorLiteral(red: 0.04136680067, green: 0.04138204455, blue: 0.04136478156, alpha: 1)
    }
    
    func configureImageLogo() {
        imageLogo.layer.cornerRadius = 3
        imageLogo.clipsToBounds = true
    }
    
    func configureNameTrack() {
        nameTrack.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        nameTrack.adjustsFontSizeToFitWidth = true
        nameTrack.font = UIFont.systemFont(ofSize: 17)
    }
    
    func configureNameArtist() {
        nameArtist.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        nameArtist.adjustsFontSizeToFitWidth = true
        nameArtist.font = UIFont.systemFont(ofSize: 15)
    }
    
    func setImageConstraints() {
        imageLogo.translatesAutoresizingMaskIntoConstraints = false
        imageLogo.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageLogo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        imageLogo.heightAnchor.constraint(equalToConstant: 55).isActive = true
        imageLogo.widthAnchor.constraint(equalToConstant: 55).isActive = true
    }
    
    func setLabelConstraints() {
        nameTrack.translatesAutoresizingMaskIntoConstraints = false
        nameTrack.leadingAnchor.constraint(equalTo: imageLogo.trailingAnchor, constant: 10).isActive = true
        nameTrack.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        nameTrack.heightAnchor.constraint(equalToConstant: 30).isActive = true
        nameTrack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true

        nameArtist.translatesAutoresizingMaskIntoConstraints = false
        nameArtist.leadingAnchor.constraint(equalTo: imageLogo.trailingAnchor, constant: 10).isActive = true
        nameArtist.topAnchor.constraint(equalTo: nameTrack.topAnchor, constant: 26).isActive = true
        nameArtist.heightAnchor.constraint(equalToConstant: 20).isActive = true
        nameArtist.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    }
    
    
    func configureFrame() {
        
        //loadingView.centerYAnchor.constraint(equalTo: blurEffectView.contentView.centerYAnchor).isActive = true
    }
    
    //обновляет фреймы
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}
