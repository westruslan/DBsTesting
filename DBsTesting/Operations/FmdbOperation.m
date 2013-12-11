//
//  FmdbOperation.m
//  DBsTesting
//
//  Created by Ruslan Topchenko on 12/10/13.
//  Copyright (c) 2013 WSI. All rights reserved.
//

#import "FmdbOperation.h"

#import "FMDatabaseQueue.h"
#import "DBTManager.h"

@implementation FmdbOperation

- (id)initWithDatabase:(FMDatabaseQueue *)dataBase dataManager:(DBTManager *)dbManager
{
    self = [super init];
    if (self)
    {
        _dataBase = dataBase;
        _dbManager = dbManager;
    }
    
    return self;
}

@end
