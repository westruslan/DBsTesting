//
//  DBTManager.m
//  DBsTesting
//
//  Created by Ruslan Topchenko on 12/9/13.
//  Copyright (c) 2013 WSI. All rights reserved.
//

#import "DBTManager.h"


@interface DBTManager ()
{
    NSTimer *_readTimer;
    NSTimer *_writeTimer;
    NSTimer *_clearTimer;
}

@end

@implementation DBTManager

@synthesize isRunning = _isRunning;

- (id)init
{
    self = [super init];
    if (self)
    {
        _operationQueue = [[NSOperationQueue alloc] init];
        _isRunning = NO;
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
    _readTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(readTimerFireMethod:) userInfo:nil repeats:YES];
    _writeTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(writeTimerFireMethod:) userInfo:nil repeats:YES];
    _clearTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(spawnTimerFireMethod:) userInfo:nil repeats:YES];
    
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
    [self spawnReadOperation];
}

- (void)writeTimerFireMethod:(NSTimer *)timer
{
    [self spawnWriteOperation];
}

- (void)spawnTimerFireMethod:(NSTimer *)timer
{
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
    NSLog(@"clearTimeInterval = %f", seconds);
}

- (void)dataWrittenIn:(NSTimeInterval)seconds
{
    NSLog(@"writeTimeInterval = %f", seconds);
}

- (void)dataReadIn:(NSTimeInterval)seconds withObjectsCount:(NSUInteger)objectsCount
{
    NSLog(@"readTimeInterval = %f, obj=%u", seconds, objectsCount);
}

- (void)teardownDB
{
    [_operationQueue cancelAllOperations];
}

+ (NSUInteger)numberOfReadOperations
{
    return 10;
}

+ (NSUInteger)numberOfWriteOperations
{
    return 20;
}

@end
