//
//  FmdbWriteOperation.m
//  DBsTesting
//
//  Created by Ruslan Topchenko on 12/10/13.
//  Copyright (c) 2013. All rights reserved.
//

#import "FmdbWriteOperation.h"
#import "FMDatabaseQueue.h"
#import "FMDatabase.h"
#import "DBTManager.h"

static NSString * const kTafInsertQuery = @"INSERT INTO %@ VALUES ('%f', '%@', '%@', '%@', %f, %f, '%@', %f)";

@implementation FmdbWriteOperation

- (void)main
{
    NSDate *expireDT = [NSDate date];
    NSDate *startTime = [expireDT dateByAddingTimeInterval:2*60*60.0];
    NSDate *endTime = [expireDT dateByAddingTimeInterval:4*60*60.0];
    NSString *tafInsertQuery = [[NSString alloc] initWithFormat:kTafInsertQuery,
                                [SharedConstants someTableName],
                                [expireDT timeIntervalSince1970],
                                [SharedConstants tafRawText],
                                [SharedConstants tafOutputString],
                                nil,
                                [startTime timeIntervalSince1970],
                                [endTime timeIntervalSince1970],
                                [SharedConstants someIcaoId],
                                [endTime timeIntervalSince1970]];
    
    if (![self isCancelled])
    {
        NSDate *startDate = [NSDate date];
        [_dataBase inDatabase:^(FMDatabase *db)
         {
             [db executeUpdate:tafInsertQuery];
         }];
        NSDate *endDate = [NSDate date];
        
        [_dbManager dataWrittenIn:[endDate timeIntervalSinceDate:startDate]];
    }
    
    [tafInsertQuery release];
}

@end
