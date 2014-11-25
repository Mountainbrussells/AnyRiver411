//
//  Location.h
//  AnyRiver411
//
//  Created by Ben Russell on 11/25/14.
//  Copyright (c) 2014 Ben Russell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Area, Bug;

@interface Location : NSManagedObject

@property (nonatomic, retain) NSString * bulletDescription;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * directions;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * uid;
@property (nonatomic, retain) Area *area;
@property (nonatomic, retain) Bug *bugs;

@end
