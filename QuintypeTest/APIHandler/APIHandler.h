//
//  APIHandler.h
//  DailyCaller
//
//  Created by Shamsudheen.TK on 30/01/18.
//  Copyright © 2018 DailyCaller. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^APIResponse)(id response, NSError *error);

@interface APIHandler : NSObject


/*!
 * Provides response for a webservice request using it's url

 * @param url - the url to initiate the webservice request
 * @param params - the parameters to pass to the server as request body
 * @param httpMethod - the http request type (POST or GET)
 * @param apiResponse - completion handler to notify the completion status
 */
- (void)apiResponseWithUrl:(NSString const *)url Params:(NSString *)params
                HTTPMethod:( NSString *)httpMethod CompletionHandler:(APIResponse)apiResponse;


@end
