//
//  AppDelegate.h
//  AnyRiver411
//
//  Created by Ben Russell on 11/25/14.
//  Copyright (c) 2014 Ben Russell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;



- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

