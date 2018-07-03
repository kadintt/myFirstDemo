//
//  ViewController.m
//  Rac_Demo
//
//  Created by 曲超 on 2018/6/6.
//  Copyright © 2018年 曲超. All rights reserved.
//

#import "ViewController.h"

#import <ReactiveObjc.h>
#import <ReactiveObjC/RACDisposable.h>
#import <ReactiveObjC/RACmetamacros.h>
@interface ViewController ()
@property (nonatomic, copy)   NSString *name;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    
    
//    [tableView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 2)] withRowAnimation:0];
    
    
    
    
//    @weakify(self);
//    RACObserve(<#TARGET#>, <#KEYPATH#>)
    //事件信号 藏信号
    RACCommand *command = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
           
            [subscriber sendNext:@"1234"];
            
            //完成信号
            
            [subscriber sendCompleted];
            
            return [RACDisposable disposableWithBlock:^{
                NSLog(@"消失了");
            }];
        
        }];
    }];
    //信号正在执行与否
//    [command.executing subscribeNext:^(NSNumber * _Nullable x) {
//
//        NSLog(@"executing: %@",x);
//    }];
    [[command.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
                NSLog(@"executing: %@",x);

    }];
    
    //command信号中的信号 发送出的
//    [command.executionSignals subscribeNext:^(id  _Nullable x) {
//        NSLog(@"executionSignals: %@",x);
//    }];
    
    // 获取最后一次的信号
    [[command.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
        NSLog(@"executionSignals switchToLatest: %@",x);

    }];
    
    //错误信号
    [command.errors subscribeNext:^(NSError * _Nullable x) {
        NSLog(@"errors: %@",x);
    }];
    //  重点：  执行命令
    [command execute:@"我们能赢"];
    
    // strong ---- weak  ------ dance
//    RACSignal *signal = [[RACSignal alloc]init];
    
    // 声明 unsafe_unretained  弱引用 相当于weak   当发生循环引用的时候 会变成野指针 保留发信号的功能 不能置nil
    
    //signal
    // main 预编译  ----> 加载类 到内存  ---> target：类型  ----> pro IRG method  List
    
    /*
     #define keypath(...) \
     metamacro_if_eq(1, metamacro_argcount(__VA_ARGS__))(keypath1(__VA_ARGS__))(keypath2(__VA_ARGS__))
     
     #define keypath1(PATH) \
     (((void)(NO && ((void)PATH, NO)), strchr(# PATH, '.') + 1))
     
     #define keypath2(OBJ, PATH) \
     (((void)(NO && ((void)OBJ.PATH, NO)), # PATH))
     
     */
    
//    signal rac
    
    
/*
#define weakify(...) \
rac_keywordify \ autoreleasepool {} // 增强编译能力 
metamacro_foreach_cxt(rac_weakify_,, __weak, __VA_ARGS__)
 
 \  两句代码的连接符
 
 */
 
   /*
    #define metamacro_at(N, ...) \
    metamacro_concat(metamacro_at, N)(__VA_ARGS__)
    
    
    */
    
  //  #define metamacro_concat_(A, B) A ## B  ====> AB(C中的表达)
    
    
  //  函数实现----> SEL：@Selector (viewDidLoad)
  //  方法调用底层 消息转发     objc_msgsend(id self, SEL _cmd , arg)
    
    
    
  //#define metamacro_head_(FIRST, ...) FIRST 找第一个参数
    
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
    
//    [RACObserve(self, name) subscribeNext:^(id  _Nullable x) {
//
//        NSLog(@"%@",x);
//    }];
//
//
//    self.name = @"lala";
    
    
//    RACSubject *subject = [RACSubject subject];
//    [subject subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",x);
//    }];
//
//
//    [subject sendNext:@"sda"];
//    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//
//
//        [subscriber sendNext:@"sd"];
//
//
//
//        return [RACDisposable disposableWithBlock:^{
//
//
//            NSLog(@"sdsad");
//        }];
//       }];
//
//
//    RACMulticastConnection *connection = [signal publish];
//
//
//        [connection.signal subscribeNext:^(id  _Nullable x) {
//
//                          NSLog(@"%@",x);
//
//                }];
//
//    [connection connect];

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
