//
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.
//

import XCTest

extension XCUIElement {
    
    func tapByCoordinate() {
        self.coordinate(withNormalizedOffset: CGVector(dx: 1, dy: 1)).tap()
    }
    
    func clearText() {
        guard let stringValue = self.value as? String else {
            return
        }
        
        let stringEnd = self.coordinate(withNormalizedOffset: CGVector(dx: 0.9, dy: 0.9))
        stringEnd.tap()
        
        let deleteString = stringValue.characters.map { _ in XCUIKeyboardKeyDelete }.joined(separator: "")
        
        self.typeText(deleteString)
    }
    
}
