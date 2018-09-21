//
//  StoryDetailViewController.m
//  QuintypeTest
//
//  Created by Akhil on 17/09/18.
//  Copyright © 2018 Akhil. All rights reserved.
//

#import "StoryDetailViewController.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"

@interface StoryDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *heroImage;

@end

@implementation StoryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [_heroImage setImageWithURL:[NSURL URLWithString:_imageUrl] placeholderImage:[UIImage imageNamed:@"myImage.jpg"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
