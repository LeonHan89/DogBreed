//
//  BaseService.h
//  DogBreedGuessing
//
//  Created by Leon on 2024/9/26.
//

#import <Foundation/Foundation.h>
#import "DogAPIServiceManager.h"

@interface BaseService : NSObject

@property (nonatomic, strong) NSURLSessionTask *task;

- (void)sendRequestWithURL:(NSURL *)url
                completion:(void (^)(id jsonData, NSError *error))completionHandler;

@end
