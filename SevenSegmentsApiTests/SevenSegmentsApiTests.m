//
//  SevenSegmentsApiTests.m
//  SevenSegmentsApiTests
//
//  Created by Adam Saleh on 10/01/15.
//  Copyright (c) 2015 Adam Saleh. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SevenSegmentsApi.h"

#define timeup 5.0 // Default timout to wait for
#define company_token @"{COMPANY_TOKEN}" // Default timout to wait for


@interface SevenSegmentsApiTests : XCTestCase

@end

@implementation SevenSegmentsApiTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}




- (void)testIdentifyDifferentUrl
{
    XCTestExpectation *request_finished_expectation = [self expectationWithDescription:@"RequestFinished"];
    SevenSegmentsApi *api = [[SevenSegmentsApi alloc]
                             initWithToken: company_token
                             customerDict: @{@"registered": @"customer010"}
                             apiUrl: @"https://api.7segments.com"
                             completionHandler:^(NSURLResponse *response, NSData *postData, NSError *error){
                                 if (error) {
                                     NSLog(@"7Segments error:%@", error.localizedDescription);
                                 }
                               //  XCTAssert(error==nil);
                                 NSLog(@"7Segments response: %@", response);
                                 [request_finished_expectation  fulfill];
                             }];
    
    
    [api identifyCustomerFromDictionary:  @{@"registered": @"customer010"} withProperties:@{@"email": @"asdfjlo@asdfjlo.com"}];
    
    [self waitForExpectationsWithTimeout:timeup handler:^(NSError *error) {
        NSLog(@"Test errored %@", error );
    }];
    
}

- (void)testIdentifyStringDifferentUrl
{
    XCTestExpectation *request_finished_expectation = [self expectationWithDescription:@"RequestFinished"];
    SevenSegmentsApi *api = [[SevenSegmentsApi alloc]
                             initWithToken: company_token
                             customerString: @"customer010"
                             apiUrl: @"https://api.7segments.com"
                             completionHandler:^(NSURLResponse *response, NSData *postData, NSError *error){
                                 if (error) {
                                     NSLog(@"7Segments error:%@", error.localizedDescription);
                                 }
                                 //  XCTAssert(error==nil);
                                 NSLog(@"7Segments response: %@", response);
                                 [request_finished_expectation  fulfill];
                             }];
    
    
    [api identifyCustomerFromDictionary:  @{@"registered": @"customer010"} withProperties:@{@"email": @"asdfjlo@asdfjlo.com"}];
    
    [self waitForExpectationsWithTimeout:timeup handler:^(NSError *error) {
        NSLog(@"Test errored %@", error );
    }];
    
}

- (void)testIdentifyDictionary
{
    XCTestExpectation *request_finished_expectation = [self expectationWithDescription:@"RequestFinished"];
    SevenSegmentsApi *api = [[SevenSegmentsApi alloc]
                             initWithToken: company_token
                             customerDict: @{@"registered": @"customer010"}
                             completionHandler:^(NSURLResponse *response, NSData *postData, NSError *error){
                                 if (error) {
                                     NSLog(@"7Segments error:%@", error.localizedDescription);
                                 }
                                 NSLog(@"7Segments response: %@", response);
                                 [request_finished_expectation  fulfill];
                             }];
    
    
    [api identifyCustomerFromDictionary:  @{@"registered": @"customer010"} withProperties:@{@"email": @"asdfjlo@asdfjlo.com"}];
   
    [self waitForExpectationsWithTimeout:1 handler:^(NSError *error) {
        NSLog(@"Test errored %@", error );
    }];
    
}

- (void)testIdentifyString
{
    XCTestExpectation *request_finished_expectation = [self expectationWithDescription:@"RequestFinished"];
    
    SevenSegmentsApi *api = [[SevenSegmentsApi alloc]
                             initWithToken: company_token
                             customerString: @"customer010"
                             completionHandler:^(NSURLResponse *response, NSData *postData, NSError *error){
                                 if (error) {
                                     NSLog(@"7Segments error:%@", error.localizedDescription);
                                 }
                                 NSLog(@"7Segments response: %@", response);
                                 [request_finished_expectation  fulfill];
                             }];
    
    
    [api identifyCustomerFromString:@"customer010" withProperties:@{@"email": @"asdfjlo@asdfjlo.com"}];
    
    [self waitForExpectationsWithTimeout:1 handler:^(NSError *error) {
        NSLog(@"Test errored %@", error );
    }];
}


