//
//  AGMAreasCell.m
//  Anglers411
//
//  Created by Ben Russell on 8/20/14.
//  Copyright (c) 2014 Angry Grouse Media. All rights reserved.
//

#import "AGMAreasCell.h"

@implementation AGMAreasCell

- (void)installSelectedBackgroundView{
    
    UIView *bgCustomView = [[UIView alloc] initWithFrame:CGRectMake(10,10,310,110)];
    bgCustomView.backgroundColor = [UIColor lightGrayColor];
    bgCustomView.layer.masksToBounds = YES;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectOffset(bgCustomView.bounds, 10, 10) byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerBottomLeft) cornerRadii:CGSizeMake(20.0, 20.0)];
    CAShapeLayer *cornerMaskLayer = [CAShapeLayer layer];
    [cornerMaskLayer setPath:path.CGPath];
    bgCustomView.layer.mask = cornerMaskLayer;
    self.selectedBackgroundView = bgCustomView;
    [self setSelected:YES animated:YES];
}
    
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
        self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
        if (self) {
            [self installSelectedBackgroundView];
        }
        return self;
    }
    
- (void)awakeFromNib {
        [super awakeFromNib];
        [self installSelectedBackgroundView];
    }




@end
