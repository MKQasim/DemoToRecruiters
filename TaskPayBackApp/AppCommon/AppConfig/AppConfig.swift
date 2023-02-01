  //
  //  AppConfig.swift
  //  TaskPayBackApp
  //
  //  Created by KamsQue on 26/01/2023.
  //

import Foundation
import KQTaskNetworkManager

class AppConfig {
  static let shared : AppConfig = AppConfig()
  private init(){
    self.setupConfig()
  }
 
  var enviroment : Environment =  Environment.Local
  
  func setupConfig() -> Environment {
    
#if Local
    self.enviroment = Environment.Local
#elseif Dev
    self.enviroment = Environment.Dev
#elseif Qa
    self.enviroment = Environment.Qa
#elseif Stag
    self.enviroment = Environment.Stag
#elseif Prod
    self.enviroment = Environment.Prod
#endif
    return enviroment
  }
  
}
