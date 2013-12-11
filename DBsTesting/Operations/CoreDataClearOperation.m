//
//  CoreDataClearOperation.m
//  DBsTesting
//
//  Created by Ruslan Topchenko on 12/11/13.
//  Copyright (c) 2013. All rights reserved.
//

#import "CoreDataClearOperation.h"

@implementation CoreDataClearOperation

- (void)main
{
    if (![self isCancelled])
    {
        NSDate *startDate = [NSDate date];
        
        NSArray *results = [self requestDataForIcaoId:[SharedConstants someIcaoId] tableName:[SharedConstants someTableName]];
        for (Taf *tafObject in results)
        {
            [_backgroundContext deleteObject:tafObject];
        }
        
        [_backgroundContext save:NULL];
        
        NSDate *endDate = [NSDate date];
        [_dbManager dataClearedIn:[endDate timeIntervalSinceDate:startDate]];
    }
}

@end
