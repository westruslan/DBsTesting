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

@interface DBTViewController ()
{
    DBTFmdbManager *_fmdbManager;
    DBTCoreDataManager *_coreDataManager;
    DBTManager *_currentManager;
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
}

- (void)dealloc
{
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

@end
