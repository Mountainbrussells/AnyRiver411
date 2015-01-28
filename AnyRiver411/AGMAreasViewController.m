//
//  AGMAreasViewController.m
//  Anglers411
//
//  Created by Ben Russell on 6/11/14.
//  Copyright (c) 2014 Angry Grouse Media. All rights reserved.
//

#import "AGMAreasViewController.h"
#import "BARInformationController.h"
#import "Area.h"
#import "Location.h"
#import "AGMLocationsViewController.h"
#import "AGMAreasCell.h"

@interface AGMAreasViewController ()
// Declaring an universal object
{
    NSMutableArray *_dataArray;
}
@property (nonatomic, weak) UITableView *tableView;


@end

@implementation AGMAreasViewController

- (IBAction)information:(id)sender
{
    BARInformationController *info= [[BARInformationController alloc] init];
    [self.navigationController pushViewController:info animated:YES];
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // Adding the table view
        UITableView *tv = [[UITableView alloc] init];
        self.tableView = tv;
        
        //Adding the title and Log Fish Button to Navigation bar
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"Yampa411";
        
        UIBarButtonItem *rbi = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Icon_info"]
                                                                style:UIBarButtonItemStylePlain
                                                               target:self
                                                               action:@selector(information:)];
        navItem.rightBarButtonItem = rbi;
        
        
        

        
        UINib *nib = [UINib nibWithNibName:@"AGMAreasCell" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:@"AGMAreasCell"];
        

        // Array to hold all saved records
        
        _dataArray = [NSMutableArray new];
        
        //self.tableView.backgroundColor = [UIColor colorWithRed:(226/255.00) green:(238/255.00) blue:(241/255.00) alpha:1.00];
        
        
        [self.tableView setBackgroundView:nil];
        [self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LighterFishnet_scalechange"]]];
        
        
        
        [self refreshData];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    
    
}

#pragma mark - Refresh
- (void) refreshData
{
    [_dataArray removeAllObjects];
    NSArray *allRecords = [Area MR_findAll];
    [_dataArray addObjectsFromArray:allRecords];
    [self.tableView reloadData];
    
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - Filling the cells of the table view with info from back end
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //  This is where the count of cells will come from the back end
    NSLog(@"there are %i areas", _dataArray.count);
    return _dataArray.count;
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // SETTING UP A UIView IN ORDER TO CREATE ILLUSION OF SEPERATION BETWEEN CELLS
    cell.contentView.backgroundColor = [UIColor clearColor];
    UIView *clearRoundedCornerView = [[UIView alloc] initWithFrame:CGRectMake(10,10,310,110)];
    clearRoundedCornerView.backgroundColor = [UIColor clearColor];
    clearRoundedCornerView.layer.masksToBounds = YES;
    clearRoundedCornerView.layer.cornerRadius = 3.0;
    clearRoundedCornerView.layer.shadowOffset = CGSizeMake(-1, 1);
    clearRoundedCornerView.layer.shadowOpacity = 0.5;
    
    // Set up Mask with 2 rounded corners
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:clearRoundedCornerView.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerBottomLeft) cornerRadii:CGSizeMake(20.0, 20.0)];
    CAShapeLayer *cornerMaskLayer = [CAShapeLayer layer];
    [cornerMaskLayer setPath:path.CGPath];
    clearRoundedCornerView.layer.mask = cornerMaskLayer;
    
    // Make a transparent, stroked laker which will display the stroke
    CAShapeLayer *strokeLayer = [CAShapeLayer layer];
    strokeLayer.path = path.CGPath;
    strokeLayer.fillColor = [UIColor clearColor].CGColor;
    strokeLayer.strokeColor = [UIColor colorWithRed:(194/255.0) green:(77/255.0) blue:(1/255.0) alpha:1].CGColor;
    strokeLayer.lineWidth = 5.0;
    
    // Transparent view that will contain the stroke layer
    UIView *strokeView = [[UIView alloc] initWithFrame:clearRoundedCornerView.bounds];
    strokeView.userInteractionEnabled = NO; // in case your container view contains controls
    [strokeView.layer addSublayer:strokeLayer];
    
    [clearRoundedCornerView addSubview:strokeView];
    
    
    [cell.contentView addSubview:clearRoundedCornerView];
    [cell.contentView sendSubviewToBack:clearRoundedCornerView];
    
    
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AGMAreasCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AGMAreasCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    
    Area *area = [_dataArray objectAtIndex:indexPath.row];
    cell.areaNameLabel.text = area.name;
    cell.areaDescLabel.text = area.bulletDescription;
    cell.areaIconView.image = [UIImage imageNamed:@"LocationsImage"];
    
  
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.00;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // This is what happens when a row is selected
    AGMLocationsViewController *locationsViewController = [[AGMLocationsViewController alloc] init];
    
    NSArray *areas = [Area MR_findAll];
    Area *selectedArea = areas[indexPath.row];
    
    locationsViewController.area = selectedArea;
    
    [self.navigationController pushViewController:locationsViewController animated:YES];
    
    
}

@end
