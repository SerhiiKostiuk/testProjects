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
#import "KSPreparations.h"

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

#pragma mark -
#pragma mark Class Methods

+ (id)allocWithZone:(NSZone*)zone {
    return [self sharedDatabaseManager];
}

+ (NSMutableArray *)loadFromBaseWithQuery:(NSString *)query {
    KSDatabaseManager *dbManager = [KSDatabaseManager sharedDatabaseManager];
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    FMResultSet *results = [dbManager performQuery:query];
    while ([results next]) {
        [mutableArray addObject:[[KSPreparations alloc] initWithFMDBSet:results]];
    }
    
    return mutableArray;
}


#pragma mark -
#pragma mark Initializations And Deallocations

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initializeDatabase];
    }
    return self;
}

#pragma mark -
#pragma mark Public

- (FMResultSet *)performQuery:(NSString *)query {
    if ([self.database open]) {
        FMResultSet *results = [self.database executeQuery:query];
        return results;
        
    } else {
        NSLog(@"Can't open the base");
        return nil;
    }
}

#pragma mark -
#pragma mark Private

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

@end
