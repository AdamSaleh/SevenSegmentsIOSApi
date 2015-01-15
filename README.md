# SevenSegmentsApi for iOS

Implementation of json tracking api for [7segments](http://7segments.com). 

## Installation
 
It is a standard xcode project.

After you clone/checkout the project, you should be able to link it to your project from xcode. 

We are working on a cocoa-pod package.


## Usage

### Basic Interface

To start tracking, you need to know the uri of your 7segments api instance, usualy ```https://api.7segments.com/```, your ```company_token``` and generate a unique ```customer_id``` for the customer you are about to track. The unique ```customer_id``` can either be string, or an ```NSDictionary``` representing the ```customer_ids``` as referenced in [the api guide](https://docs.7segments.com/technical-guide/integration-rest-client-api/#Detailed_key_descriptions).
Setting ```customerString: "123-asdf"``` is equivalent to ```customerDict: @{@"registered":@"123-adf"}}```


```
 SevenSegmentsApi *api = [[SevenSegmentsApi alloc]
                             initWithToken: company_token
                             customerDict: @{@"registered": @"customer010"}
                             apiUrl: @"https://api.7segments.com"
                             completionHandler:^(NSURLResponse *response, NSData *postData, NSError *error){
                                 if (error) {
                                     NSLog(@"7Segments error:%@", error.localizedDescription);
                                 }
                                 NSLog(@"7Segments response: %@", response);
                             }];
```

If this is the beginning of tracking of a new user, you need to first ```Identify``` him against the server.
Be warned, that this command is not thread-safe, so precautins should be taken, that identification sucessfully finished,
before issuing different commands. 

```
[api identifyCustomerFromDictionary:  @{@"registered": @"customer010"} withProperties:@{@"email": @"asdfjlo@asdfjlo.com"}];
```

For serialization we utilize the default NSJSONSerialization. 


If update of the customer's properties is required.

```
[api updateProperties:  @{@"email": @"asdfjlo@asdfjlo.com"}];
```

You track various events by utilizing the Track function.
It assumes you want to track the customer you identified by ```Identify```.
The only required field is a string describing the type of your event.
By default the time of the event is tracked as the epoch time,
and diffed against the server time of 7segments before sending.

```
    [api track: @"login"];
```

You probably want to supply properties:

```
    [api track: @"login" withProperties: @{@"test":@"test"}];
```
