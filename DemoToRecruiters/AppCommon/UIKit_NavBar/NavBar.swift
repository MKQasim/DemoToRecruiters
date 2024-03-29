  //
  //  NavBar.swift
  //  DemoToRecruiters
  //
  //  Created by KamsQue on 26/01/2023.
  //

import UIKit

public enum ActionType : String{
  case leftFirstButtonAction
  case leftSecondButtonAction
  case rightFirstButtonAction
  case rightSecondButtonAction
  case rightThirdButtonAction
}

class NavBar: UIView {
  
  @IBOutlet weak var backgroundView: UIView!
  @IBOutlet public var navView: UIView!
  @IBOutlet public weak var leftFirstButton: UIButton!
  @IBOutlet public weak var leftSecondButton: UIButton!
  @IBOutlet public weak var titleImage: UIImageView!
  @IBOutlet public weak var titleLabel: UILabel!
  @IBOutlet public weak var rightFirstButton: UIButton!
  @IBOutlet public weak var rightSecondButton: UIButton!
  @IBOutlet public weak var rightThirdButton: UIButton!
  var navBarAction : ((_ actionType:ActionType)->(Void)) = { _ in}
  var onCompletion : ((_ success: Bool) -> ())?
  var navBar = UIView()
  var navBarNameIdentifire  = "NavBar"
  
  var myAppNavColor: UIColor =  .orange {
    didSet{
      setBackgroundchange(selected: AppTheme.shared.navBackgroundColor, navTitle: titleLabel.text!)
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
    
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }
  
  func commonInit()
  {
    let viewFromXib = Bundle.main.loadNibNamed(navBarNameIdentifire, owner: self, options: nil)![0] as! UIView
    viewFromXib.frame = self.bounds
    addSubview(viewFromXib)
    setupView()
   
  }
  
  func setGradientBackground() {
    self.backgroundView.layer.cornerRadius = 25
    self.backgroundView.layer.masksToBounds = true
    self.backgroundView.layerGradient(startPoint: .centerRight, endPoint: .centerLeft, colorArray: [UIColor(AppColor.UserDetailsScreenColors.UserDetailsBackGroundView().backgroundGradiantColor.first!).cgColor, UIColor(AppColor.UserDetailsScreenColors.UserDetailsBackGroundView().backgroundGradiantColor.last!).cgColor], type: .axial)
  }
  
  func setupView()
  {
    setGradientBackground()
    self.leftFirstButton.setImage(UIImage(named: ImageFactory.NavBar.navBarMenu), for: .normal)
    self.leftSecondButton.setBackgroundImage(UIImage(named: ImageFactory.NavBar.navBarUserPlaceholeder), for: .normal)
    self.rightFirstButton.setImage(UIImage(named: ImageFactory.NavBar.navBarMessage), for: .normal)
  }
  
  @IBAction func menuAction(_ sender: UIButton)
  {
    _ = navBarAction(ActionType.leftFirstButtonAction)
  }
  
  @IBAction func profileAction(_ sender: UIButton)
  {
    _ = navBarAction(ActionType.leftSecondButtonAction)
  }
  
  @IBAction func messageAction(_ sender: UIButton)
  {
   _ = navBarAction(ActionType.rightFirstButtonAction)
  }
  
  @IBAction func notificationAction(_ sender: UIButton)
  {
    _ = navBarAction(ActionType.rightSecondButtonAction)
  }
  
  @IBAction func searchAction(_ sender: UIButton) {
   _ = navBarAction(ActionType.rightThirdButtonAction)
  }
}
extension NavBar {
  func setBackgroundchange(selected:UIColor,navTitle:String?)
  {
    let when = DispatchTime.now() + 0.0
    DispatchQueue.main.asyncAfter(deadline: when) {
      self.backgroundView.backgroundColor = selected
      self.titleLabel.text = navTitle
    }
  }
  
  func setNavBackAction(isPushed: Bool =  false , leftFirst:Bool = false ,leftSecond:Bool = false,leftThird:Bool = false,title:Bool = false,rightFirst:Bool = false ,rightSecond:Bool = false,rightThird:Bool = false ,  navTitle : String  = "" )
  {
    
    leftFirstButton.setImage(UIImage(named:  isPushed == true ? ImageFactory.NavBar.navBarBack :  ImageFactory.NavBar.navBarMenu), for: .normal)
    leftFirstButton.isHidden = isPushed == true ? false : leftFirst
    leftSecondButton.isHidden = leftSecond
    titleLabel.isHidden = title
    rightFirstButton.isHidden = rightFirst
    rightSecondButton.isHidden = rightSecond
    rightThirdButton.isHidden = rightThird
    self.titleLabel.text = navTitle
  }
}
extension NavBar {
  
  func setNavDoneButtonTitle(title:String)
  {
    self.rightThirdButton.setImage(nil, for: .normal)
    self.rightThirdButton.setTitle(title, for: .normal)
  }
  
  func firstLeftButtonAction(image : String,title:String)
  {
    self.rightThirdButton.setTitle(title, for: .normal)
  }
  
  func secondLeftButton(image : String,title:String){
    if image == "" {
      self.leftSecondButton.setImage(nil, for: .normal)
      self.leftSecondButton.setTitle(title, for: .normal)
    }else{
      self.leftSecondButton.setBackgroundImage(UIImage(named: image), for: .normal)
    }
  }
  
  func rightFirstButton(image : String)
  {
    self.rightFirstButton.setImage(UIImage(named: image), for: .normal)
    
  }
  
  func rightSecondButton(image : String,title:String)
  {
    if image == "" {
      self.rightSecondButton.setImage(nil, for: .normal)
      self.rightSecondButton.setTitle(title, for: .normal)
      self.rightSecondButton?.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
      self.rightSecondButton?.titleLabel?.textAlignment = .center
      self.rightSecondButton.titleLabel?.font = self.rightSecondButton.titleLabel?.font.withSize(10)
     
    }else{
      self.rightSecondButton.setImage(UIImage(named: image), for: .normal)
    }
  }
  
  func rightThirdButton(image : String){
    self.rightThirdButton.setImage(UIImage(named: image), for: .normal)
  }
}
