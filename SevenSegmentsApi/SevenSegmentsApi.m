//
//  SevenSegmentsApi.m
//  SevenSegmentsApi
//
//  Created by Adam Saleh on 10/01/15.
//  Copyright (c) 2015 Adam Saleh. All rights reserved.
//

#import "SevenSegmentsApi.h"

#define target @"https://api.7segments.com" // Default target for our API


@implementation SevenSegmentsApi

- (id)initWithToken:(NSString *)token customerString:(NSString *)customer
{
    return [self initWithToken:token customerDict:@{@"registered":customer} apiUrl:target completionHandler:nil];
}

- (id)initWithToken:(NSString *) token customerDict:(NSDictionary *)customer
{
    return [self initWithToken:token customerDict:customer apiUrl:target completionHandler:nil];
}


- (id)initWithToken:(NSString *)token customerString:(NSString *)customer apiUrl: (NSString *) uriString {
    return [self initWithToken:token customerDict:@{@"registered":customer} apiUrl:uriString completionHandler:nil];
}

- (id)initWithToken:(NSString *)token customerString:(NSString *)customer completionHandler:(void (^)(NSURLResponse *response,NSData *data, NSError *connectionError)) completionHandler
{
	return [self initWithToken:token customerDict:@{@"registered":customer} apiUrl:target completionHandler:completionHandler];
}

- (id)initWithToken:(NSString *) token customerDict:(NSDictionary *)customer completionHandler:(void (^)(NSURLResponse *response,NSData *data, NSError *connectionError)) completionHandler
{
    return [self initWithToken:token customerDict:customer apiUrl:target completionHandler:completionHandler];
}


- (id)initWithToken:(NSString *)token customerString:(NSString *)customer apiUrl: (NSString *) uriString completionHandler:(void (^)(NSURLResponse *response,NSData *data, NSError *connectionError)) completionHandler
{
	return [self initWithToken:token customerDict:@{@"registered":customer} apiUrl:uriString completionHandler:completionHandler];
}

- (id)initWithToken:(NSString *)token customerDict:(NSDictionary *)customer apiUrl: (NSString *) uriString{
    return [self initWithToken:token customerDict:customer apiUrl:uriString completionHandler:nil];
}

- (id)initWithToken:(NSString *)token customerDict:(NSDictionary *)customer apiUrl: (NSString *) uriString completionHandler:(void (^)(NSURLResponse *response,NSData *data, NSError *connectionError)) completionHandler

{
	self = [super init];
	if (self)
	{
		self.token = token;
		self.customer = customer == nil ? @{} : customer;
        self.uriString = uriString;
        self.handler = completionHandler != nil ? completionHandler :
            ^(NSURLResponse *response, NSData *postData, NSError *error){
                if (error) {
                    NSLog(@"7Segments error:%@", error.localizedDescription);
                }
                NSLog(@"7Segments response: %@", response);
            };

	}
	return self;
}
- (void) post:(NSString*) path withJsonPayload:(NSDictionary*) json {
    NSError* error0;
    NSDictionary *postDict = json;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:postDict
                                                       options:NSJSONWritingPrettyPrinted error:&error0];
    
    NSString *realuri = [self.uriString stringByAppendingString:path];
    NSURL *url = [NSURL URLWithString:realuri];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:[NSString stringWithFormat:@"%d", (int) postData.length] forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:self.handler];
}

- (long) unixEpoch {
    NSDate *now = [NSDate date];
    NSTimeInterval nowEpochSeconds = [now timeIntervalSince1970];
    return nowEpochSeconds;
}

- (void) updateProperties:(NSDictionary*) properties {
    NSDictionary* payload;
    
    payload = @{
        @"ids": self.customer ,
        @"company_id":  self.token,
        @"properties": properties == nil ? @{} : properties
    };
    
    [self post:@"/crm/customers" withJsonPayload:payload];
}

- (void) identifyCustomerFromDictionary: (NSDictionary*) customer  withProperties: (NSDictionary*) properties {
    self.customer = customer;
    
    [self updateProperties: properties];
}

- (void) identifyCustomerFromString: (NSString*) customer  withProperties: (NSDictionary*) properties {
    [self identifyCustomerFromDictionary: @{@"registered":customer} withProperties:properties];
}

- (void) track: (NSString*) type withProperties: (NSDictionary*) properties withTime: (long) time {
    NSDictionary* payload;
    
    payload = @{
        @"customer_ids": self.customer,
        @"company_id":  self.token,
        @"properties": properties == nil ? @{} : properties,
        @"type":  type,
        @"age": [NSNumber numberWithLong: [self unixEpoch] - time]
    };
   
    [self post:@"/crm/events" withJsonPayload:payload];
}

- (void) track: (NSString*) type withTime: (long) time {
    [self track: type withProperties:nil withTime:time];

}

- (void) track: (NSString*) type withProperties: (NSDictionary*) properties {
    [self track: type withProperties:properties withTime:[self unixEpoch]];
}

- (void) track: (NSString*) type {
    [self track: type withProperties:nil withTime:[self unixEpoch]];
}


@end
