//
//  ViewModel.swift
//  DemoToRecruiters
//
//  Created by KamsQue on 29/01/2023.
//

import SwiftUI

protocol UserItemDetailsViewDelegate: AnyObject {
  func didSelectButton(_ sender: String)
}

protocol UserItemDetailsViewModel {
  var delegate: UserItemDetailsViewDelegate? { get set }
  var userDetailsModel : User? { get set}
}

final class DefaultUserDetailsViewModel : UserItemDetailsViewModel {
  
  var delegate: UserItemDetailsViewDelegate?
  var userDetailsModel: User?
  var text: String?
  var buttonText: String?
  
  internal init(delegate: UserItemDetailsViewDelegate? = nil, UserDetailsModel: User? = nil, text: String? = nil, buttonText: String? = nil) {
    self.delegate = delegate
    self.userDetailsModel = UserDetailsModel
    self.text = text
    self.buttonText = buttonText
  }
}
