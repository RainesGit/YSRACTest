//
//  ViewController.m
//  ReactivecocoaDemo1
//
//  Created by Rainse on 2017/7/19.
//  Copyright © 2017年 Rainse. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(100, 100, 200, 200);
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    
    UIButton *btn = [UIButton new];
    btn.frame = CGRectMake(10, 10, 100, 100);
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor yellowColor];
    [view addSubview:btn];
    
    [[self rac_signalForSelector:@selector(btnClick:)] subscribeNext:^(id x) {
        NSLog(@"点击红色按钮");
    }];
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"我点击了黄色按钮");
    }];
    /**我就是爱音乐别叫我停下来*/
    // 1.创建信号 RACSignal *siganl = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) { // block调用时刻：每当有订阅者订阅信号，就会调用block。 // 2.发送信号 [subscriber sendNext:@1]; // 如果不在发送数据，最好发送信号完成，内部会自动调用[RACDisposable disposable]取消订阅信号。 [subscriber sendCompleted]; return [RACDisposable disposableWithBlock:^{ // block调用时刻：当信号发送完成或者发送错误，就会自动执行这个block,取消订阅信号。 // 执行完Block后，当前信号就不在被订阅了。 NSLog(@"信号被销毁"); }]; }]; // 3.订阅信号,才会激活信号. [siganl subscribeNext:^(id x) { // block调用时刻：每当有信号发出数据，就会调用block. NSLog(@"接收到数据:%@",x); }];
    
    RACSignal *siganl = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        // block调用时刻：每当有订阅者订阅信号，就会调用block。
        
        // 2.发送信号
//        [subscriber sendNext:@1];
//
//        [subscriber sendCompleted];
//        
//         return [RACDisposable disposableWithBlock:^{
//              NSLog(@"信号被销毁");
//                }];
        return nil;

         }];
    
        [siganl subscribeNext:^(id x) {
            // block调用时刻：每当有信号发出数据，就会调用block.
            NSLog(@"接收到数据:%@",x);
            NSLog(@"接收s");
        }];
    
    
    
    RACSignal *signal1 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"发送请求");
        return nil;
    }];
     RACMulticastConnection *connect = [signal1 publish];
    
    [connect.signal subscribeNext:^(id x) {
        
    }];
    [connect.signal subscribeNext:^(id x) {
        
    }];
    
    // 4.连接,激活信号
    [connect connect];
//    // 2.订阅信号
//    [signal1 subscribeNext:^(id x) { NSLog(@"接收数据"); }];
//    // 2.订阅信号
//    [signal1 subscribeNext:^(id x) { NSLog(@"接收数据"); }];
    
  
    
}

- (void)btnClick:(id)sender
{


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