- (void)testTrack
{
    XCTestExpectation *request_finished_expectation = [self expectationWithDescription:@"RequestFinished"];
    
    SevenSegmentsApi *api = [[SevenSegmentsApi alloc]
                             initWithToken: company_token
                             customerDict: @{@"registered": @"customer010"}
                             completionHandler:^(NSURLResponse *response, NSData *postData, NSError *error){
                                 if (error) {
                                     NSLog(@"7Segments error:%@", error.localizedDescription);
                                 }
                                 NSLog(@"7Segments response: %@", response);
                                 [request_finished_expectation  fulfill];
                             }];
    
    
    [api track: @"login"];
    
    [self waitForExpectationsWithTimeout:1 handler:^(NSError *error) {
        NSLog(@"Test errored %@", error );
    }];
}

- (void)testTrackProperty
{
    XCTestExpectation *request_finished_expectation = [self expectationWithDescription:@"RequestFinished"];
    
    SevenSegmentsApi *api = [[SevenSegmentsApi alloc]
                             initWithToken: company_token
                             customerDict: @{@"registered": @"customer010"}
                             completionHandler:^(NSURLResponse *response, NSData *postData, NSError *error){
                                 if (error) {
                                     NSLog(@"7Segments error:%@", error.localizedDescription);
                                 }
                                 NSLog(@"7Segments response: %@", response);
                                 [request_finished_expectation  fulfill];
                             }];
    
    
    [api track: @"login" withProperties: @{@"test":@"test"}];
    
    [self waitForExpectationsWithTimeout:1 handler:^(NSError *error) {
        NSLog(@"Test errored %@", error );
    }];
}

- (void)testTrackPropertyTime
{
    XCTestExpectation *request_finished_expectation = [self expectationWithDescription:@"RequestFinished"];
    
    SevenSegmentsApi *api = [[SevenSegmentsApi alloc]
                             initWithToken: company_token
                             customerDict: @{@"registered": @"customer010"}
                             completionHandler:^(NSURLResponse *response, NSData *postData, NSError *error){
                                 if (error) {
                                     NSLog(@"7Segments error:%@", error.localizedDescription);
                                 }
                                 NSLog(@"7Segments response: %@", response);
                                 [request_finished_expectation  fulfill];
                             }];
    
    NSDate *now = [NSDate date];
    NSTimeInterval nowEpochSeconds = [now timeIntervalSince1970];
    long epoch = nowEpochSeconds;
    
    [api track: @"login" withProperties: @{@"test":@"test"} withTime: epoch];
    
    [self waitForExpectationsWithTimeout:1 handler:^(NSError *error) {
        NSLog(@"Test errored %@", error );
    }];
}

- (void)testTrackTime
{
    XCTestExpectation *request_finished_expectation = [self expectationWithDescription:@"RequestFinished"];
    
    SevenSegmentsApi *api = [[SevenSegmentsApi alloc]
                             initWithToken: company_token
                             customerDict: @{@"registered": @"customer010"}
                             completionHandler:^(NSURLResponse *response, NSData *postData, NSError *error){
                                 if (error) {
                                     NSLog(@"7Segments error:%@", error.localizedDescription);
                                 }
                                 NSLog(@"7Segments response: %@", response);
                                 [request_finished_expectation  fulfill];
                             }];
    
    NSDate *now = [NSDate date];
    NSTimeInterval nowEpochSeconds = [now timeIntervalSince1970];
    long epoch = nowEpochSeconds;
    
    [api track: @"login" withTime: epoch];
    
    [self waitForExpectationsWithTimeout:1 handler:^(NSError *error) {
        NSLog(@"Test errored %@", error );
    }];
}


@end
