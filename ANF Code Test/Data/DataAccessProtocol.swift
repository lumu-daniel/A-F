//
//  DataAccessProtocol.swift
//  ANF Code Test
//
//  Created by E-Cartale on 10/12/2022.
//

import Foundation

enum DataError: Error{
    case failedToGetData
    case noError
}

protocol DatatAccessProtocol{

    func getExploreData(_ result: @escaping (Result<[ExploreDataItem], Error>)->Void)
}
