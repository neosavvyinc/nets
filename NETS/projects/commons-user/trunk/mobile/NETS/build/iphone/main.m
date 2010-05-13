//
//  Appcelerator Titanium Mobile
//  WARNING: this is a generated file and should not be modified
//

#import <UIKit/UIKit.h>
#define _QUOTEME(x) #x
#define STRING(x) _QUOTEME(x)

NSString * const TI_APPLICATION_DEPLOYTYPE = @"development";
NSString * const TI_APPLICATION_ID = @"com.neosavvy.nets";
NSString * const TI_APPLICATION_PUBLISHER = @"Neosavvy, inc.";
NSString * const TI_APPLICATION_URL = @"http://www.neosavvy.com";
NSString * const TI_APPLICATION_NAME = @"NETS";
NSString * const TI_APPLICATION_VERSION = @"1.0";
NSString * const TI_APPLICATION_DESCRIPTION = @"No description provided";
NSString * const TI_APPLICATION_COPYRIGHT = @"2010 by Neosavvy, inc.";
NSString * const TI_APPLICATION_GUID = @"b8073cf1-feb4-428a-8aef-fa9e18cc13f2";
BOOL const TI_APPLICATION_ANALYTICS = true;

#ifdef DEBUG
NSString * const TI_APPLICATION_RESOURCE_DIR = @"/Users/crumpf/Development/NeoSavvy/commons-user/mobile/NETS/build/iphone/build/Debug-iphonesimulator/NETS.app";
#endif

int main(int argc, char *argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

#ifdef __LOG__ID__
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *logPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%s.log",STRING(__LOG__ID__)]];
	freopen([logPath cStringUsingEncoding:NSUTF8StringEncoding],"w+",stderr);
	fprintf(stderr,"[INFO] Application started\n");
#endif

    int retVal = UIApplicationMain(argc, argv, nil, nil);
    [pool release];
    return retVal;
}
