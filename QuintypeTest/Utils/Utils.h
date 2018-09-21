//
//  Utils.h
//  AusFinex
//
//  Created by Akhil on 24/07/17.
//  Copyright (c) 2017 Akhil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface Utils : NSObject


+(void)showBasicAlert : (NSString *)alertText andController:(UIViewController *) controller;

+(void)startActivity:(UIViewController *)controller;

+(void)stopActivity : (UIViewController *) controller;

@end
