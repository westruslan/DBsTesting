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
        
        Taf *tafManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Taf" inManagedObjectContext:_backgroundContext];
        // Updating with data
        tafManagedObject.tableName = [SharedConstants someTableName];
        tafManagedObject.expireDate = expireDT;
        tafManagedObject.rawText = @"TAF.AMD KBGM 041414Z 0414/0512 22008KT P6SM SCT025 BKN100 TEMPO\
        0414/0416 BKN025\
        FM041600 21010KT P6SM BKN040\
        FM050000 24004KT P6SM SCT200 TEMPO 0509/0512 4SM BR=";
        tafManagedObject.outputString = @"AMENDED Forecast for KBGM, issued at 14:14Z, Dec 4. VALID from 14:00Z, Dec 4 through 12:00Z, Dec 5";
        tafManagedObject.geospatialKey = nil;
        tafManagedObject.startTime = startTime;
        tafManagedObject.endTime = endTime;
        tafManagedObject.icaoId = [SharedConstants someIcaoId];
        tafManagedObject.issueTime = endTime;
        
        //[_backgroundContext save:NULL];
    
        // TODO: some operations
        NSDate *endDate = [NSDate date];
        [_dbManager dataWrittenIn:[endDate timeIntervalSinceDate:startDate]];
    }
}

@end
