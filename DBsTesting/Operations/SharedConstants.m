//
//  SharedConstants.m
//  DBsTesting
//
//  Created by Ruslan Topchenko on 12/11/13.
//  Copyright (c) 2013. All rights reserved.
//

#import "SharedConstants.h"

@implementation SharedConstants

+ (NSString *)tafRawText
{
    return @"TAF.AMD KBGM 041414Z 0414/0512 22008KT P6SM SCT025 BKN100 TEMPO\
    0414/0416 BKN025\
    FM041600 21010KT P6SM BKN040\
    FM050000 24004KT P6SM SCT200 TEMPO 0509/0512 4SM BR=";
}

+ (NSString *)tafOutputString
{
    return @"AMENDED Forecast for KBGM, issued at 14:14Z, Dec 4. VALID from 14:00Z, Dec 4 through 12:00Z, Dec 5";
}

+ (NSString *)entityId
{
    return @"Taf";
}

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

+ (NSArray *)tableNamesArray
{
    return @[@"TAF", @"METAR", @"TAF1", @"METAR1", @"METAR2"];
}

@end
