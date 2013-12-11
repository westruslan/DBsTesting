//
//  CoreDataOperation.m
//  DBsTesting
//
//  Created by Ruslan Topchenko on 12/11/13.
//  Copyright (c) 2013. All rights reserved.
//

#import "CoreDataOperation.h"

@implementation CoreDataOperation

- (id)initWithPersistentStoreCoordinator:(NSPersistentStoreCoordinator *)storeCoordinator dataManager:(DBTManager *)dbManager
{
    self = [super init];
    if (self)
    {
        _dbManager = dbManager;
        
        _backgroundContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        _backgroundContext.persistentStoreCoordinator = storeCoordinator;
    }
    
    return self;
}

- (void)dealloc
{
    [_backgroundContext release];
    
    [super dealloc];
}

- (NSArray *)requestDataForIcaoId:(NSString *)icaoId tableName:(NSString *)tableName
{
    NSMutableArray *results = [NSMutableArray array];
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:[SharedConstants entityId] inManagedObjectContext:_backgroundContext];
    request.predicate = [NSPredicate predicateWithFormat:@"(%K like %@) AND (%K like %@)", @"icaoId", icaoId, @"tableName", tableName];
    
    NSError *error = nil;
    NSArray *resultArray = [_backgroundContext executeFetchRequest:request error:&error];
    if (error || !resultArray)
    {
        NSLog(@"Error on data fetching: %@", error ? [error localizedDescription] : @"No data found");
    }
    else
    {
        [results addObjectsFromArray:resultArray];
    }
    [request release];
    
    return results;
}

@end
