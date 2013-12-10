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

- (NSString *)someIcaoId
{
    switch (rand() % 5)
    {
        case 0:
            return @"KBOS";
        case 1:
            return @"KMCO";
        case 2:
            return @"KSEA";
        case 3:
            return @"KLVR";
        default:
            return @"KSFO";
    }
}

- (NSString *)someTableName
{
    switch (rand() % 5)
    {
        case 0:
            return @"TAF";
        case 1:
            return @"METAR";
        case 2:
            return @"TAF1";
        case 3:
            return @"METAR1";
        default:
            return @"METAR2";
    }
}

@end
