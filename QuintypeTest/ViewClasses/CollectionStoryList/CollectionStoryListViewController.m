//
//  CollectionStoryListViewController.m
//  QuintypeTest
//
//  Created by Akhil on 17/09/18.
//  Copyright © 2018 Akhil. All rights reserved.
//

#import "CollectionStoryListViewController.h"
#import "APIHandler.h"
#import "APIHandlerConfig.h"
#import "Utils.h"
#import "ListTableViewCell.h"
#import "StoryDetailViewController.h"

@interface CollectionStoryListViewController ()
@property NSArray *itemArray;
@property (weak, nonatomic) IBOutlet UITableView *collectionStories;

@end

@implementation CollectionStoryListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _itemArray = [[NSArray alloc]init];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
     [self loadItemsFromApi];
}

-(void)loadItemsFromApi
{
    [Utils startActivity:self];
    APIHandler *apiHandler = [[APIHandler alloc] init];
    [apiHandler apiResponseWithUrl:_storyUrl Params:nil HTTPMethod:@"GET" CompletionHandler:^(id responseData, NSError *error) {
        [Utils stopActivity:self];
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [Utils showBasicAlert:error.localizedDescription andController:self];
            });
        }
        else {
            
            dispatch_async(dispatch_get_main_queue(), ^
                           {
                               [Utils stopActivity:self];
                               self.itemArray = responseData[@"items"];
                               [self.collectionStories reloadData];
                           });
            
        }
        
    }];
}

# pragma UITableView Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _itemArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    ListTableViewCell *cell = (ListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"listCell"];
    NSDictionary *temp = [_itemArray
                          objectAtIndex:indexPath.row];
    cell.authorLabel.text = [NSString stringWithFormat:@"Author : %@",temp[@"story"][@"author-name"]];
    cell.summaryLabel.text = [NSString stringWithFormat:@"Summary : %@",temp[@"story"][@"summary"]];
    cell.headlineLabel.text = [NSString stringWithFormat:@"Headline : %@",temp[@"story"][@"headline"]];
   
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *temp = [_itemArray
                          objectAtIndex:indexPath.row];
    
        StoryDetailViewController *nextVC = [self.storyboard instantiateViewControllerWithIdentifier:@"StoryDetailViewController"];
        nextVC.imageUrl = temp[@"story"][@"hero-image"];
        self.navigationController.title = temp[@"story"][@"headline"];
        [self.navigationController pushViewController:nextVC animated:YES];
    
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
