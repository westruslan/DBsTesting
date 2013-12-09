//
//  DBTViewController.m
//  DBsTesting
//
//  Created by Ruslan Topchenko on 12/9/13.
//  Copyright (c) 2013 WSI. All rights reserved.
//

#import "DBTViewController.h"

@interface DBTViewController ()

@end

@implementation DBTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)fmdbTestTapped
{
    NSLog(@"Spawning FMDBs");
}

- (IBAction)cdTestTapped
{
    NSLog(@"Spawning CoreData");
}

@end
