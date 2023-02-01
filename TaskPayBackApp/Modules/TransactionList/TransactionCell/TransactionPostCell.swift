  //
  //  TransactionPostCell.swift
  //  TaskPayBackApp
  //
  //  Created by KamsQue on 26/01/2023.
  //

import UIKit

class TransactionPostCell: UITableViewCell , NibInstantiatable {
  
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
  
  var transactionItem : Items?
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
  
  func configureCell(transaction:Items?)
  {
    transactionItem = transaction
    guard let transaction = transaction else { return  }
    guard let name = transaction.partnerDisplayName else { return  }
    lblName.text = name + "      Category : \(transaction.category ?? 0)"
    lblReferance.text = transaction.alias?.reference
    lblCategory.text = "\(transaction.transactionDetail?.bookingDate ?? Date())"
    lblAmount.text = transaction.transactionDetail?.description?.rawValue
    lblCurrency.text = "\(String(describing: transaction.transactionDetail?.value?.amount ?? 0))  : \(transaction.transactionDetail?.value?.currency?.rawValue ?? "")"
  }
  
  
  @IBAction func btnActions(_ sender: UIButton)
  {
    guard let transactionItem = transactionItem else { return  }
    didTapOpen(transactionItem)
  }
  
}
