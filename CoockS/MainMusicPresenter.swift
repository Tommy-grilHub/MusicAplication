//
//  MainMusicPresenter.swift
//  CoockS
//
//  Created by BigSynt on 01.12.2022.
//  Copyright © 2022 BigSynt. All rights reserved.
//

import Foundation

class MainMusicPresenter {
    
    var view: MainMusicProtocol?
    let requestData = RequestData()
    var UID: String = ""
    var urlGetMusic = "https://x8ki-letl-twmt.n7.xano.io/api:4ooykH8y/musicDataGet?UID="
    
    func getMusic() {
        requestData.getData(urlString: urlGetMusic + UID) { result in
            switch result {
            case .success(let data):
                do {
                    let album = try JSONDecoder().decode(MusicLove.self, from: data)
                    self.view?.musicDidLoad(musics: album.result)
                    self.view?.albumViewDidLoad()
                } catch {
                    print("error JSONdecoding")
                }
            case .failure(let error):
                print("error:\(error.localizedDescription)")
            }
        }
    }
}
