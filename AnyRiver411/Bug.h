//
//  Bug.h
//  AnyRiver411
//
//  Created by Ben Russell on 11/25/14.
//  Copyright (c) 2014 Ben Russell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Bug : NSManagedObject

@property (nonatomic, retain) NSString * fall;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * spring;
@property (nonatomic, retain) NSString * summer;
@property (nonatomic, retain) NSString * winter;
@property (nonatomic, retain) NSManagedObject *location;

@end
