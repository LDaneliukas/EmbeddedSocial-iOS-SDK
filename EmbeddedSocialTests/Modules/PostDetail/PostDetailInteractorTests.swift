//
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.
//

import XCTest
@testable import EmbeddedSocial

private class MockLikeSerivce: LikesServiceProtocol {
    func likeComment(commentHandle: String, completion: @escaping LikesServiceProtocol.CommentCompletionHandler) {
        completion("commentHandle", nil)
    }
    
    func unlikeComment(commentHandle: String, completion: @escaping LikesServiceProtocol.CompletionHandler) {
        completion("commentHandle", nil)
    }
    
    func deleteLike(postHandle: LikesServiceProtocol.PostHandle, completion: @escaping LikesServiceProtocol.CompletionHandler) {
        
    }
    
    func postLike(postHandle: LikesServiceProtocol.PostHandle, completion: @escaping LikesServiceProtocol.CompletionHandler) {
        
    }
    
    func likeReply(replyHandle: String, completion: @escaping LikesServiceProtocol.ReplyLikeCompletionHandler) {
        
    }
    
    func unlikeReply(replyHandle: String, completion: @escaping LikesServiceProtocol.ReplyLikeCompletionHandler) {
        
    }
}

class PostDetailsInteractorTests: XCTestCase {
    
    var output = MockPostDetailPresenter()
    var interactor = PostDetailInteractor()
    
    var coreDataStack: CoreDataStack!
    var transactionsDatabase: MockTransactionsDatabaseFacade!
    var cache: CacheType!
    
    var commentsService: CommentServiceProtocol?
    var likeService: LikesServiceProtocol?
    var imageService: ImagesServiceType?
    
    override func setUp() {
        super.setUp()
        output.interactor = interactor
        interactor.output = output
        coreDataStack = CoreDataHelper.makeEmbeddedSocialInMemoryStack()
        transactionsDatabase = MockTransactionsDatabaseFacade(incomingRepo:  CoreDataRepository(context: coreDataStack.backgroundContext), outgoingRepo:  CoreDataRepository(context: coreDataStack.backgroundContext))
        cache = Cache(database: transactionsDatabase)
        imageService = ImagesService()
        commentsService = MockCommentService(imagesService: imageService!)
        likeService = MockLikeSerivce()
        interactor.commentsService = commentsService
        interactor.likeService = likeService

    }
    
    override func tearDown() {
        super.tearDown()
        interactor.output = nil
        output.interactor = nil
        transactionsDatabase = nil
        coreDataStack = nil
        cache = nil
        commentsService = nil
        likeService = nil
    }
    
    func testThatFetchedComments() {
        
        //given
        //default in MockCommentService fetching 1 item
        
        //when
        interactor.fetchComments(topicHandle: "test", cursor: "cursor", limit: 10)
        
        //then
        XCTAssertEqual(output.fetchedCommentsCount , 1)
    }
    
    func testThatFetchedMoreCommens() {
        
        //given
        //default in MockCommentService fetching 1 item
        
        
        //when
        interactor.fetchMoreComments(topicHandle: "test", cursor: "cursor", limit: 10)
        
        //then
        XCTAssertEqual(output.fetchedMoreCommentsCount , 1)
    }
    
    func testThatCommentPosted() {
        
        //given
        let comment = "Test"
        
        //when
        interactor.postComment(photo: nil, topicHandle: "test", comment: comment)
        
        //then
        XCTAssertEqual(output.postedComment?.text, comment)
    }
    
    func testThatCommentLiked() {
        
        //given
        let comment = Comment()
        comment.commentHandle = "handle"
        comment.text = "text"
        comment.totalLikes = 0
        comment.liked = false
        output.comments = [comment]
        
        //when
        interactor.commentAction(commentHandle: comment.commentHandle!, action: .like)
        
        //then
        XCTAssertEqual(output.comments.first?.totalLikes , 1)
        XCTAssertEqual(output.comments.first?.liked , true)
    }
    
    func testThatCommentUnliked() {
        
        //given
        let comment = Comment()
        comment.commentHandle = "handle"
        comment.text = "text"
        comment.totalLikes = 1
        comment.liked = true
        output.comments = [comment]
        
        //when
        interactor.commentAction(commentHandle: comment.commentHandle!, action: .unlike)
        
        //then
        XCTAssertEqual(output.comments.first?.totalLikes , 0)
        XCTAssertEqual(output.comments.first?.liked , false)
    }
    
}
