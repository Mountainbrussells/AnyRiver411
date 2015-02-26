//
//  BRDetailsViewController.m
//  AnyRiver411
//
//  Created by Ben Russell on 2/25/15.
//  Copyright (c) 2015 Ben Russell. All rights reserved.
//

#import "BRDetailsViewController.h"

@interface BRDetailsViewController ()

@end

@implementation BRDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    UINavigationItem *navItem = self.navigationItem;
    navItem.title = self.location.name;
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
