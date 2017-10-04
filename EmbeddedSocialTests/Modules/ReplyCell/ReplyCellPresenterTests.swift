//
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.
//

import XCTest
@testable import EmbeddedSocial

class ReplyCellPresenterTests: XCTestCase {
    
    var presenter: ReplyCellPresenter!
    var interactor: MockReplyCellInteractor!
    var view: MockReplyCell!
    var router: MockReplyCellRouter!
    
    override func setUp() {
        super.setUp()
        
        interactor = MockReplyCellInteractor()
        view = MockReplyCell()
        router = MockReplyCellRouter()
        interactor.output = presenter
        
        presenter = ReplyCellPresenter()
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        let mockUserHolder = MyProfileHolder()
        presenter.myProfileHolder = mockUserHolder

        presenter.reply = Reply(replyHandle: UUID().uuidString)
        presenter.reply.userHandle = mockUserHolder.me?.uid
    }
    
    override func tearDown() {
        super.tearDown()
        presenter.reply = nil
        presenter.myProfileHolder = nil
        presenter = nil
        interactor = nil
        view = nil
        router = nil
    }
    
    func testThatLiked() {
        presenter.like()
        
        XCTAssertEqual(presenter.reply.liked, true)
        
        presenter.like()
        
        XCTAssertEqual(presenter.reply.liked, false)
    }
    
    func testThatOpenLikes() {
        presenter.likesPressed()
        
        XCTAssertEqual(router.openLikesCount, 1)
    }
    
    func testThatOpenOptions() {
        presenter.optionsPressed()
        
        XCTAssertEqual(router.openMyReplyOptionsCount, 1)
        
        presenter.myProfileHolder?.me?.uid = UUID().uuidString
        
        presenter.optionsPressed()
        
        XCTAssertEqual(router.openOtherReplyOptionsCount, 1)
    }
    
    func testThatOpenUser() {
        presenter.avatarPressed()
        
        XCTAssertEqual(router.openUserCount, 1)
    }
    
    
}
