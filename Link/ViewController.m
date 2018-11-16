//
//  ViewController.m
//  Link
//
//  Created by Surdot on 2018/4/17.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "ViewController.h"
#import "LKLittleSessionViewController.h"
#import "LCNetworking.h"


typedef void (^XMCompletioBlock)(NSDictionary *dic, NSURLResponse *response, NSError *error);
typedef void (^XMSuccessBlock)(NSDictionary *data);
typedef void (^XMFailureBlock)(NSError *error);


@interface ViewController ()
@property (nonatomic) NSInteger count;
@property (nonatomic, strong) UIScrollView *showView;
@property (nonatomic, strong) LKLittleSessionViewController *littleViewVC;
@property (nonatomic) BOOL isTrue;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _count = 1;
    _isTrue = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    _showView = [[UIScrollView alloc] initWithFrame:CGRectMake(60, 200, ScreenW - 80, 300)];
    [self.view addSubview:_showView];
    _showView.backgroundColor = [UIColor yellowColor];
    _showView.contentSize = CGSizeMake(ScreenW, 10000);
    
    _littleViewVC = [[LKLittleSessionViewController alloc] init];
    [_showView addSubview:_littleViewVC.view];
    
    
    NSLog(@"11111");
//        dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
//        dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
//    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
        //            NSDictionary *paramet = @{@"q" : content, @"from" : @"zh", @"to" : @"en", @"appid" : @"20170219000039382", @"salt" : @"1435660288", @"sign" : stringSign};
        //            [SCNetwork postWithURLString:@"https://fanyi-api.baidu.com/api/trans/vip/translate" parameters:paramet success:^(NSDictionary *dic) {
        //                dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //
        //                    dispatch_semaphore_signal(sema);
        //                });
        //
        //                NSLog(@"%@", dic);
        //                NSArray *transArr = dic[@"trans_result"];
        //                backInfo(transArr[0][@"dst"]);
        //
        //            } failure:^(NSError *error) {
        //                [SVProgressHUD showWithStatus:@"网络连接失败，检查网络"];
        //                [SVProgressHUD dismissWithDelay:0.7];
        //            }];
        
    
        
//    });
//    NSDictionary *paramet = @{@"userId" : @"50", @"selectId" : @"5"};
//    [SCNetwork postWithURLString:BDUrl_(@"user/getUser") parameters:paramet success:^(NSDictionary *dic) {
//        NSLog(@"2222");
//        NSLog(@"wwww%@", dic);
//        dispatch_semaphore_signal(semaphore);
//        NSLog(@"3333");
//    } failure:^(NSError *error) {
//
//    }];
//
//
//    //        dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//    //            NSLog(@"333");
//    //            dispatch_semaphore_signal(sema);
//    //        });
//    NSLog(@"4444");
//    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//
//    NSLog(@"5555");
    
    
//   dispatch_group_t group = dispatch_group_create();
//    dispatch_semaphore_t  sema = dispatch_semaphore_create(0);
//    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//
//            NSDictionary *paramet = @{@"userId" : @"50", @"selectId" : @"5"};
//            [SCNetwork postWithURLString:BDUrl_(@"user/getUser") parameters:paramet success:^(NSDictionary *dic) {
//                NSLog(@"2222");
//                NSLog(@"wwww%@", dic);
//                dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//
//                    dispatch_semaphore_signal(sema);
//                });
//                NSLog(@"3333");
//            } failure:^(NSError *error) {
//                dispatch_semaphore_signal(sema);
//
//            }];
//
//        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
//        NSLog(@"555");
//    });
////    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
////    dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
////        NSLog(@"666");
////    });
//
//    NSLog(@"777");
    
    NSLog(@"mainThread:%@", [NSThread mainThread]);

//    NSDictionary *paramet = @{@"userId" : @"50", @"selectId" : @"5"};
//    [SCNetwork postWithURLString:BDUrl_(@"user/getUser") parameters:paramet success:^(NSDictionary *dic) {
//        NSLog(@"2222");
//        NSLog(@"wwww%@", dic);
//        self.count = 0;
//        NSLog(@"3333");
//        NSLog(@"thread:%@", [NSThread currentThread]);
//
//    } failure:^(NSError *error) {
//    }];

//    do {
//        [SCNetwork postWithURLString:BDUrl_(@"user/getUser") parameters:paramet success:^(NSDictionary *dic) {
//            NSLog(@"2222");
//            NSLog(@"wwww%@", dic);
//            self.count = 0;
//            NSLog(@"3333");
//        } failure:^(NSError *error) {
//        }];
//    } while (self.count);
    
//    NSLog(@"555");
    
    
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:BDUrl_(@"user/getUser")] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    
    NSLog(@"1111%@", [NSThread currentThread]);
    NSDictionary *paramet = @{@"userId" : @"50", @"selectId" : @"5"};
    [LCNetworking PostWithURL:BDUrl_(@"user/getUser") Params:paramet success:^(id responseObject) {
        NSLog(@"POST_success____%@", responseObject);
        NSLog(@"2222%@", [NSThread currentThread]);
        self.count = 0;
        self.isTrue = YES;
    } failure:^(NSString *error) {
    }];
    
    while (YES) {
        if (_isTrue) {
            break;
        }
    }
    
//    while (1) {
//        if (self.count == 1) {
//            break;
//        }
//    }
    
    NSLog(@"3333%@", [NSThread currentThread]);
    
}
////POST请求 使用NSMutableURLRequest可以加入请求头
//+ (void)postWithUrlString:(NSString *)url parameters:(id)parameters success:(XMSuccessBlock)successBlock failure:(XMFailureBlock)failureBlock
//{
//    NSURL *nsurl = [NSURL URLWithString:url];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:nsurl];
//    //如果想要设置网络超时的时间的话，可以使用下面的方法：
//    //NSMutableURLRequest *mutableRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
//
//    //设置请求类型
//    request.HTTPMethod = @"POST";
//
//    //将需要的信息放入请求头 随便定义了几个
//    [request setValue:@"xxx" forHTTPHeaderField:@"Authorization"];//token
//    [request setValue:@"xxx" forHTTPHeaderField:@"Gis-Lng"];//坐标 lng
//    [request setValue:@"xxx" forHTTPHeaderField:@"Gis-Lat"];//坐标 lat
//    [request setValue:@"xxx" forHTTPHeaderField:@"Version"];//版本
//    NSLog(@"POST-Header:%@",request.allHTTPHeaderFields);
//
//    //把参数放到请求体内
//    NSString *postStr = [XMNetWorkHelper parseParams:parameters];
//    request.HTTPBody = [postStr dataUsingEncoding:NSUTF8StringEncoding];
//
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        if (error) { //请求失败
//            failureBlock(error);
//        } else {  //请求成功
//            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//            successBlock(dic);
//        }
//    }];
//    [dataTask resume];  //开始请求
//}



//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    self.view.hidden = YES;
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
