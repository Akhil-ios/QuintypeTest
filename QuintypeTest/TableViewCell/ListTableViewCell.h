//
//  ListTableViewCell.h
//  QuintypeTest
//
//  Created by Akhil on 17/09/18.
//  Copyright © 2018 Akhil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *headlineLabel;

@end
