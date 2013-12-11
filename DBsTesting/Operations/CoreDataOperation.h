//
//  CoreDataOperation.h
//  DBsTesting
//
//  Created by Ruslan Topchenko on 12/11/13.
//  Copyright (c) 2013 WSI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "DBTManager.h"
#import "SharedConstants.h"
#import "Taf.h"

@interface CoreDataOperation : NSOperation
{
    DBTManager *_dbManager;
    NSManagedObjectContext *_backgroundContext;
}

- (id)initWithPersistentStoreCoordinator:(NSPersistentStoreCoordinator *)storeCoordinator dataManager:(DBTManager *)dbManager;
- (NSArray *)requestDataForIcaoId:(NSString *)icaoId tableName:(NSString *)tableName;

@end
