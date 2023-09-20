  //
  //  SeclectFilterCell.swift
  //  DemoToRecruiters
  //
  //  Created by KamsQue on 31/01/2023.
  //

import UIKit
import SwiftUI

class SeclectFilterCell: UITableViewCell , NibInstantiatable
{
  
  @IBOutlet weak var bgView: UIView!
  @IBOutlet weak var categoryImageView: UIImageView!
  @IBOutlet weak var categoryNameLbl: UILabel!
  
  
  override func awakeFromNib()
  {
    super.awakeFromNib()
      // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool)
  {
    super.setSelected(selected, animated: animated)
    
  }
  
  func configureCell(item:String)
  {
    self.categoryNameLbl.attributedText = NSAttributedString(string:  "\(item)")
    self.bgView.layer.cornerRadius = self.contentView.frame.size.height/2.5
    categoryImageView.layer.borderColor = UIColor(AppColor.TransactionDetailsScreenColors.TransactionDetailsBackGroundView().backgroundGradiantColor.first ?? Color.blue).withAlphaComponent(1).cgColor
    categoryImageView.layer.borderWidth = 5.0
  }
  
}
