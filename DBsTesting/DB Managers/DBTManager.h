//
//  DBTManager.h
//  DBsTesting
//
//  Created by Ruslan Topchenko on 12/9/13.
//  Copyright (c) 2013 WSI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBTManager : NSObject
{
    NSOperationQueue *_operationQueue;
}

@property (nonatomic, readonly) BOOL isRunning;

- (void)runTests;
- (void)stopTests;
- (void)setupDB;
- (void)spawnReadOperation;
- (void)spawnWriteOperation;
- (void)spawnClearOperation;
- (void)teardownDB;

// callbacks from operations
- (void)dataClearedIn:(NSTimeInterval)seconds;
- (void)dataWrittenIn:(NSTimeInterval)seconds;
- (void)dataReadIn:(NSTimeInterval)seconds withObjectsCount:(NSUInteger)objectsCount;

+ (NSUInteger)numberOfReadOperations;
+ (NSUInteger)numberOfWriteOperations;

@end
