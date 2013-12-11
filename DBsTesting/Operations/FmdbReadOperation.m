//
//  FmdbReadOperation.m
//  DBsTesting
//
//  Created by Ruslan Topchenko on 12/10/13.
//  Copyright (c) 2013 WSI. All rights reserved.
//

#import "FmdbReadOperation.h"
#import "FMDatabaseQueue.h"
#import "FMDatabase.h"
#import "DBTManager.h"

static NSString * const kSelectTafQueryFormat = @"SELECT raw_text from %@ WHERE icao_id = '%@'";


@implementation FmdbReadOperation

- (void)main
{
    __block NSMutableArray *results = [NSMutableArray array];
    __block NSString *tafQueryRequest = [NSString stringWithFormat:kSelectTafQueryFormat, [SharedConstants someTableName], [SharedConstants someIcaoId]];
    if (![self isCancelled])
    {
        NSDate *startDate = [NSDate date];
        [_dataBase inDatabase:^(FMDatabase *db)
         {
             FMResultSet *queryResults = [db executeQuery:tafQueryRequest];
             
             while ([queryResults next])
             {
                 NSString *response = [queryResults stringForColumnIndex:0];
                 
                 if (response)
                 {
                     [results addObject:response];
                 }
             }
         }];
        NSDate *endDate = [NSDate date];
        [_dbManager dataReadIn:[endDate timeIntervalSinceDate:startDate] withObjectsCount:results.count];
    }
}

@end
