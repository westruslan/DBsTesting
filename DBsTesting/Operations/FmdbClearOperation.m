//
//  FmdbClearOperation.m
//  DBsTesting
//
//  Created by Ruslan Topchenko on 12/10/13.
//  Copyright (c) 2013. All rights reserved.
//

#import "FmdbClearOperation.h"
#import "FMDatabaseQueue.h"
#import "FMDatabase.h"
#import "DBTManager.h"

@implementation FmdbClearOperation

- (void)main
{
    __block NSString *tafClearQuery = [NSString stringWithFormat:@"DELETE FROM %@ WHERE icao_id = '%@'", [SharedConstants someTableName], [SharedConstants someIcaoId]];
    if (![self isCancelled])
    {
        NSDate *startDate = [NSDate date];
        [_dataBase inDatabase:^(FMDatabase *db)
         {
             [db executeUpdate:tafClearQuery];
         }];
        NSDate *endDate = [NSDate date];
        
        [_dbManager dataClearedIn:[endDate timeIntervalSinceDate:startDate]];
    }
}

@end
