//
//  InitialViewController.m
//  QuintypeTest
//
//  Created by Akhil on 17/09/18.
//  Copyright © 2018 Akhil. All rights reserved.
//

#import "InitialViewController.h"
#import "Utils.h"
#import "APIHandler.h"
#import "ListTableViewCell.h"
#import "YCFirstTime.h"
#import "AppDelegate.h"

@interface InitialViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableItemList;
@property NSArray *itemArray;
@end

@implementation InitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _itemArray = [[NSArray alloc]init];
   
    [[YCFirstTime shared] executeOncePerInterval:^{
        
         [self loadItemsFromApi];
        
    } forKey:@"API_REFRESH" withDaysInterval:1.0f];
    
    
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    if ([[YCFirstTime shared] blockWasExecuted:@"API_REFRESH"])
    {
        [self fetchFromDatabase];
    }
}

// Load Api to fetch collection and stories
-(void)loadItemsFromApi
{
    [Utils startActivity:self];
    
    NSString *apiUrl = @"https://demo9639618.mockable.io/collection";
    APIHandler *apiHandler = [[APIHandler alloc] init];
    [apiHandler apiResponseWithUrl:apiUrl Params:nil HTTPMethod:@"GET" CompletionHandler:^(id responseData, NSError *error) {
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
                               [self saveToCoreData: responseData[@"items"]];
                               [self fetchFromDatabase];
                           });
            
        }
        
    }];
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
     context = [[delegate persistentContainer] viewContext];
    return context;
}

-(void)saveToCoreData:(NSArray *)details
{
    
    for (int i = 0; i < details.count; i++) {
        
        NSDictionary *temp = [details
                              objectAtIndex:i];
        
        
        NSManagedObjectContext *context = [self managedObjectContext];
        
        // Create a new managed object
        NSManagedObject *newItem = [NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:context];
       
        if ([temp[@"type"] isEqualToString:@"collection"]) {
            
            [newItem setValue:temp[@"name"] forKey:@"name"];
            [newItem setValue:temp[@"url"] forKey:@"storyUrl"];
            [newItem setValue:@"collection" forKey:@"type"];
        }
        else
        {
             [newItem setValue:temp[@"story"][@"headline"] forKey:@"name"];
             [newItem setValue:temp[@"story"][@"headline"] forKey:@"headline"];
             [newItem setValue:temp[@"story"][@"hero-image"] forKey:@"imageUrl"];
             [newItem setValue:@"story" forKey:@"type"];
        }
       
        NSError *error = nil;
        // Save the object to persistent store
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
        else
        {
           // [self fetchFromDatabase];
        }
    }
    
}

-(void)fetchFromDatabase
{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Item"];
    [fetchRequest setReturnsObjectsAsFaults:NO];
    self.itemArray = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    [self.tableItemList reloadData];
}
# pragma UITableView Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _itemArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier;
    simpleTableIdentifier = @"listCell";
    
    ListTableViewCell *cell = (ListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    NSManagedObject *item = [self.itemArray objectAtIndex:indexPath.row];
    [cell.textLabel setText:[NSString stringWithFormat:@"%@", [item valueForKey:@"name"]]];

    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSManagedObject *device = [self.itemArray objectAtIndex:indexPath.row];
    if ([[device valueForKey:@"type"] isEqualToString:@"collection"])
    {
        CollectionStoryListViewController *nextVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CollectionStoryListViewController"];
        nextVC.storyUrl = [NSString stringWithFormat:@"%@",[device valueForKey:@"storyUrl"]];
        self.navigationController.title =  [NSString stringWithFormat:@"%@",[device valueForKey:@"name"]];
        [self.navigationController pushViewController:nextVC animated:YES];
    }
    else
    {
        StoryDetailViewController *nextVC = [self.storyboard instantiateViewControllerWithIdentifier:@"StoryDetailViewController"];
        nextVC.imageUrl = [NSString stringWithFormat:@"%@",[device valueForKey:@"imageUrl"]];
        self.navigationController.title = [NSString stringWithFormat:@"%@",[device valueForKey:@"name"]];
        [self.navigationController pushViewController:nextVC animated:YES];
    }
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
