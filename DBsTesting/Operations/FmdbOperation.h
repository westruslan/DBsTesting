//
//  FmdbOperation.h
//  DBsTesting
//
//  Created by Ruslan Topchenko on 12/10/13.
//  Copyright (c) 2013. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SharedConstants.h"

@class FMDatabaseQueue;
@class DBTManager;

@interface FmdbOperation : NSOperation
{
    FMDatabaseQueue *_dataBase;
    DBTManager *_dbManager;
}

- (id)initWithDatabase:(FMDatabaseQueue *)dataBase dataManager:(DBTManager *)dbManager;

@end
