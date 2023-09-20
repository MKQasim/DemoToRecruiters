//
//  TransactionItemDetailsRouter.swift
//  TaskPayBackApp
//
//  Created by KamsQue on 29/01/2023.
//

import UIKit

@objc protocol TransactionItemDetailsRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol TransactionItemDetailsDataPassing
{
  var dataStore: TransactionItemDetailsDataStore? { get set }
}

class TransactionItemDetailsRouter: NSObject, TransactionItemDetailsRoutingLogic, TransactionItemDetailsDataPassing
{
  weak var viewController: TransactionItemDetailsVC?
  var dataStore: TransactionItemDetailsDataStore?
  
  // MARK: Routing
  
  //func routeToSomewhere(segue: UIStoryboardSegue?)
  //{
  //  if let segue = segue {
  //    let destinationVC = segue.destination as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //  } else {
  //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
  //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //    navigateToSomewhere(source: viewController!, destination: destinationVC)
  //  }
  //}

  // MARK: Navigation
  
  //func navigateToSomewhere(source: TransactionItemDetailsViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: TransactionItemDetailsDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
