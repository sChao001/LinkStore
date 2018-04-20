//
//  SCNetwork.m
//  Link
//
//  Created by Surdot on 2018/4/18.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "SCNetwork.h"

@implementation SCNetwork
+ (void)getWithURLString:(NSString *)urlString parameters:(id)parameters success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    /**
     *  可以接受的类型
     */
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    /**
     *  请求队列的最大并发数
     */
    //    manager.operationQueue.maxConcurrentOperationCount = 5;
    /**
     *  请求超时的时间
     */
    manager.requestSerializer.timeoutInterval = outline;
    [manager GET:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            successBlock(dic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) {
            failureBlock(error);
            NSLog(@"URL= %@网络异常~\(≧▽≦)/~啦啦啦%@",urlString,error);
        }
    }];
}

+ (void)postWithURLString:(NSString *)urlString parameters:(id)parameters success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = outline;
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            successBlock(dic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) {
            failureBlock(error);
            NSLog(@"URL= %@ 网络异常~\(≧▽≦)/~啦啦啦%@",urlString,error);
        }
    }];
}

+ (void)postWithURLString:(NSString *)urlString parameters:(id)parameters image:(UIImage *)image name:(NSString *)name fileName:(NSString *)fileName success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = outline;
    [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSData *imageData = UIImageJPEGRepresentation(image, 0.1);
        [formData appendPartWithFileData:imageData name:name fileName:fileName mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //打印上传进度
        CGFloat progress = 100.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount;
        NSLog(@"%.2lf%%", progress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求链接成功，%@",responseObject);
        if (successBlock) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            successBlock(dic);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"上传失败，%@",error);
    }];
}
@end
