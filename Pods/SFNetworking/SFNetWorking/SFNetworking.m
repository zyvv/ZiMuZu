//
//  SFNetworking.m
//  SFNetworkingExample
//
//  Created by 张洋威 on 16/3/16.
//  Copyright © 2016年 太阳花互动. All rights reserved.
//

#import "SFNetworking.h"
#import <UIKit/UIKit.h>

static NSString const *_key = @""; // 后台给定的key

@implementation SFNetworking
+ (void)getWithBaseURL:(NSString *)baseURL path:(NSString *)path parameters: (NSDictionary *)parameters completion:(CompletionBlock)completion failure:(FailureBlock)failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", baseURL, path];
    
    NSMutableDictionary *parametersWithKey = nil;
    if (parameters) {
        parametersWithKey = [NSMutableDictionary dictionaryWithDictionary:parameters];
    } else {
        parametersWithKey = [NSMutableDictionary dictionary];
    }
    [parametersWithKey setObject:_key forKey:@"key"];
    
    NSURLSessionDataTask *task = [manager GET:url parameters:parametersWithKey progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([[responseObject objectForKey:@"http_status"] isEqual:@1] && [responseObject objectForKey:@"data"]) {
            // 好数据
            completion([responseObject objectForKey:@"data"]);
        } else {
            if ([[responseObject objectForKey:@"http_status"] isEqual:@0]) {
                NSError *error = [[NSError alloc] initWithDomain:[responseObject objectForKey:@"message"] code:2000 userInfo:nil];
                if (failure) {
                    failure(error);
                }
                
            }
            NSError *error = [[NSError alloc] initWithDomain:@"后台数据格式错误" code:2000 userInfo:nil];
            if (failure) {
                failure(error);
            }
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        });
        
    }];
    
    [task resume];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    });
    
}

+ (void)postWithBaseURL:(NSString *)baseURL path:(NSString *)path parameters: (NSDictionary *)parameters completion:(CompletionBlock)completion failure:(FailureBlock)failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", baseURL, path];
    
    NSMutableDictionary *parametersWithKey = nil;
    if (parameters) {
        parametersWithKey = [NSMutableDictionary dictionaryWithDictionary:parameters];
    } else {
        parametersWithKey = [NSMutableDictionary dictionary];
    }
    [parametersWithKey setObject:_key forKey:@"key"];
    
    BOOL isFile = NO;
    //判断请求参数是否有文件数据
    for (NSString *key in parameters) {
        id value = parameters[key];
        if ([value isKindOfClass:[NSData class]]) {
            isFile = YES;
            break;
        }
    }
    NSURLSessionDataTask *task = nil;
    if (isFile) {
        task = [manager POST:url parameters:parametersWithKey constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            for (NSString *key in parameters) {
                id value = parameters[key];
                if ([value isKindOfClass:[NSData class]]) {
                    [formData appendPartWithFileData:value name:key fileName:key mimeType:@"image/jpeg"];
                }
            }
        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([[responseObject objectForKey:@"http_status"] isEqual:@1] && [responseObject objectForKey:@"data"]) {
                // 好数据
                completion([responseObject objectForKey:@"data"]);
            } else {
                NSError *error = [[NSError alloc] initWithDomain:@"后台数据格式错误" code:2000 userInfo:nil];
                
                if (failure) {
                    failure(error);
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            });
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            });
        }];
    } else {
        task = [manager POST:url parameters:parametersWithKey constructingBodyWithBlock:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([[responseObject objectForKey:@"http_status"] isEqual:@1] && [responseObject objectForKey:@"data"]) {
                // 好数据
                completion([responseObject objectForKey:@"data"]);
            } else {
                NSError *error = [[NSError alloc] initWithDomain:@"后台数据格式错误" code:2000 userInfo:nil];
                if (failure) {
                    failure(error);
                }
                
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            });
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            });
        }];
    }
    
    [task resume];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    });
    
}



+ (void)old_getWithBaseURL:(NSString *)baseURL path:(NSString *)path parameters: (NSDictionary *)parameters completion:(CompletionBlock)completion failure:(FailureBlock)failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", baseURL, path];
    
    NSMutableDictionary *parametersWithKey = nil;
    if (parameters) {
        parametersWithKey = [NSMutableDictionary dictionaryWithDictionary:parameters];
    } else {
        parametersWithKey = [NSMutableDictionary dictionary];
    }
    [parametersWithKey setObject:_key forKey:@"key"];
    
    NSURLSessionDataTask *task = [manager GET:url parameters:parametersWithKey progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        completion(responseObject);

        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        });
        
    }];
    
    [task resume];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    });
    
}

+ (void)old_postWithBaseURL:(NSString *)baseURL path:(NSString *)path parameters: (NSDictionary *)parameters completion:(CompletionBlock)completion failure:(FailureBlock)failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", baseURL, path];
    
    NSMutableDictionary *parametersWithKey = nil;
    if (parameters) {
        parametersWithKey = [NSMutableDictionary dictionaryWithDictionary:parameters];
    } else {
        parametersWithKey = [NSMutableDictionary dictionary];
    }
    [parametersWithKey setObject:_key forKey:@"key"];
    
    BOOL isFile = NO;
    //判断请求参数是否有文件数据
    for (NSString *key in parameters) {
        id value = parameters[key];
        if ([value isKindOfClass:[NSData class]]) {
            isFile = YES;
            break;
        }
    }
    NSURLSessionDataTask *task = nil;
    if (isFile) {
        task = [manager POST:url parameters:parametersWithKey constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            for (NSString *key in parameters) {
                id value = parameters[key];
                if ([value isKindOfClass:[NSData class]]) {
                    [formData appendPartWithFileData:value name:key fileName:key mimeType:@"image/jpeg"];
                }
            }
        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

            completion(responseObject);

            dispatch_async(dispatch_get_main_queue(), ^{
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            });
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            });
        }];
    } else {
        task = [manager POST:url parameters:parametersWithKey constructingBodyWithBlock:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

            completion(responseObject);
   
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            });
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            });
        }];
    }
    
    [task resume];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    });
    
}

+ (void)setKey:(NSString *)key {
    _key = key;
}
@end
