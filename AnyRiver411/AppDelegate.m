//
//  AppDelegate.m
//  AnyRiver411
//
//  Created by Ben Russell on 11/25/14.
//  Copyright (c) 2014 Ben Russell. All rights reserved.
//

#import "AppDelegate.h"
// import needed podfiles
#import "CoreData/CoreData.h"
#import "CoreData+MagicalRecord.h"
#import "AFNetworking.h"
#import "Reachability.h"

// import core data models
#import "Area.h"
#import "Location.h"
#import "Bug.h"



@interface AppDelegate ()

@end

@implementation AppDelegate

#define aWaterURL [NSURL URLWithString:@"http://www.anglers411.com/river?waterId=1"]


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [MagicalRecord setupAutoMigratingCoreDataStack];

    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"AGM_DataSetup"]) {
        
        NSError* jsonError;
        NSArray* json;
        
        Reachability *reachability = [Reachability reachabilityForInternetConnection];
        NetworkStatus internetStatus = [reachability currentReachabilityStatus];
        
        if (internetStatus == NotReachable) {
            NSLog(@"Offline");
            NSString *filePath = [[NSBundle mainBundle] pathForResource:@"static" ofType:@"json"];
            NSString *myJSON = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
            json = [NSJSONSerialization JSONObjectWithData:[myJSON dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&jsonError];
        } else {
            NSLog(@"Online");
            NSData* data = [NSData dataWithContentsOfURL:
                            aWaterURL];
            json = [NSJSONSerialization
                    JSONObjectWithData:data
                    options:kNilOptions
                    error:&jsonError];
        }
        
        if (!jsonError) {
            
            [MagicalRecord cleanUp];
            NSString* folderPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            NSError *error = nil;
            for (NSString *file in [[NSFileManager defaultManager] contentsOfDirectoryAtPath:folderPath error:&error])
            {
                [[NSFileManager defaultManager] removeItemAtPath:[folderPath stringByAppendingPathComponent:file] error:&error];
                if(error)
                {
                    NSLog(@"Delete error: %@", error.description);
                }
            }
            
            [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:@"Anglers411.sqlite"];
            
            NSLog(@"Initial Data Load");
            
            
            for (id jsonArea in json) {
                
                // Create an area
                Area *area = [Area MR_createEntity];
                area.name  = [jsonArea objectForKey:@"name"];
                area.bulletDescription  = [jsonArea objectForKey:@"bulletDescription"];
                area.uid  = [jsonArea objectForKey:@"id"];
                
                NSArray* jsonLocations  = [jsonArea objectForKey:@"locations"];
                
                for (id jsonLocation in jsonLocations) {
                    
                    // create a location
                    Location *location = [Location MR_createEntity];
                    location.uid = [jsonLocation objectForKey:@"id"];
                    location.name = [jsonLocation objectForKey:@"name"];
                    location.desc = [jsonLocation objectForKey:@"desc"];
                    location.directions = [jsonLocation objectForKey:@"directions"];
                    location.bulletDescription = [jsonLocation objectForKey:@"bulletDescription"];
                    location.area = area;
                    
                    NSArray* jsonBugs  = [jsonLocation objectForKey:@"bugs"];
                    
                    for (id jsonBug in jsonBugs) {
                        Bug *bug = [Bug MR_createEntity];
                        bug.name = [jsonBug objectForKey:@"name"];
                        bug.spring = [jsonBug objectForKey:@"spring"];
                        bug.summer = [jsonBug objectForKey:@"summer"];
                        bug.fall = [jsonBug objectForKey:@"fall"];
                        bug.winter = [jsonBug objectForKey:@"winter"];
                        bug.location = location;
                    }
                }
                
            }
            
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
            
            // Set User Default to prevent another preload of data on startup.
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"AGM_DataSetup"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [MagicalRecord setupAutoMigratingCoreDataStack];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"EnteredForeground" object:nil];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
    [self saveContext];
}



#pragma mark - Core Data Saving support

- (void)saveContext {
    [MagicalRecord cleanUp];
}

@end
