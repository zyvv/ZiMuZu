//
//  SFNetworking.h
//  SFNetworkingExample
//
//  Created by 张洋威 on 16/3/16.
//  Copyright © 2016年 太阳花互动. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

typedef void (^CompletionBlock)(id data);
typedef void (^FailureBlock)(NSError *error);


@interface SFNetworking : NSObject

/**
 *  设置后台给定的KEY
 *
 *  @param key KEY
 */
+ (void)setKey:(NSString *)key;


/**
 *  GET请求
 *
 *  @param baseURL    host
 *  @param path       path
 *  @param parameters 参数
 *  @param completion 成功回调（不能为空）
 *  @param failure    失败回调
 */
+ (void)getWithBaseURL:(NSString *)baseURL path:(NSString *)path parameters: (NSDictionary *)parameters completion:(CompletionBlock)completion failure:(FailureBlock)failure;


/**
 *  POST
 *
 *  @param baseURL    host
 *  @param path       path
 *  @param parameters 参数
 *  @param completion 成功回调（不能为空）
 *  @param failure    失败回调
 */
+ (void)postWithBaseURL:(NSString *)baseURL path:(NSString *)path parameters: (NSDictionary *)parameters completion:(CompletionBlock)completion failure:(FailureBlock)failure;


/**
 *  GET请求(以前的方式)
 *
 *  @param baseURL    host
 *  @param path       path
 *  @param parameters 参数
 *  @param completion 成功回调（不能为空）
 *  @param failure    失败回调
 */
+ (void)old_getWithBaseURL:(NSString *)baseURL path:(NSString *)path parameters: (NSDictionary *)parameters completion:(CompletionBlock)completion failure:(FailureBlock)failure;


/**
 *  POST(以前的方式)
 *
 *  @param baseURL    host
 *  @param path       path
 *  @param parameters 参数
 *  @param completion 成功回调（不能为空）
 *  @param failure    失败回调
 */
+ (void)old_postWithBaseURL:(NSString *)baseURL path:(NSString *)path parameters: (NSDictionary *)parameters completion:(CompletionBlock)completion failure:(FailureBlock)failure;




@end