//
//  Notification+.swift
//  DescendantsDNA
//
//  Created by Dmytro Davydenko on 12/10/2023.
//

import Foundation
import NotificationCenter

extension Notification.Name {
    static var isLoadingAPI = Notification.Name("IS_LOADING_API")
    static var isLoadingDone = Notification.Name("IS_LOADING_DONE")
}
