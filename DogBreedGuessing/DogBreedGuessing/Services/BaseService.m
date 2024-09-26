//
//  BaseService.m
//  DogBreedGuessing
//
//  Created by Leon on 2024/9/26.
//

#import "BaseService.h"

@implementation BaseService

- (void)sendRequestWithURL:(NSURL *)url
                completion:(void (^)(id jsonData, NSError *error))completionHandler {
    if (!url) {
        completionHandler(nil, [NSError errorWithDomain:DogAPIServiceErrorDomain code:DogAPIServiceErrorCodeInvalidURL userInfo:nil]);
        return;
    }
    
    if (self.task) {
        [self.task cancel];
        self.task = nil;
    }
    
    NSURLSession *session = [DogAPIServiceManager sharedManager].session;
    
    NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        dispatch_sync(dispatch_get_main_queue(), ^(){

            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;

            if (error == nil && httpResponse.statusCode >= 200 && httpResponse.statusCode <= 299) {
                // Parse data to JSON
                id obj = nil;
                NSError *parseError = nil;
                obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&parseError];
                if (obj && !parseError) {
                    NSDictionary *dict = obj;
                    if ([dict[@"status"] isEqualToString:@"success"]) {
                        completionHandler(dict[@"message"], nil);
                    } else {
                        completionHandler(nil, [NSError errorWithDomain:DogAPIServiceErrorDomain code:DogAPIServiceErrorCodeServerInternalError userInfo:nil]);
                    }
                } else {
                    // JSON parse error
                    completionHandler(nil, [NSError errorWithDomain:DogAPIServiceErrorDomain code:DogAPIServiceErrorCodeInvalidData userInfo:nil]);
                }
            } else {
                // Network error
                completionHandler(nil, [NSError errorWithDomain:DogAPIServiceErrorDomain code:DogAPIServiceErrorCodeNetworkFailure userInfo:nil]);
                return;
            }
        });
    }];
    
    [task resume];
    self.task = task;
}

@end
