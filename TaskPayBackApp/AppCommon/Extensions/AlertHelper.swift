//
//  AlertHelper.swift
//  TaskPayBackApp
//
//  Created by KamsQue on 31/01/2023.
//

import Foundation
import UIKit

public class AlertHelper {
  
  class func showOkAlert(_ title: String? = "", message: String?, action:((UIAlertAction) -> Void)? = nil) {
    showAlert(title, message: message, style: .alert, actionTitles: ["OK"], showCancel: false, action: action)
  }
  
  class func showAlert(_ alertTitle: String? = "", message: String?, style: UIAlertController.Style, actionTitles: [String?], autoDismiss: Bool? =  false  , dismissDuration: Int? = 0 , showCancel: Bool, _ target: UIViewController? = nil, _ sender: Any? = nil, action:((UIAlertAction) -> Void)?) {
    
    let alertController = UIAlertController(title: alertTitle, message: message, preferredStyle: style)
    
    for (_, title) in actionTitles.enumerated() {
      let action = UIAlertAction(title: title, style: .default, handler: action)
      alertController.addAction(action)
    }
    
    if autoDismiss ?? false
    {
      DispatchQueue.delay(.seconds(dismissDuration ?? 1)) {
        alertController.dismiss(animated: true)
      }
    }
    
    if showCancel
    {
      let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
      alertController.addAction(cancelAction)
    }
    
    if style == UIAlertController.Style.actionSheet {
      alertController.view.tintColor = #colorLiteral(red: 0.4078176022, green: 0.407827884, blue: 0.4078223705, alpha: 1)
    }
    
    if let target = target {
      target.present(alertController, animated: true, completion: nil)
    } else {
      TopMostController.topMostViewController().present(alertController, animated: true, completion: nil)
    }
  }
  
  
  class func feedBackController()
  {
    let alertController = UIAlertController(title: "Please write your feedback Message to improve the app \n \n \n \n \n \n \n \n \n", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
    let margin:CGFloat = 28.0
    let rect = CGRect(x: margin, y: margin, width: alertController.view.bounds.size.width - margin * 8.0, height: 600.0)
    let customView = UITextView(frame: rect)
    customView.backgroundColor = UIColor.clear
    customView.font = UIFont(name: "Helvetica", size: 15)
    alertController.view.addSubview(customView)
    let somethingAction = UIAlertAction(title: "Submit", style: UIAlertAction.Style.default, handler: {(alert: UIAlertAction!) in print("something")
      print(customView.text)
    })
    let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: {(alert: UIAlertAction!) in print("cancel")})
    alertController.addAction(somethingAction)
    alertController.addAction(cancelAction)
    TopMostController.topMostViewController().present(alertController, animated: true, completion: nil)
  }
}


