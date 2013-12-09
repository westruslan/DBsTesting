//
//  DBTManager.h
//  DBsTesting
//
//  Created by Ruslan Topchenko on 12/9/13.
//  Copyright (c) 2013 WSI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBTManager : NSObject

- (void)runTests;
- (void)setupDB;
- (void)spawnOperations;
- (void)teardownDB;

@end
