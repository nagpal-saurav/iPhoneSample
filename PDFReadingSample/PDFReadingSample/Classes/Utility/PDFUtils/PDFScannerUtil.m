//
//  PDFScannerUtil.m
//  PDFReadingSample
//
//  Created by Saurav Nagpal on 14/10/14.
//  Copyright (c) 2014 Saurav Nagpal. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "PDFScannerUtil.h"

@implementation PDFScannerUtil

- (void) scanFirstPageOfPDFAtUrl:(NSString*)url{
    CGPDFDocumentRef myDocument;
    myDocument = CGPDFDocumentCreateWithURL(url);// 1
    if (myDocument == NULL) {// 2
        error ("can't open `%s'.", filename);
        CFRelease (url);
        return EXIT_FAILURE;
    }
    CFRelease (url);
    
    int k;
    CGPDFPageRef myPage;
    CGPDFScannerRef myScanner;
    CGPDFContentStreamRef myContentStream;
    
    numOfPages = CGPDFDocumentGetNumberOfPages (myDocument);// 1
    for (k = 0; k < numOfPages; k++) {
        myPage = CGPDFDocumentGetPage (myDocument, k + 1 );// 2
        myContentStream = CGPDFContentStreamCreateWithPage (myPage);// 3
        myScanner = CGPDFScannerCreate (myContentStream, myTable, NULL);// 4
        CGPDFScannerScan (myScanner);// 5
        CGPDFPageRelease (myPage);// 6
        CGPDFScannerRelease (myScanner);// 7
        CGPDFContentStreamRelease (myContentStream);// 8
    }
    CGPDFOperatorTableRelease(myTable);
}

@end
