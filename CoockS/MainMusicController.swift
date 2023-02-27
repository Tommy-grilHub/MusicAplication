//
//  MainMusicController.swift
//  CoockS
//
//  Created by BigSynt on 10.09.2022.
//  Copyright © 2022 BigSynt. All rights reserved.
//

import UIKit

protocol MainMusicProtocol {
    func musicDidLoad(musics: [Music])
    func albumViewDidLoad()
}

class MainMusicController: UIViewController, MainMusicProtocol {

    //var mainView: UrlGetProtocol?
    var presenter: MainMusicPresenter?
    var tableView = UITableView()
    let cellId = "myCell"
    var musicArray: [Music] = [Music]()
    var UID: String = ""
    var urlGetMusic: String = ""
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        frameTableView()
        interfaceVisual()
        configureTableView()
        presenter?.getMusic()
        
        
        //регистрация ячеек
        //let nib = UINib(nibName: "CustomCell", bundle: nil)
        //tableView.register(nib, forCellReuseIdentifier: "myCell")
        
        //tableView.estimatedRowHeight = 100
        
    }
    
    func configureTableView() {
        //view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = 70
        tableView.register(CustomCell.self, forCellReuseIdentifier: "CustomCell")
        tableView.pin(to: view)
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func frameTableView() {
        tableView.frame = view.frame
        self.view.addSubview(tableView)
    }
    
    func albumViewDidLoad() {
        tableView.reloadData()
    }
    
    //сюда приходит музыка из presenter
    func musicDidLoad(musics: [Music]) {
        musicArray = musics
    }
    
    func interfaceVisual() {
        tableView.backgroundColor = .black
        
        navigationItem.title = "Music"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barStyle = .black
        
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        tabBarController?.tabBar.barTintColor = UIColor.black
        tabBarController?.tabBar.tintColor = UIColor.white
        
        navigationController?.navigationBar.backgroundColor = .black
        navigationController?.navigationBar.barTintColor = .black
        view.backgroundColor = .blue
    }
}

extension MainMusicController: UITableViewDelegate,  UITableViewDataSource {
    //tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let enlargedView = EnlargedViewController()
        enlargedView.musicArray = musicArray
        enlargedView.indexGet(index: indexPath)
        enlargedView.playTrackButton.setImage(UIImage(named: "pause.circle.fill"), for: .normal)
        let enlargedViewNav = UINavigationController(rootViewController: enlargedView)
        
        enlargedViewNav.navigationBar.tintColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        enlargedViewNav.navigationBar.isTranslucent = false
        enlargedViewNav.navigationBar.barTintColor = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
        
        present(enlargedViewNav, animated: true, completion: nil)
        return print(indexPath)
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        100
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        let item = musicArray[indexPath.row]
        guard let imageUrl = URL(string: item.trackLogo.url) else { return cell }
        cell.imageLogo.download(from: imageUrl)
        cell.nameTrack.text = item.nameTrack
        cell.nameArtist.text = item.nameArtists.first?.nameArtist
//        if item.nameArtists.count > 1 {
//            var count = 1
//            for name in item.nameArtists {
//                if count == item.nameArtists.count {
//                    cell.nameArtist.text = "\(name.nameArtist)\(cell.nameArtist.text ?? "")"
//
//                } else {
//                    cell.nameArtist.text = "\(cell.nameArtist.text ?? ""), \(name.nameArtist)"
//                }
//                count = count + 1
//            }
//        } else {
//            cell.nameArtist.text = item.nameArtists.first?.nameArtist
//        }
        return cell
    }
}
