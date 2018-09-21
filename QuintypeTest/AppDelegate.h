//
//  AppDelegate.h
//  QuintypeTest
//
//  Created by Akhil on 17/09/18.
//  Copyright © 2018 Akhil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

