//
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.
//

import Foundation

final class HideTopicCommand: TopicCommand {
    
    override func apply(to feed: inout FeedFetchResult) {
        var topics = feed.posts
        
        let index = topics.index(where: { $0.topicHandle == topic.topicHandle })
        guard let hiddenTopicIndex = index else {
            return
        }
        topics.remove(at: hiddenTopicIndex)
        
        feed.posts = topics
    }
    
}
