//
//  Utility.m
//  PDFReadingSample
//
//  Created by Saurav Nagpal on 09/10/14.
//  Copyright (c) 2014 Saurav Nagpal. All rights reserved.
//

#import "PDFReaderConstant.h"
#import "Utility.h"

@implementation Utility

+ (NSDictionary*) dictFromPlistFileWithName:(NSString*)fileName{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:FILE_TYPE_PLIST];
    NSDictionary *plistDict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    return plistDict;
}

+ (NSArray*) listFromPlistFileWithName:(NSString*)fileName{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:FILE_TYPE_PLIST];
    NSArray  *plistContent = [NSArray arrayWithContentsOfFile:filePath];
    return plistContent;
}

@end

