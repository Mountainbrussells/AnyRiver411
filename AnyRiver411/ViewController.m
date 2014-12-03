//
//  ViewController.m
//  AnyRiver411
//
//  Created by Ben Russell on 11/25/14.
//  Copyright (c) 2014 Ben Russell. All rights reserved.
//

#import "ViewController.h"



#import "Area.h"
#import "Location.h"
#import "Bug.h"

#import "CoreData+MagicalRecord.h"




@interface UIViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;
 @property (nonatomic, strong) NSMutableArray *dataArray;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
    

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.dataArray = [NSMutableArray new];
    
    [self refreshData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Refresh
- (void) refreshData
{
    [self.dataArray removeAllObjects];
    NSArray *allRecords = [Area MR_findAll];
    [self.dataArray addObjectsFromArray:allRecords];
    [self.tableView reloadData];
    

}

@end
