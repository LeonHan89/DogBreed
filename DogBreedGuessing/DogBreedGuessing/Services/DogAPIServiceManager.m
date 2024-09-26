//
//  DogAPIServiceManager.m
//  DogBreedGuessing
//
//  Created by Leon on 2024/9/26.
//

#import "DogAPIServiceManager.h"

@implementation DogAPIServiceManager

+ (DogAPIServiceManager *)sharedManager {
    static dispatch_once_t once = 0;
    static DogAPIServiceManager *shared;
    dispatch_once(&once, ^{
        shared = [[DogAPIServiceManager alloc] init];
        [shared configSessionManager];
    });
    return shared;
}

- (void)configSessionManager {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    self.session = [NSURLSession sessionWithConfiguration:configuration];
}

- (void)dealloc {
    [self.session invalidateAndCancel];
}



@end
