//
//  DBTViewController.m
//  DBsTesting
//
//  Created by Ruslan Topchenko on 12/9/13.
//  Copyright (c) 2013 WSI. All rights reserved.
//

#import "DBTViewController.h"
#import "DBTFmdbManager.h"
#import "DBTCoreDataManager.h"

static NSString * const kTopLabelFormat  =  @"Operation AverageTime(s) LongestTime(s) Speed(ops)";
static NSString * const kReadLabelFormat =  @"READ      %2.2f           %2.2f           %2.2f        Objects=%d";
static NSString * const kWriteLabelFormat = @"WRITE     %2.2f           %2.2f           %2.2f";
static NSString * const kClearLabelFormat = @"CLEARS    %2.2f           %2.2f           %2.2f";
static NSString * const kOtherInfoLableFormat = @"Queued ops = %u (R=%d,W=%d,C=%d), Finished ops = %u (R=%d,W=%d,C=%d)";

@interface DBTViewController ()
{
    DBTFmdbManager *_fmdbManager;
    DBTCoreDataManager *_coreDataManager;
    DBTManager *_currentManager;
    NSTimer *_refreshTimer;
}

@end

@implementation DBTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _fmdbManager = [[DBTFmdbManager alloc] init];
    _coreDataManager = [[DBTCoreDataManager alloc] init];
    _currentManager = nil;
    
    _topLabel.text = kTopLabelFormat;
    _readOperations.text = [NSString stringWithFormat:kReadLabelFormat, 0.0, 0.0, 0.0, 0];
    _writeOperations.text = [NSString stringWithFormat:kWriteLabelFormat, 0.0, 0.0, 0.0];
    _clearOperations.text = [NSString stringWithFormat:kClearLabelFormat, 0.0, 0.0, 0.0];
    _otherInfo.text = [NSString stringWithFormat:kOtherInfoLableFormat, 0, 0, 0, 0, 0, 0, 0, 0];
    
    _refreshTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(refreshStatistics) userInfo:nil repeats:YES];
}

- (void)dealloc
{
    [_refreshTimer invalidate];
    [_fmdbManager release];
    [_coreDataManager release];
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)fmdbTestTapped
{
    [self stopRunningTests];
    
    NSLog(@"Spawning FMDBs");
    _currentManager = _fmdbManager;
    [_fmdbManager setupDB];
    [_fmdbManager runTests];
}

- (IBAction)cdTestTapped
{
    [self stopRunningTests];
    
    NSLog(@"Spawning CoreData");
    _currentManager = _coreDataManager;
    [_coreDataManager setupDB];
    [_coreDataManager runTests];
}

- (IBAction)stopRunningTests
{
    if (_currentManager.isRunning)
    {
        [_currentManager stopTests];
        [_currentManager teardownDB];
        _currentManager = nil;
    }
}

- (void)refreshStatistics
{
    if (_currentManager)
    {
        _readOperations.text = [NSString stringWithFormat:kReadLabelFormat, [_currentManager averageReadTime], _currentManager.longestReadTime, [_currentManager readSpeed], _currentManager.totalObjectsRead];
        _writeOperations.text = [NSString stringWithFormat:kWriteLabelFormat, [_currentManager averageWriteTime], _currentManager.longestWriteTime, [_currentManager writeSpeed]];
        _clearOperations.text = [NSString stringWithFormat:kClearLabelFormat, [_currentManager averageClearTime], _currentManager.longestClearTime, [_currentManager clearSpeed]];
        _otherInfo.text = [NSString stringWithFormat:kOtherInfoLableFormat, [_currentManager totalRunningOperations], _currentManager.readOperationsCount, _currentManager.writeOperationsCount, _currentManager.clearOperationsCount, [_currentManager totalFinishedOperations], _currentManager.totalReadCalls, _currentManager.totalWriteCalls, _currentManager.totalClearCalls];
    }
}

@end
