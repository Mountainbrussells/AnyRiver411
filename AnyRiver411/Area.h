//
//  Area.h
//  AnyRiver411
//
//  Created by Ben Russell on 11/25/14.
//  Copyright (c) 2014 Ben Russell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Area : NSManagedObject

@property (nonatomic, retain) NSString * bulletDescription;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * uid;
@property (nonatomic, retain) NSManagedObject *location;

@end
