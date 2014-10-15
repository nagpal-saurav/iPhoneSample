//
//  PDFScannerUtil.h
//  PDFReadingSample
//
//  Created by Saurav Nagpal on 14/10/14.
//  Copyright (c) 2014 Saurav Nagpal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PDFScannerUtil : NSObject

- (void) scanFirstPageOfPDFAtUrl:(NSString*)url;

@end
