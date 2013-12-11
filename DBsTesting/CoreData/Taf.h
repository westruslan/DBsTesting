//
//  Taf.h
//  DBsTesting
//
//  Created by Ruslan Topchenko on 12/11/13.
//  Copyright (c) 2013 WSI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Taf : NSManagedObject

@property (nonatomic, retain) NSString * tableName;
@property (nonatomic, retain) NSDate * expireDate;
@property (nonatomic, retain) NSString * rawText;
@property (nonatomic, retain) NSString * outputString;
@property (nonatomic, retain) NSString * geospatialKey;
@property (nonatomic, retain) NSDate * startTime;
@property (nonatomic, retain) NSDate * endTime;
@property (nonatomic, retain) NSString * icaoId;
@property (nonatomic, retain) NSDate * issueTime;

@end
