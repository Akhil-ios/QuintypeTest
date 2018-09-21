//
//  APIHandlerConfig.h
//  DailyCaller
//
//  Created by Shamsudheen.TK on 30/01/18.
//  Copyright © 2018 DailyCaller. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIHandlerConfig : NSObject

//HTTP Request types
extern NSString const *kPost;
extern NSString const *kGet;

// Error message when there is no network
extern NSString *kNetworkError;

//representing the api content type.
extern NSString *kApiContentType;




@end
