#import <Foundation/Foundation.h>


void changeUserAgent(NSMutableURLRequest *request) {
	[request setValue:@"Drive/4.2021 (iPad; iOS 12.5.8; Scale/2.00)" forHTTPHeaderField:@"User-Agent"];
}

%hook NSMutableURLRequest

+ (instancetype)requestWithURL:(NSURL *)URL {
	// NSLog(@"DriveX: Inside requestWithURL");
    NSMutableURLRequest *request = %orig(URL);
    changeUserAgent(request);
    return request;
}

+ (instancetype)requestWithURL:(NSURL *)URL cachePolicy:(NSURLRequestCachePolicy)cachePolicy timeoutInterval:(NSTimeInterval)timeoutInterval {
	// NSLog(@"DriveX: Inside requestWithURL with the additional args");
    NSMutableURLRequest *request = %orig(URL, cachePolicy, timeoutInterval);
    changeUserAgent(request);
    return request;
}

- (instancetype)initWithURL:(NSURL *)URL {
	// NSLog(@"DriveX: Inside initWithURL");
	NSMutableURLRequest *request = %orig(URL);
    changeUserAgent(request);
    return request;
}

- (instancetype)initWithURL:(NSURL *)URL cachePolicy:(NSURLRequestCachePolicy)cachePolicy timeoutInterval:(NSTimeInterval)timeoutInterval {
	// NSLog(@"DriveX: Inside initWithURL with the additional args");
	NSMutableURLRequest *request = %orig(URL, cachePolicy, timeoutInterval);
    changeUserAgent(request);
    return request;
}

- (void)addValue:(NSString *)value forHTTPHeaderField:(NSString *)field{
	if ([[field lowercaseString] isEqualToString:@"user-agent"]) {
		// NSLog(@"DriveX: We got 'em boys!");
	} else {
		%orig(value, field);
	}
}

%end
