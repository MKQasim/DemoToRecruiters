  //
  //  TransactionPostCell.swift
  //  DemoToRecruiters
  //
  //  Created by KamsQue on 26/01/2023.
  //

import UIKit

class TransactionPostCell: UITableViewCell  {
  
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
  
  var transactionItem : User?
  var didTap : ((_ success: Bool) -> ())?
  var didTapOpen: TransactionCallback = {_ in }
  
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
  
  func configureCell(transaction:User?)
  {
    transactionItem = transaction
    guard let transaction = transaction else { return  }
    guard let name = transaction.name else { return  }
      guard let date = transaction.address else { return  }
      
      lblName.text = name + " #\(transaction.company)"
      lblReferance.text = transaction.email
      lblCategory.text = "\(date)"
      lblAmount.text = transaction.phone
      lblCurrency.text = "\(String(describing: transaction.username))  : \(transaction.id)"
  }
  
  
  @IBAction func btnActions(_ sender: UIButton)
  {
    guard let transactionItem = transactionItem else { return  }
    didTapOpen(transactionItem)
  }
  
}
