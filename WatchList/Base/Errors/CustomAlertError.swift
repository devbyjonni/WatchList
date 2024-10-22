//
//  CustomAlertError.swift
//  WatchList
//
//  Created by Jonni Akesson on 2024-09-30.
//

protocol CustomAlertError {
    var id: String { get }
    var title: String { get }
    var message: String { get }
    var primaryButtonLabel: String { get }
    var cancelButtonLabel: String { get }
}
