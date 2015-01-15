//
//  SevenSegmentsApi.h
//  SevenSegmentsApi
//
//  Created by Adam Saleh on 10/01/15.
//  Copyright (c) 2015 Adam Saleh. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SevenSegmentsApi
- (void) updateProperties:(NSDictionary*) properties;

- (void) identifyCustomerFromDictionary: (NSDictionary*) customer  withProperties: (NSDictionary*) properties;

- (void) identifyCustomerFromString: (NSString*) customer  withProperties: (NSDictionary*) properties;

- (void) track: (NSString*) type withProperties: (NSDictionary*) properties withTime: (long) time;

- (void) track: (NSString*) type withTime: (long) time;

- (void) track: (NSString*) type withProperties: (NSDictionary*) properties;

- (void) track: (NSString*) type;



@end

@interface SevenSegmentsApi : NSObject<SevenSegmentsApi>
- (id)initWithToken:(NSString *)token customerString:(NSString *)customer completionHandler:(void (^)(NSURLResponse *response,NSData *data, NSError *connectionError)) completionHandler;

- (id)initWithToken:(NSString *) token customerDict:(NSDictionary *)customer completionHandler:(void (^)(NSURLResponse *response,NSData *data, NSError *connectionError)) completionHandler;
- (id)initWithToken:(NSString *)token customerString:(NSString *)customer apiUrl: (NSString *) uriString completionHandler:(void (^)(NSURLResponse *response,NSData *data, NSError *connectionError)) completionHandler;
- (id)initWithToken:(NSString *)token customerDict:(NSDictionary *)customer apiUrl: (NSString *) uriString completionHandler:(void (^)(NSURLResponse *response,NSData *data, NSError *connectionError)) completionHandler;


@property(strong, nonatomic, readwrite) NSString* token; // holding token
@property(strong, nonatomic, readwrite) NSDictionary* customer; // holding customer
@property(strong, nonatomic, readwrite) NSString* uriString; // holding uriString
@property(nonatomic, copy) void (^handler)(NSURLResponse *response,NSData *data,NSError *connectionError);

@end
