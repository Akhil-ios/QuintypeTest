//
//  CardView.m
//  Stamp
//
//  Created by  on 31/07/17.
//  Copyright © 2017 Akhil, Inc. All rights reserved.
//

#import "CardView.h"

@implementation CardView


-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.layer setShadowColor:[UIColor lightGrayColor].CGColor];
    [self.layer setShadowOpacity:0.8];
    [self.layer setShadowRadius:15];
    [self.layer setShadowOffset:CGSizeMake(0.0, 0.0)];
}

@end
