//
//  SharedConstants.m
//  DBsTesting
//
//  Created by Ruslan Topchenko on 12/11/13.
//  Copyright (c) 2013 WSI. All rights reserved.
//

#import "SharedConstants.h"

@implementation SharedConstants

+ (NSString *)someIcaoId
{
    switch (rand() % 5)
    {
        case 0:
            return @"KBOS";
        case 1:
            return @"KMCO";
        case 2:
            return @"KSEA";
        case 3:
            return @"KLVR";
        default:
            return @"KSFO";
    }
}

+ (NSString *)someTableName
{
    switch (rand() % 5)
    {
        case 0:
            return @"TAF";
        case 1:
            return @"METAR";
        case 2:
            return @"TAF1";
        case 3:
            return @"METAR1";
        default:
            return @"METAR2";
    }
}

@end
