//
//  FmdbOperation.h
//  DBsTesting
//
//  Created by Ruslan Topchenko on 12/10/13.
//  Copyright (c) 2013 WSI. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMDatabaseQueue;
@class DBTManager;

@interface FmdbOperation : NSOperation
{
    FMDatabaseQueue *_dataBase;
    DBTManager *_dbManager;
}

- (id)initWithDatabase:(FMDatabaseQueue *)dataBase dataManager:(DBTManager *)dbManager;
- (NSString *)someIcaoId;
- (NSString *)someTableName;

@end