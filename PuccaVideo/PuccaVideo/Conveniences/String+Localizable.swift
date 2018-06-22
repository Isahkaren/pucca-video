//
//  String+Localizable.swift
//  PuccaVideo

//  Copyright © 2018 Isabela Karen Louli. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
