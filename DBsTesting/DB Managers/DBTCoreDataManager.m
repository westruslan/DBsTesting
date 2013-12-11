//
//  DBTCoreDataManager.m
//  DBsTesting
//
//  Created by Ruslan Topchenko on 12/9/13.
//  Copyright (c) 2013. All rights reserved.
//

#import "DBTCoreDataManager.h"
#import <CoreData/CoreData.h>
#import "CoreDataReadOperation.h"
#import "CoreDataWriteOperation.h"
#import "CoreDataClearOperation.h"

@implementation DBTCoreDataManager
{
    NSManagedObjectModel *_managedObjectModel;
    NSPersistentStoreCoordinator *_persistentStoreCoordinator;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _managedObjectModel = nil;
        _persistentStoreCoordinator = nil;
    }
    
    return self;
}

- (void)dealloc
{
    [_persistentStoreCoordinator release];
    [_managedObjectModel release];
    
    [super dealloc];
}

- (void)setupDB
{
    if (_persistentStoreCoordinator)
        [self teardownDB];
    
    NSURL *modelURL = [[[NSBundle mainBundle] URLForResource:@"TafModel" withExtension:@"momd"] URLByAppendingPathComponent:@"TafModel.mom"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    NSString *storeFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"CoreDataTafs.sqlite"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:storeFilePath])
        [[NSFileManager defaultManager] removeItemAtPath:storeFilePath error:NULL];
    
    NSURL *storeURL = [NSURL fileURLWithPath:storeFilePath];
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_managedObjectModel];
    NSPersistentStore *addedStore = [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
    if (!addedStore || error)
    {
        NSLog(@"Error: %@.", error ? [error localizedDescription] : @"can not create store");
        [self teardownDB];
    }
}

- (void)spawnReadOperation
{
    CoreDataReadOperation *operation = [[CoreDataReadOperation alloc] initWithPersistentStoreCoordinator:_persistentStoreCoordinator dataManager:self];
    [_operationQueue addOperation:operation];
    [operation release];
}

- (void)spawnWriteOperation
{
    CoreDataWriteOperation *operation = [[CoreDataWriteOperation alloc] initWithPersistentStoreCoordinator:_persistentStoreCoordinator dataManager:self];
    [_operationQueue addOperation:operation];
    [operation release];
}

- (void)spawnClearOperation
{
    CoreDataClearOperation *operation = [[CoreDataClearOperation alloc] initWithPersistentStoreCoordinator:_persistentStoreCoordinator dataManager:self];
    [_operationQueue addOperation:operation];
    [operation release];
}

- (void)teardownDB
{
    [super teardownDB];
    
    [_persistentStoreCoordinator release];
    _persistentStoreCoordinator = nil;
    [_managedObjectModel release];
    _managedObjectModel = nil;
}

@end
