//
//  CoreDataReadOperation.m
//  DBsTesting
//
//  Created by Ruslan Topchenko on 12/11/13.
//  Copyright (c) 2013. All rights reserved.
//

#import "CoreDataReadOperation.h"

@implementation CoreDataReadOperation

- (void)main
{
    if (![self isCancelled])
    {
        NSDate *startDate = [NSDate date];
        
        NSArray *results = [self requestDataForIcaoId:[SharedConstants someIcaoId] tableName:[SharedConstants someTableName]];
        
        NSDate *endDate = [NSDate date];
        
        [_dbManager dataReadIn:[endDate timeIntervalSinceDate:startDate] withObjectsCount:results.count];
    }
}

@end
