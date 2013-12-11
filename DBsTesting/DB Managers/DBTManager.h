//
//  DBTManager.h
//  DBsTesting
//
//  Created by Ruslan Topchenko on 12/9/13.
//  Copyright (c) 2013. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBTManager : NSObject
{
    NSOperationQueue *_operationQueue;
}

@property (nonatomic, readonly) BOOL isRunning;

// Statistic properties/methods
@property (nonatomic, readonly) NSTimeInterval longestReadTime;
@property (nonatomic, readonly) NSTimeInterval longestWriteTime;
@property (nonatomic, readonly) NSTimeInterval longestClearTime;

@property (nonatomic, readonly) NSInteger totalReadCalls;
@property (nonatomic, readonly) NSInteger totalWriteCalls;
@property (nonatomic, readonly) NSInteger totalClearCalls;

@property (nonatomic, readonly) NSInteger totalObjectsRead;

@property (nonatomic, readonly) NSInteger readOperationsCount;
@property (nonatomic, readonly) NSInteger writeOperationsCount;
@property (nonatomic, readonly) NSInteger clearOperationsCount;

- (NSTimeInterval)averageReadTime;
- (NSTimeInterval)averageWriteTime;
- (NSTimeInterval)averageClearTime;
- (NSInteger)totalRunningOperations;
- (NSInteger)totalFinishedOperations;

- (CGFloat)readSpeed;
- (CGFloat)writeSpeed;
- (CGFloat)clearSpeed;

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

// static methods to define number of operations that should be launched
+ (NSUInteger)numberOfReadOperations;
+ (NSUInteger)numberOfWriteOperations;

@end
