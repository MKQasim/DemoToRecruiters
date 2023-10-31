  //
  //  UserPostCell.swift
  //  DemoToRecruiters
  //
  //  Created by KamsQue on 26/01/2023.
  //

import UIKit

class UserPostCell: UITableViewCell  {
  
  @IBOutlet weak var postProfileImage: UIImageView!
  @IBOutlet weak var lblName: UILabel!
  @IBOutlet weak var lblCategory: UILabel!
  @IBOutlet weak var lblReferance: UILabel!
  @IBOutlet weak var lblAmount: UILabel!
  @IBOutlet weak var lblCurrency: UILabel!
  @IBOutlet weak var likeUnlikeImageView: UIImageView!
  @IBOutlet weak var commentsImageView: UIImageView!
  @IBOutlet weak var shareImageView: UIImageView!
  @IBOutlet weak var postImageView: UIImageView!
  @IBOutlet weak var liveUserStatusBtn: UIButton!
  @IBOutlet weak var callBtn: UIButton!
  @IBOutlet weak var profileBtn: UIButton!
  
  var userItem : User?
  var didTap : ((_ success: Bool) -> ())?
  var didTapOpen: UserCallback = {_ in }
  
  override func awakeFromNib()
  {
    super.awakeFromNib()
      // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool)
  {
    super.setSelected(selected, animated: animated)
    
      // Configure the view for the selected state
  }
  
  func configureCell(user:User?)
  {
    userItem = user
    guard let user = user else { return  }
    guard let name = user.name else { return  }
      guard let phone = user.phone else { return  }
      guard let addres = user.address?.city else { return  }
      guard let id = user.id else { return  }
      lblName.text = name
      lblCategory.text = "\(addres)"
      lblReferance.text = user.email
      lblAmount.text = phone
      lblCurrency.text = "\(id)"
  }
  
  @IBAction func btnActions(_ sender: UIButton)
  {
    guard let userItem = userItem else { return  }
    didTapOpen(userItem)
  }
  
}
