//
//  RequestData.swift
//  CoockS
//
//  Created by BigSynt on 29.11.2022.
//  Copyright © 2022 BigSynt. All rights reserved.
//

import Foundation

class RequestData {
    func getData(urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let safeData = data else { return }
                completion(.success(safeData))
            }
        }
        task.resume()
    }
}
