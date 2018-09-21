//
//  Utils.m
//  AusFinex
//
//  Created by Akhil on 24/07/17.
//  Copyright (c) 2017 Akhil. All rights reserved.
//


#import "Utils.h"
#import "GiFHUD.h"
@implementation Utils


+(void)showBasicAlert:(NSString *)alertText andController:(UIViewController *)controller
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Quint Test" message:alertText preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [alert dismissViewControllerAnimated:YES completion:nil];
            
        }];
        [alert addAction:cameraAction];
        [controller presentViewController:alert animated:YES completion:nil];
       
    });
}

+(void)startActivity:(UIViewController *)controller
{
    
      dispatch_async(dispatch_get_main_queue(), ^{
        [GiFHUD setGifWithImageName:@"loading.gif"];
        [GiFHUD showWithOverlay];
    });
    
}

+(void)stopActivity:(UIViewController *)controller
{
    dispatch_async(dispatch_get_main_queue(), ^{

    [GiFHUD dismiss];
    });
}


@end
