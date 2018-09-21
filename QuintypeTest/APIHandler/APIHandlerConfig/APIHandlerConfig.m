//
//  APIHandlerConfig.m
//  DailyCaller
//
//  Created by Shamsudheen.TK on 30/01/18.
//  Copyright © 2018 DailyCaller. All rights reserved.
//

#import "APIHandlerConfig.h"

@implementation APIHandlerConfig

//http request types.
NSString const *kPost = @"POST";
NSString const *kGet  = @"GET";

// Error message when there is no network
 NSString *kNetworkError = @"Internet connection appears to be offline";


//representing the api content type.
NSString *kApiContentType = @"application/json";




@end
