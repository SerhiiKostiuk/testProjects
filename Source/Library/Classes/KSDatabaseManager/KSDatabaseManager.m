//
//  KSDatabaseManager.m
//  adamaTestProject
//
//  Created by Сергій Костюк on 14.06.16.
//  Copyright © 2016 Сергій Костюк. All rights reserved.
//

#import "KSDatabaseManager.h"
#import "KSDispatch.h"
#import "KSMacro.h"
#import "FMDB.h"


KSConstString(kKSDatabaseFileName, @"database.sqlite");

@implementation KSDatabaseManager

static KSDatabaseManager *sharedDatabaseManager = nil;


#pragma mark -
#pragma mark Singleton

+ (KSDatabaseManager *)sharedDatabaseManager{
    if (sharedDatabaseManager == nil) {
        sharedDatabaseManager = [[super allocWithZone:NULL] init];

    }
    
    return sharedDatabaseManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initializeDatabase];
    }
    return self;
}


+ (id)allocWithZone:(NSZone*)zone {
    return [self sharedDatabaseManager];
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}


- (void)initializeDatabase {
    
    NSArray *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [documentsPath objectAtIndex:0];
    
    NSString *databasePath = [documentsDirectory stringByAppendingPathComponent:kKSDatabaseFileName];
    [self copyDatabaseIntoDocumentsDirectory:databasePath];
    
    self.database = [FMDatabase databaseWithPath:databasePath];
}

- (void)copyDatabaseIntoDocumentsDirectory:(NSString *)databasePath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    if ([fileManager fileExistsAtPath:databasePath]) {
        [fileManager removeItemAtPath:databasePath error:&error];
        
    } if(![fileManager fileExistsAtPath:databasePath]) {
        NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:kKSDatabaseFileName];
        
        if ([fileManager fileExistsAtPath:sourcePath]) {
            NSError *error;
            [fileManager copyItemAtPath:sourcePath toPath:databasePath error:&error];
            
            if (error !=nil) {
                NSLog(@"%@", error.localizedDescription);
            }
        }
    }
}

- (FMResultSet *)performQuery:(NSString *)query {
    if ([self.database open]) {
        FMResultSet *results = [self.database executeQuery:query];
        return results;
    } else {
        NSLog(@"Can't open the base");
        return nil;
    }
}

@end
