//
//  enlargedViewController.swift
//  CoockS
//
//  Created by BigSynt on 10.12.2022.
//  Copyright © 2022 BigSynt. All rights reserved.
//

import UIKit
import SnapKit

class EnlargedViewController: UIViewController {
    
    var musicArray: [Music] = [Music]()
    var index = IndexPath()
    var layout = UICollectionViewFlowLayout()
    
    let collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        //let collectionView = UICollectionView(frame: .zero)
//        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
//            layout.itemSize = CGSize(width: 375/1.5, height: 375/1.5)
//            collectionView.setCollectionViewLayout(layout, animated: false)
//        })
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CustomCollectionView.self, forCellWithReuseIdentifier: "CustomCollectionView")
        let inset = CGFloat(375-375/1.7-2 * 40)/2 + CGFloat(40)
        collectionView.contentInset = .init(
            top: 0,
            left: inset,
            bottom: 0,
            right: inset
        )
        return collectionView
    }()
    
//    let collectionViewPeekingBehavior = MSCollectionViewPeekingBehavior(
//        cellSpacing: CellSpacingValue
//        cellPeekWidth: VisibleCellWidthValue
//        minimumItemsToScroll: nil,
//        maximumItemsToScroll: nil,
//        numberOfItemsToShow: 1,
//        scrollDirection: .horizontal,
//        velocityThreshold: 0.2
//    )

    var nameTrack = UILabel()
    var nameArtist = UILabel()
    
    var nextTrackButton = UIButton()
    var backTrackButton = UIButton()
    var playTrackButton = UIButton()
    
    //var imageBack = UIImage(systemName: "backward.end.fill")//, withConfiguration: UIImage.SymbolConfiguration(pointSize: 20))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        layoutConfigure()
        configureCard()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func layoutConfigure() {
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 35
        layout.minimumLineSpacing = 40
        layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        layout.itemSize = CGSize(width: 375/1.4, height: 375/1.4)
        collectionView.setCollectionViewLayout(layout, animated: false)
    }
    
    func configureCard() {
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .black
        view.addSubview(collectionView)
        view.addSubview(nameTrack)
        view.addSubview(nameArtist)
        setCollectionConstraints()
        configureNameTrack()
        configureNameArtist()
        setLabelConstraints()
        //setLabelText()
        configurePlayer()
    }
    
    func configurePlayer() {
        buttonConfigure()
    }
    
    func setLabelText() {
        let item = musicArray[index.row]
        nameTrack.text = item.nameTrack
        nameArtist.text = item.nameArtists.first?.nameArtist
    }
    
    func setCollectionConstraints() {
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 0.9).isActive = true
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
    
    func setLabelConstraints() {
        nameTrack.translatesAutoresizingMaskIntoConstraints = false
        nameTrack.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.left.equalToSuperview().inset(40)
            maker.top.equalTo(collectionView).inset(330)
        }
        nameArtist.translatesAutoresizingMaskIntoConstraints = false
        nameArtist.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.left.equalToSuperview().inset(40)
            maker.top.equalTo(nameTrack).inset(21)
        }
    }
    
    
    func buttonConfigure() {
        view.addSubview(backTrackButton)
        backTrackButton.translatesAutoresizingMaskIntoConstraints = false
        backTrackButton.setImage(UIImage(named: "backward.end.fill"), for: .normal)
        backTrackButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        backTrackButton.snp.makeConstraints { maker in
            maker.left.equalToSuperview().inset(120)
            maker.top.equalTo(nameArtist).inset(140)
        }
        backTrackButton.addTarget(self, action: #selector(onClickBackTrackButton), for: .touchUpInside)
        
        view.addSubview(nextTrackButton)
        nextTrackButton.translatesAutoresizingMaskIntoConstraints = false
        nextTrackButton.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        nextTrackButton.setImage(UIImage(named: "forward.end.fill"), for: .normal)
        nextTrackButton.snp.makeConstraints { maker in
            maker.right.equalToSuperview().inset(120)
            maker.centerY.equalTo(backTrackButton)
        }
        nextTrackButton.addTarget(self, action: #selector(onClickNextTrackButton), for: .touchUpInside)
        
        view.addSubview(playTrackButton)
        playTrackButton.layer.shadowColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        playTrackButton.layer.shadowRadius = 10
        playTrackButton.layer.shadowOpacity = 1
        playTrackButton.translatesAutoresizingMaskIntoConstraints = false
        //playTrackButton.setImage(UIImage(named: "pause.circle.fill"), for: .normal)
        playTrackButton.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.centerY.equalTo(backTrackButton)
        }
        playTrackButton.addTarget(self, action: #selector(onClickPlayTrackButton), for: .touchUpInside)
    }
    
    @objc func onClickPlayTrackButton() {
        if playTrackButton.image(for: .normal) == UIImage(named: "play.circle.fill") {
            playTrackButton.setImage(UIImage(named: "pause.circle.fill"), for: .normal)
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                self.playTrackButton.layer.shadowOpacity = 1
            })
            transformToLarge()
        } else {
            playTrackButton.setImage(UIImage(named: "play.circle.fill"), for: .normal)
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.playTrackButton.layer.shadowOpacity = 0
            })
            transformToLarge()
        }
    }
    
    @objc func onClickNextTrackButton() {
        
        if index.item < musicArray.count - 2 {
            nextTrackButton.setImage(UIImage(named: "forward.end.fill"), for: .normal)
            backTrackButton.setImage(UIImage(named: "backward.end.fill"), for: .normal)
           
            self.index = IndexPath(item: index.item + 1, section: 0)
            transformToLarge()
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                self.collectionView.selectItem(at: IndexPath(item: self.index.item, section: 0), animated: false, scrollPosition: .centeredHorizontally)
            })
            setLabelText()
        } else {
            nextTrackButton.setImage(UIImage(named: "forward.end"), for: .normal)
            self.index = IndexPath(item: musicArray.count - 1, section: 0)
            transformToLarge()
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                self.collectionView.selectItem(at: IndexPath(item: self.musicArray.count - 1, section: 0), animated: false, scrollPosition: .centeredHorizontally)
            })
            setLabelText()
        }
    }
    
    @objc func onClickBackTrackButton() {
        if index.item > 1 {
            backTrackButton.setImage(UIImage(named: "backward.end.fill"), for: .normal)
            nextTrackButton.setImage(UIImage(named: "forward.end.fill"), for: .normal)
            
            self.index = IndexPath(item: index.item - 1, section: 0)
            transformToLarge()
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                self.collectionView.selectItem(at: IndexPath(item: self.index.item, section: 0), animated: false, scrollPosition: .centeredHorizontally)
            })
            setLabelText()
        } else {
            backTrackButton.setImage(UIImage(named: "backward.end"), for: .normal)
            self.index = IndexPath(item: 0, section: 0)
            transformToLarge()
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                self.collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: .centeredHorizontally)
            })
            setLabelText()
        }
    }
    
    func indexGet(index: IndexPath) {
        self.index = index
    }
    
    func indexSet() {
        if index.item == 0 {
            backTrackButton.setImage(UIImage(named: "backward.end"), for: .normal)
            collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: .centeredHorizontally)
            setLabelText()
        } else if index.item == musicArray.count - 1 {
            nextTrackButton.setImage(UIImage(named: "forward.end"), for: .normal)
            collectionView.selectItem(at: IndexPath(item: musicArray.count - 1, section: 0), animated: false, scrollPosition: .centeredHorizontally)
            setLabelText()
        } else {
            collectionView.selectItem(at: IndexPath(item: index.item, section: 0), animated: false, scrollPosition: .centeredHorizontally)
            //self.layout.itemSize = CGSize(width: 375/3, height: 375/3)
            //collectionView.setCollectionViewLayout(self.layout, animated: false)
            setLabelText()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView is UICollectionView else { return }
        
//        let centerPoint = CGPoint(x: self.collectionView.frame.width / 2 + scrollView.contentOffset.x,
//                                  y: self.collectionView.frame.height / 2 + scrollView.contentOffset.y)
        
//        if let indexPath = self.collectionView.indexPathForItem(at: centerPoint) {
//            let customCollection = CustomCollectionView()
//            customCollection.transformToLarge()
//        }
        //print("HI")
    }
    
    func transformToLarge() {
        collectionView.reloadData()
    }
}

