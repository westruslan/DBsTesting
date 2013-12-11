//
//  CoreDataWriteOperation.m
//  DBsTesting
//
//  Created by Ruslan Topchenko on 12/11/13.
//  Copyright (c) 2013 WSI. All rights reserved.
//

#import "CoreDataWriteOperation.h"

@implementation CoreDataWriteOperation

- (void)main
{
    if (![self isCancelled])
    {
        NSDate *startDate = [NSDate date];
        
        NSDate *expireDT = [NSDate date];
        NSDate *startTime = [expireDT dateByAddingTimeInterval:2*60*60.0];
        NSDate *endTime = [expireDT dateByAddingTimeInterval:4*60*60.0];
        
        Taf *tafManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[SharedConstants entityId] inManagedObjectContext:_backgroundContext];
        // Updating with data
        tafManagedObject.tableName = [SharedConstants someTableName];
        tafManagedObject.expireDate = expireDT;
        tafManagedObject.rawText = [SharedConstants tafRawText];
        tafManagedObject.outputString = [SharedConstants tafOutputString];
        tafManagedObject.geospatialKey = nil;
        tafManagedObject.startTime = startTime;
        tafManagedObject.endTime = endTime;
        tafManagedObject.icaoId = [SharedConstants someIcaoId];
        tafManagedObject.issueTime = endTime;
        
        [_backgroundContext save:NULL];
    
        // TODO: some operations
        NSDate *endDate = [NSDate date];
        [_dbManager dataWrittenIn:[endDate timeIntervalSinceDate:startDate]];
    }
}

@end
