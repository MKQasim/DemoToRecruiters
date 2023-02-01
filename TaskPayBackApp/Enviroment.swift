  //
  //  Enviroment.swift
  //  KQTaskProject
  //
  //  Created by KamsQue on 22/12/2022.
  //


import Foundation


public enum Environment
{
  
  case Local
  case Dev
  case Qa
  case Stag
  case Prod
  
//Local   https://run.mocky.io/v3/488740b2-66ed-464b-bce9-f8c70185054b
//Prod    https://api.payback.com/transactions
//QA      https://api-test.payback.com/transactions
  
  func baseURL() -> String
  {
    return "\(urlProtocol())://\(subdomain()).\(domain())\(route())"
  }
  
  func urlProtocol() -> String
  {
    switch self {
    case .Local, .Dev, .Qa , .Stag, .Prod :
      return "https"
    }
  }

  func subdomain() -> String
  {
    switch self
    {
    case .Local, .Dev, .Stag:
      return "run.mocky"
    case  .Qa :
      return "api-test.payback"
    case .Prod  :
      return "api.payback"
    }
  }
  
  func domain() -> String
  {
    switch self
    {
    case .Local, .Dev, .Stag  :
      return "io/"
    case  .Qa :
      return "com/"
    case .Prod  :
      return "com/"
    }
  }
  
  func route() -> String
  {
    switch self
    {
    case .Local, .Dev, .Stag  :
      return "v3/488740b2-66ed-464b-bce9-f8c70185054b"
    case  .Qa :
      return "transactions"
    case .Prod  :
      return "transactions"
    }
  }
}

extension Environment
{
  func host() -> String
  {
    return "\(self.subdomain()).\(self.domain())"
  }
}
  // MARK:- APIs
var baseUrls = ""


public struct Path
{
  
  
  public init()
  {
    
  }
  public struct Transactions
  {
    var enviroment : Environment =  Environment.Local
    public init()
    {
      
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
      baseUrls = enviroment.baseURL()
      print(baseUrls)
    }
    public var getTransactionsList : (String) -> String =
    {
      api_Key  in
      return "\(baseUrls)"
    }
    public var getTransactionDetails : (String) -> String =
    {
      api_Key  in
      return "\(baseUrls)/\(api_Key)"
    }
  }
}

/*
 
 baseUrl
 
 Path().login
 
 Path.User().getProfile
 
 Path.User().deleteUser(525)
 
 Path.User.Task().getTaskDetail(525, 2)
 
 */
