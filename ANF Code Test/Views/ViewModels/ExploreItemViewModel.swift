//
//  File.swift
//  ANF Code Test
//
//  Created by E-Cartale on 10/12/2022.
//

import Foundation

class ExploreItemViewModel: ObservableObject {
    @Published private(set) var items: [ExploreDataItem]? {
        willSet {
            objectWillChange.send()
        }
    }
    @Published private(set) var error: Error{
        willSet {
            objectWillChange.send()
        }
    }
    
    private var repository: DatatAccessProtocol?
    
    init(dataAccessRepository repo: DatatAccessProtocol){
        self.repository = repo
        self.error = DataError.noError
    }

    func getDataList(_ result: @escaping (Result<[ExploreDataItem], Error>)->Void) {
        repository?.getExploreData(result)
    }
    
    func updateList(with result: [ExploreDataItem]){
        self.items = result
        self.error = DataError.noError
    }
    
    func updateError(with dataError: Error){
        self.error = dataError
    }
}
