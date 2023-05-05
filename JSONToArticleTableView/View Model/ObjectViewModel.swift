//
//  PostViewModel.swift
//  JsonDataExample
//
//  Created by Talor Levy on 2/8/23.
//

import Foundation

class ObjectViewModel {
    
    var myObject: ObjectModel = ObjectModel()
    
    func fetchUsersData(completion: @escaping() -> Void) {
        NetworkManager.sharedInstance.fetchData(urlString: Constants.urls.link.rawValue) {  [weak self] result in
            switch result {
            case .success(let object):
                self?.myObject = object
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
