//
//  DBTManager.m
//  DBsTesting
//
//  Created by Ruslan Topchenko on 12/9/13.
//  Copyright (c) 2013. All rights reserved.
//

#import "DBTManager.h"


@interface DBTManager ()
{
    NSTimer *_readTimer;
    NSTimer *_writeTimer;
    NSTimer *_clearTimer;
    
    NSTimeInterval _totalReadTime;
    NSTimeInterval _totalWriteTime;
    NSTimeInterval _totalClearTime;
}

@end

@implementation DBTManager

@synthesize isRunning = _isRunning;

@synthesize longestReadTime = _longestReadTime;
@synthesize longestWriteTime = _longestWriteTime;
@synthesize longestClearTime = _longestClearTime;

@synthesize totalReadCalls = _totalReadCalls;
@synthesize totalWriteCalls = _totalWriteCalls;
@synthesize totalClearCalls = _totalClearCalls;

@synthesize totalObjectsRead = _totalObjectsRead;

@synthesize readOperationsCount = _readOperationsCount;
@synthesize writeOperationsCount = _writeOperationsCount;
@synthesize clearOperationsCount = _clearOperationsCount;

- (id)init
{
    self = [super init];
    if (self)
    {
        _operationQueue = [[NSOperationQueue alloc] init];
        _isRunning = NO;
        
        [self clearStatistics];
    }
    
    return self;
}

- (void)dealloc
{
    [_operationQueue release];
    
    [super dealloc];
}

- (void)runTests
{
    [self clearStatistics];
    _readTimer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(readTimerFireMethod:) userInfo:nil repeats:YES];
    _writeTimer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(writeTimerFireMethod:) userInfo:nil repeats:YES];
    _clearTimer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(spawnTimerFireMethod:) userInfo:nil repeats:YES];
    
    _isRunning = YES;
}

- (void)stopTests
{
    [_readTimer invalidate];
    [_writeTimer invalidate];
    [_clearTimer invalidate];
    
    _isRunning = NO;
}

- (void)readTimerFireMethod:(NSTimer *)timer
{
    for (NSInteger index = 0; index <= [DBTManager numberOfReadOperations]; index++)
    {
        _readOperationsCount++;
        [self spawnReadOperation];
    }
}

- (void)writeTimerFireMethod:(NSTimer *)timer
{
    for (NSInteger index = 0; index <= [DBTManager numberOfWriteOperations]; index++)
    {
        _writeOperationsCount++;
        [self spawnWriteOperation];
    }
}

- (void)spawnTimerFireMethod:(NSTimer *)timer
{
    _clearOperationsCount++;
    [self spawnClearOperation];
}

- (void)setupDB
{
    NSLog(@"%s: not implemented", __PRETTY_FUNCTION__);
}

- (void)spawnReadOperation
{
    NSLog(@"%s: not implemented", __PRETTY_FUNCTION__);
}

- (void)spawnWriteOperation
{
    NSLog(@"%s: not implemented", __PRETTY_FUNCTION__);
}

- (void)spawnClearOperation
{
    NSLog(@"%s: not implemented", __PRETTY_FUNCTION__);
}

- (void)dataClearedIn:(NSTimeInterval)seconds
{
    dispatch_async(dispatch_get_main_queue(), ^{
        _longestClearTime = MAX(_longestClearTime, seconds);
        _totalClearCalls++;
        _totalClearTime += seconds;
        _clearOperationsCount--;
    });
}

- (void)dataWrittenIn:(NSTimeInterval)seconds
{
    dispatch_async(dispatch_get_main_queue(), ^{
        _longestWriteTime = MAX(_longestWriteTime, seconds);
        _totalWriteCalls++;
        _totalWriteTime += seconds;
        _writeOperationsCount--;
    });
}

- (void)dataReadIn:(NSTimeInterval)seconds withObjectsCount:(NSUInteger)objectsCount
{
    dispatch_async(dispatch_get_main_queue(), ^{
        _longestReadTime = MAX(_longestReadTime, seconds);
        _totalObjectsRead += objectsCount;
        _totalReadCalls++;
        _totalReadTime += seconds;
        _readOperationsCount--;
    });
}

- (void)teardownDB
{
    [_operationQueue cancelAllOperations];
}

- (void)clearStatistics
{
    _longestReadTime = 0.0;
    _longestWriteTime = 0.0;
    _longestClearTime = 0.0;
    _totalReadCalls = 0;
    _totalWriteCalls = 0;
    _totalClearCalls = 0;
    _totalObjectsRead = 0;
    _totalReadTime = 0.0;
    _totalWriteTime = 0.0;
    _totalClearTime = 0.0;
    
    _readOperationsCount = 0;
    _writeOperationsCount = 0;
    _clearOperationsCount = 0;
}

- (NSTimeInterval)averageReadTime
{
    return _totalReadCalls > 0.0 ? _totalReadTime / (NSTimeInterval)_totalReadCalls : 0.0;
}

- (NSTimeInterval)averageWriteTime
{
    return _totalWriteCalls > 0.0 ? _totalWriteTime / (NSTimeInterval)_totalWriteCalls : 0.0;
}

- (NSTimeInterval)averageClearTime
{
    return _totalClearCalls > 0.0 ? _totalClearTime / (NSTimeInterval)_totalClearCalls : 0.0;
}

- (NSInteger)totalRunningOperations
{
    return _operationQueue.operationCount;
}

- (NSInteger)totalFinishedOperations
{
    return _totalClearCalls + _totalReadCalls + _totalWriteCalls;
}

- (CGFloat)readSpeed
{
    return _totalReadTime ? _totalReadCalls / _totalReadTime : .0f;
}

- (CGFloat)writeSpeed
{
    return _totalWriteTime ? _totalWriteCalls / _totalWriteTime : .0f;
}

- (CGFloat)clearSpeed
{
    return _totalClearTime ? _totalClearCalls / _totalClearTime : .0f;
}

+ (NSUInteger)numberOfReadOperations
{
    return 2;
}

+ (NSUInteger)numberOfWriteOperations
{
    return 4;
}

@end
