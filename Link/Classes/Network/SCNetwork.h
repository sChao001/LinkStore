//
//  SCNetwork.h
//  Link
//
//  Created by Surdot on 2018/4/18.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

typedef void (^SuccessBlock)(NSDictionary *dic);
typedef void (^FailureBlock)(NSError *error);

@interface SCNetwork : NSObject
@property (nonatomic, copy) SuccessBlock successBlock;
@property (nonatomic, copy) FailureBlock failureBlock;


/**
 *  发送get请求
 *
 *  @param urlString  请求的网址字符串
 *  @param parameters 请求的参数
 */
+ (void)getWithURLString:(NSString *)urlString
              parameters:(id)parameters
                 success:(SuccessBlock)successBlock
                 failure:(FailureBlock)failureBlock;

/**
 *  发送post请求
 *
 *  @param urlString  请求的网址字符串
 *  @param parameters 请求的参数
 */
+ (void)postWithURLString:(NSString *)urlString
               parameters:(id)parameters
                  success:(SuccessBlock)successBlock
                  failure:(FailureBlock)failureBlock;


+ (void)postWithURLString:(NSString *)urlString parameters:(id)parameters image:(UIImage *)image name:(NSString *)name fileName:(NSString *)fileName success:(SuccessBlock)successBlock
                  failure:(FailureBlock)failureBlock;
@end
