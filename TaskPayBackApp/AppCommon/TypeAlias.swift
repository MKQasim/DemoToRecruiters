//
//  TypeAlias.swift
//  TaskPayBackApp
//
//  Created by KamsQue on 27/01/2023.
//

import Foundation

typealias VoidCallback = () -> Void
typealias TransactionCallback = (Items) -> Void
typealias DismissCallbackWithString = (String,[Items]?,Bool) -> Void
