//
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.
//

import Foundation

final class RemoveReplyCommand: ReplyCommand {
    
    override var inverseCommand: OutgoingCommand? {
        return CreateReplyCommand(reply: reply)
    }
    
    override func setRelatedHandle(_ relatedHandle: String?) {
        reply.commentHandle = relatedHandle
    }
    
    override func getRelatedHandle() -> String? {
        return reply.commentHandle
    }
    
    override func apply(to feed: inout RepliesFetchResult) {
        var replies = feed.replies
        if let index = replies.index(where: { $0.replyHandle == self.reply.replyHandle }) {
            replies.remove(at: index)
        }
        feed.replies = replies
    }
}
