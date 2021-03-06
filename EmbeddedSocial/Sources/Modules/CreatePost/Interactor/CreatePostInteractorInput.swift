//
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.
//

import Foundation

protocol CreatePostInteractorInput {
    func postTopic(photo: Photo?, title: String?, body: String!)
    func update(topic: Post, title: String?, body: String)
}
