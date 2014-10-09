//
//  Utility.h
//  PDFReadingSample
//


#import <Foundation/Foundation.h>

@interface Utility : NSObject

+ (NSDictionary*) dictFromPlistFileWithName:(NSString*)fileName;
+ (NSArray*) listFromPlistFileWithName:(NSString*)fileName;

@end
