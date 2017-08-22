//
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.
//

import Foundation

protocol LikesServiceProtocol {
    
    typealias PostHandle = String
    typealias CompletionHandler = (_ postHandle: PostHandle, _ error: Error?) -> Void
    typealias CommentCompletionHandler = (_ commentHandle: String, _ error: Error?) -> Void
    typealias ReplyLikeCompletionHandler = (_ commentHandle: String, _ error: Error?) -> Void
    
    func postLike(postHandle: PostHandle, completion: @escaping CompletionHandler)
    func deleteLike(postHandle: PostHandle, completion: @escaping CompletionHandler)
    func likeComment(commentHandle: String, completion: @escaping CommentCompletionHandler)
    func unlikeComment(commentHandle: String, completion: @escaping CompletionHandler)
    func likeReply(replyHandle: String, completion: @escaping ReplyLikeCompletionHandler)
    func unlikeReply(replyHandle: String, completion: @escaping ReplyLikeCompletionHandler)

}

class LikesService: BaseService, LikesServiceProtocol {
    
    func postLike(postHandle: PostHandle, completion: @escaping CompletionHandler) {
        LikesAPI.topicLikesPostLike(topicHandle: postHandle, authorization: authorization) { (object, error) in
            Logger.log(object, error)
            if self.errorHandler.canHandle(error) {
                self.errorHandler.handle(error)
            } else {
                completion(postHandle, error)
            }
        }
    }
    
    func deleteLike(postHandle: PostHandle, completion: @escaping CompletionHandler) {
        LikesAPI.topicLikesDeleteLike(topicHandle: postHandle, authorization: authorization) { (object, error) in
            Logger.log(object, error)
            if self.errorHandler.canHandle(error) {
                self.errorHandler.handle(error)
            } else {
                completion(postHandle, error)
            }
        }
    }
    
    func likeComment(commentHandle: String, completion: @escaping CommentCompletionHandler) {
        LikesAPI.commentLikesPostLike(commentHandle: commentHandle, authorization: authorization) { (object, error) in
            completion(commentHandle, error)
        }
    }
    
    func unlikeComment(commentHandle: String, completion: @escaping CommentCompletionHandler) {
        LikesAPI.commentLikesDeleteLike(commentHandle: commentHandle, authorization: authorization) { (object, error) in
            completion(commentHandle, error)
        }
    }
    
    func likeReply(replyHandle: String, completion: @escaping ReplyLikeCompletionHandler) {
        LikesAPI.replyLikesPostLike(replyHandle: replyHandle, authorization: authorization) { (object, error) in
            completion(replyHandle, error)
        }
    }
    
    func unlikeReply(replyHandle: String, completion: @escaping ReplyLikeCompletionHandler) {
        LikesAPI.replyLikesDeleteLike(replyHandle: replyHandle, authorization: authorization) { (object, error) in
            completion(replyHandle, error)
        }
    }
}

