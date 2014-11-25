//
//  AGMAreasCell.h
//  Anglers411
//
//  Created by Ben Russell on 8/20/14.
//  Copyright (c) 2014 Angry Grouse Media. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AGMAreasCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *areaNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *areaDescLabel;

@property (weak, nonatomic) IBOutlet UIImageView *areaIconView;

@end
