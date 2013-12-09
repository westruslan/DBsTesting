//
//  DBTManager.m
//  DBsTesting
//
//  Created by Ruslan Topchenko on 12/9/13.
//  Copyright (c) 2013 WSI. All rights reserved.
//

#import "DBTManager.h"

@implementation DBTManager

- (void)runTests
{
    [self setupDB];
    [self spawnOperations];
    [self teardownDB];
}

- (void)setupDB
{
}

- (void)spawnOperations
{
}

- (void)teardownDB
{
}

@end
