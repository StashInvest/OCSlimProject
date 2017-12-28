#import "OCSPTestReportReader.h"

@implementation OCSPTestReportFileReader

- (NSData *) read {
    
    NSString *fitnesseTestReportResourceName = @"Fitnesse-Test-Report";
    
    NSBundle *bundle            = [NSBundle bundleForClass:[self class]];
    NSString *targetBundlePath  = [[bundle.bundlePath stringByDeletingLastPathComponent] stringByDeletingLastPathComponent];
    NSString *path              = [[targetBundlePath stringByAppendingPathComponent:fitnesseTestReportResourceName] stringByAppendingPathExtension:@"xml"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        
        NSLog(@"[OCSP] ERROR: Could not read data : The file \"%@.xml\" couldn’t be opened because there is no such file at \"%@\": Check your 'OCSlimProject' Acceptance Test target is being built. 1) Try running 'pod update' to resolve this issue. 2) Manually run Acceptance Tests using '$ ./LaunchFitnesse' located at your projects root directory and investigate any issues.", targetBundlePath, path, nil);
        
    }
    
    return [NSData dataWithContentsOfFile:path];

}

@end


/// OCSPTestReportReader ///

@implementation OCSPTestReportReader

static id<OCSPTestReportReader> _defaultReader;

+ (id<OCSPTestReportReader>)defaultReader {
    
    return _defaultReader;
    
}

+ (void)initialize {
    
    _defaultReader = [[OCSPTestReportFileReader alloc] init];
    
}

+ (void)setDefaultReader:(id<OCSPTestReportReader>)reader {
    
    _defaultReader = reader;
    
}


@end



