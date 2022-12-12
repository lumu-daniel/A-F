//
//  RemoteDataImpl.swift
//  ANF Code Test
//
//  Created by E-Cartale on 10/12/2022.
//

import Foundation

class RemoteExploreDataImpl: DatatAccessProtocol{
    func getExploreData(_ result: @escaping (Result<[ExploreDataItem], Error>) -> Void) {
        guard let url = URL(string: "https://www.abercrombie.com/anf/nativeapp/qa/codetest/codeTest_exploreData.json") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ data, _, error in
            guard let data = data, error == nil else {return}
            
            do{
                let results = try JSONDecoder().decode([ExploreDataItem].self,from:data)
                result(.success(results))
            }catch{
                result(.failure(error))
            }
        }
        
        task.resume()
    }
    
    
}
