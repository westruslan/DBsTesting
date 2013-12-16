//
//  DBTViewController.h
//  DBsTesting
//
//  Created by Ruslan Topchenko on 12/9/13.
//  Copyright (c) 2013. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DBTViewController : UIViewController
{
    IBOutlet UILabel *_topLabel;
    IBOutlet UILabel *_readOperations;
    IBOutlet UILabel *_writeOperations;
    IBOutlet UILabel *_clearOperations;
    IBOutlet UILabel *_otherInfo;
    IBOutlet UILabel *_testedDBNameLabel;
}

- (IBAction)fmdbTestTapped;
- (IBAction)cdTestTapped;
- (IBAction)stopRunningTests;

@end
