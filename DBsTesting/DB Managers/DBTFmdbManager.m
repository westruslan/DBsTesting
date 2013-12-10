//
//  DBTFmdbManager.m
//  DBsTesting
//
//  Created by Ruslan Topchenko on 12/9/13.
//  Copyright (c) 2013 WSI. All rights reserved.
//

#import "DBTFmdbManager.h"
#import "FMDatabaseQueue.h"
#import "FMDatabase.h"
#import "FmdbReadOperation.h"
#import "FmdbWriteOperation.h"
#import "FmdbClearOperation.h"


@interface DBTFmdbManager ()
{
    FMDatabaseQueue *_dataBase;
}

@end

@implementation DBTFmdbManager

- (id)init
{
    self = [super init];
    if (self)
    {
        _dataBase = nil;
    }
    
    return self;
}

- (void)dealloc
{
    [_dataBase close];
    [_dataBase release];
    
    [super dealloc];
}

- (void)setupDB
{
    if (_dataBase)
        [self teardownDB];
    
    NSString *dbName = [NSTemporaryDirectory() stringByAppendingPathComponent:@"test.db"];
    NSLog(@"%s: DB at path: %@", __PRETTY_FUNCTION__, dbName);
    if ([[NSFileManager defaultManager] fileExistsAtPath:dbName])
        [[NSFileManager defaultManager] removeItemAtPath:dbName error:NULL];
    _dataBase = [[FMDatabaseQueue alloc] initWithPath:dbName];
    
    // Create some tables to insert data into
    [_dataBase inDatabase:^(FMDatabase *db)
    {
        [db executeUpdate:@"CREATE TABLE TAF (expiration_date float, raw_text TEXT, output_string TEXT, geospatial_key TEXT, start_time INTEGER, end_time INTEGER, icao_id varchar(4), issue_time INTEGER);"];
    }];
}

- (void)spawnReadOperation
{
    for (NSInteger index = 0; index <= [DBTManager numberOfReadOperations]; index++)
    {
        FmdbReadOperation *readOperation = [[FmdbReadOperation alloc] initWithDatabase:_dataBase dataManager:self];
        [_operationQueue addOperation:readOperation];
        [readOperation release];
    }
}

- (void)spawnWriteOperation
{
    for (NSInteger index = 0; index <= [DBTManager numberOfWriteOperations]; index++)
    {
        FmdbWriteOperation *writeOperation = [[FmdbWriteOperation alloc] initWithDatabase:_dataBase dataManager:self];
        [_operationQueue addOperation:writeOperation];
        [writeOperation release];
    }
}

- (void)spawnClearOperation
{
    FmdbClearOperation *clearOperation = [[FmdbClearOperation alloc] initWithDatabase:_dataBase dataManager:self];
    [_operationQueue addOperation:clearOperation];
    [clearOperation release];
}

- (void)teardownDB
{
    [super teardownDB];
    
    [_dataBase close];
    [_dataBase release];
    _dataBase = nil;
}

@end
