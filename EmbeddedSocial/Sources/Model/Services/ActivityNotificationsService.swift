//
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.
//

import Foundation

protocol ActivityNotificationsServiceProtocol {
    func updateState(completion: @escaping ((Result<UInt32>) -> Void))
    func updateStatus(for handle: String, completion: ((Result<Void>) -> Void)?)
}

class ActivityNotificationsService: BaseService, ActivityNotificationsServiceProtocol {
    
    func updateState(completion: @escaping ((Result<UInt32>) -> Void)) {
        
        let builder = NotificationsAPI.myNotificationsGetNotificationsCountWithRequestBuilder(authorization: authorization)
        
        builder.execute { [weak self] (response, error) in
            
            guard let strongSelf = self else {
                return
            }
            
            // get actual result
            guard let result64 = response?.body?.count, let result32 = UInt32(exactly: result64) else {
                
                // handle errors
                guard error == nil else {
                    completion(.failure(APIError(error: error)))
                    return
                }
                
                return
            }
            
            completion(.success(result32))
        }
    }
    
    func updateStatus(for handle: String, completion: ((Result<Void>) -> Void)? = nil) {
        let request = PutNotificationsStatusRequest()
        request.readActivityHandle = handle
        let builder = NotificationsAPI.myNotificationsPutNotificationsStatusWithRequestBuilder(request: request, authorization: authorization)
        
        builder.execute { [weak self] (response, error) in
        
            guard let strongSelf = self else {
                return
            }
            
            // handle errors
            guard error == nil else {
                completion?(.failure(APIError(error: error)))
                return
            }
            
            completion?(.success())
        }
    }
}
