//
//  String+Localizable.swift
//  PuccaVideo
//
//  Created by Diego Louli on 20.06.18.
//  Copyright © 2018 Isabela Karen Louli. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
