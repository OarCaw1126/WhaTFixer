#import <Foundation/Foundation.h>


void changeUserAgent(NSMutableURLRequest *request) {
	[request setValue:@"Whatsapp/26.20.73 (iPhone; iOS 15.8.8; Scale/2.00)" forHTTPHeaderField:@"User-Agent"];
}

%hook NSMutableURLRequest

+ (instancetype)requestWithURL:(NSURL *)URL {
	// NSLog(@"WhaTFixer: Inside requestWithURL");
    NSMutableURLRequest *request = %orig(URL);
    changeUserAgent(request);
    return request;
}

+ (instancetype)requestWithURL:(NSURL *)URL cachePolicy:(NSURLRequestCachePolicy)cachePolicy timeoutInterval:(NSTimeInterval)timeoutInterval {
	// NSLog(@"WhaTFixer: Inside requestWithURL with the additional args");
    NSMutableURLRequest *request = %orig(URL, cachePolicy, timeoutInterval);
    changeUserAgent(request);
    return request;
}

- (instancetype)initWithURL:(NSURL *)URL {
	// NSLog(@"WhaTFixer: Inside initWithURL");
	NSMutableURLRequest *request = %orig(URL);
    changeUserAgent(request);
    return request;
}

- (instancetype)initWithURL:(NSURL *)URL cachePolicy:(NSURLRequestCachePolicy)cachePolicy timeoutInterval:(NSTimeInterval)timeoutInterval {
	// NSLog(@"WhaTFixer: Inside initWithURL with the additional args");
	NSMutableURLRequest *request = %orig(URL, cachePolicy, timeoutInterval);
    changeUserAgent(request);
    return request;
}

- (void)addValue:(NSString *)value forHTTPHeaderField:(NSString *)field{
	if ([[field lowercaseString] isEqualToString:@"user-agent"]) {
		// NSLog(@"WhaTFixer: We got 'em boys!");
	} else {
		%orig(value, field);
	}
}

%end
