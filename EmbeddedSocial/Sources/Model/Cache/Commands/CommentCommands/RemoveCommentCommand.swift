//
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.
//

import Foundation

final class RemoveCommentCommand: CommentCommand {
    
    override var inverseCommand: OutgoingCommand? {
        return CreateCommentCommand(comment: comment)
    }
    
    override func setRelatedHandle(_ relatedHandle: String?) {
        comment.topicHandle = relatedHandle
    }
    
    override func getRelatedHandle() -> String? {
        return comment.topicHandle
    }
    
    override func apply(to feed: inout CommentFetchResult) {
        var comments = feed.comments
        if let index = comments.index(where: { $0.commentHandle == self.comment.commentHandle }) {
            comments.remove(at: index)
        }
        feed.comments = comments
    }
}

extension RemoveCommentCommand: TopicsFeedApplicableCommand {
    
    func apply(to feed: inout FeedFetchResult) {
        guard let index = feed.posts.index(where: { $0.topicHandle == self.comment.topicHandle }) else {
            return
        }
        var topic = feed.posts[index]
        topic.totalComments = topic.totalComments > 0 ? topic.totalComments - 1 : 0
        feed.posts[index] = topic
    }
    
}

extension RemoveCommentCommand: SingleTopicApplicableCommand {
    
    func apply(to topic: inout Post) {
        topic.totalComments = topic.totalComments > 0 ? topic.totalComments - 1 : 0
    }
    
}
