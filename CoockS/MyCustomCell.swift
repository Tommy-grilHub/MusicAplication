//
//  MyCustomCell.swift
//  CoockS
//
//  Created by BigSynt on 16.09.2022.
//  Copyright © 2022 BigSynt. All rights reserved.
//

import UIKit

class MyCustomCell: UITableViewCell {
    //static let identifier = "MyCustomCell"
    
    @IBOutlet var imageLogo: CustomImageView!
    @IBOutlet var nameTrack: UILabel!
    @IBOutlet var nameArtist: UILabel!
    //@IBOutlet var logo: Class!
    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super .init(style: style, reuseIdentifier: reuseIdentifier)
//        contentView.backgroundColor = .orange
//
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cofigureCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureImageView() {
        imageLogo.layer.cornerRadius = 10
        //
    }
    
    func cofigureCell() {
           let selectViewColor = UIView()
           selectViewColor.backgroundColor = #colorLiteral(red: 0.06737588652, green: 0.06737588652, blue: 0.06737588652, alpha: 1)
           selectedBackgroundView = selectViewColor
           nameTrack.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
           nameArtist.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
           backgroundColor = .green
       }
    
}