extension EnlargedViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("layout: \(self.layout.itemSize)")
        if indexPath == index && playTrackButton.image(for: .normal) == UIImage(named: "pause.circle.fill") {
            //layout.itemSize = CGSize(width: 375/1.4, height: 375/1.4)
            return self.layout.itemSize//CGSize(width: collectionView.frame.width/1.4, height: collectionView.frame.width/1.4)
        } else {
            //self.layout.itemSize = self.layout.itemSize *
            return CGSize(width: 7/8 * layout.itemSize.width, height: 7/8 * layout.itemSize.height) //CGSize(width: collectionView.frame.width/1.7, height: collectionView.frame.width/1.7)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return musicArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionView", for: indexPath) as! CustomCollectionView
        indexSet()
        if index == indexPath && playTrackButton.image(for: .normal) == UIImage(named: "pause.circle.fill") {
            //layout.itemSize = CGSize(width: 375/1.5, height: 375/1.5)
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .allowAnimatedContent, animations: {
                cell.layer.shadowOffset = CGSize(width: 0, height: 3)
                cell.layer.shadowColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
                cell.layer.shadowRadius = 10
                cell.layer.shadowOpacity = 1
            })
        } else {
            UIView.animate(withDuration: 0.3, delay: 0, options: .allowAnimatedContent, animations: {
                cell.layer.shadowOpacity = 0
            })
        }
        let item = musicArray[indexPath.row]
        guard let imageUrl = URL(string: item.trackLogo.url) else { return cell }
        cell.imageLogo.download(from: imageUrl)
        return cell
    }
}


