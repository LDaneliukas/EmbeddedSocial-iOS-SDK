//
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.
//

import Foundation
@testable import EmbeddedSocial

final class MockURLSchemeService: URLSchemeServiceType {
    private(set) var openURLIsCalled = false
    var openURLReturnValue: Bool!
    
    func application(_ app: UIApplication, open url: URL, options: [AnyHashable: Any]) -> Bool {
        openURLIsCalled = true
        return openURLReturnValue
    }
}
