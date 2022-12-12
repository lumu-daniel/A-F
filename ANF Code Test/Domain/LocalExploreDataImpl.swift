//
//  LocalExploreDataImpl.swift
//  ANF Code Test
//
//  Created by E-Cartale on 10/12/2022.
//

import Foundation

class LocalExploreDataImpl: DatatAccessProtocol{
    func getExploreData(_ result: @escaping (Result<[ExploreDataItem], Error>) -> Void) {
        do{
            if let filePath = Bundle.main.path(forResource: "exploreData", ofType: "json"),
             let fileContent = try? Data(contentsOf: URL(fileURLWithPath: filePath)),
             let exploreResult = try? JSONDecoder().decode([ExploreDataItem].self,from:fileContent) {
                result(.success(exploreResult))
                return
            }
            throw DataError.failedToGetData
        }catch{
            result(.failure(error))
        }
    }
}
