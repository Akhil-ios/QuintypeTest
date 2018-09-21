//
//  APIHandler.m
//  DailyCaller
//
//  Created by Shamsudheen.TK on 30/01/18.
//  Copyright © 2018 DailyCaller. All rights reserved.
//

#import "APIHandler.h"
#import "APIHandlerConfig.h"
#import "Utils.h"
@implementation APIHandler

- (void)apiResponseWithUrl:(NSString *)url Params:(NSString *)params
                HTTPMethod:(NSString *)httpMethod CompletionHandler:(APIResponse)apiResponse
{
    
    NSDictionary *headers = @{ @"content-type": @"application/x-www-form-urlencoded",
                               @"cache-control": @"no-cache"
                               };
 
    NSData * jsonData = [params dataUsingEncoding:NSUTF8StringEncoding];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:httpMethod];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:jsonData];

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        
        if (error) {
            
            apiResponse(nil,error);
            
        } else
        {
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
                             apiResponse(responseDictionary,nil);
                        }
        
                            }];
    [dataTask resume];

}


@end
