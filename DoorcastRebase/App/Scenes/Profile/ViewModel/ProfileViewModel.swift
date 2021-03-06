//
//  ProfileViewModel.swift
//  DoorcastRebase
//
//  Created by Codebele 06 on 06/05/22.
//



import Foundation

protocol ProfileViewModelProtocol:BaseViewModelProtocol {
    func ProfileSuccess(ProfileResponse : ProfileModel)
}

class ProfileViewModel {
    var view: ProfileViewModelProtocol!
    init(_ view: ProfileViewModelProtocol) {
        self.view = view
    }
    func ProfileApi(dictParam: [String: Any]){
        let paramsDict = NSDictionary(dictionary:dictParam)
        print("Parameters = \(paramsDict)")
       
        self.view.showLoader()
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.UpdateProfilenApi, parameters: paramsDict as NSDictionary, resultType: ProfileModel.self) { sucess, result, errorMessage in
            
            self.view.hideLoader()
            DispatchQueue.main.async {
                if sucess {
                    guard let response = result else {return}
                    self.view.ProfileSuccess(ProfileResponse: response)
                } else {
                    // Show alert
                    print("error = \(errorMessage ?? "")")
                }
            }
        }
    }
}
