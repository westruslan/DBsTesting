//
//  FmdbWriteOperation.m
//  DBsTesting
//
//  Created by Ruslan Topchenko on 12/10/13.
//  Copyright (c) 2013 WSI. All rights reserved.
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
                                [self someTableName],
                                [expireDT timeIntervalSince1970],
                                @"TAF.AMD KBGM 041414Z 0414/0512 22008KT P6SM SCT025 BKN100 TEMPO\
                                0414/0416 BKN025\
                                FM041600 21010KT P6SM BKN040\
                                FM050000 24004KT P6SM SCT200 TEMPO 0509/0512 4SM BR=",
                                @"AMENDED Forecast for KBGM, issued at 14:14Z, Dec 4. VALID from 14:00Z, Dec 4 through 12:00Z, Dec 5",
                                nil,
                                [startTime timeIntervalSince1970],
                                [endTime timeIntervalSince1970],
                                [self someIcaoId],
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
