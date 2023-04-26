//
//  Extensions.swift
//  NYPNav
//
//  Created by Prakhar Trivedi on 26/4/23.
//

import Foundation
import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
