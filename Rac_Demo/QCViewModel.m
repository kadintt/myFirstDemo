//
//  QCViewModel.m
//  Rac_Demo
//
//  Created by 曲超 on 2018/6/7.
//  Copyright © 2018年 曲超. All rights reserved.
//

#import "QCViewModel.h"

@implementation QCViewModel

- (instancetype)init {
    if (self = [super init]) {
        //
        RAC(self,imageUrl) = [[[RACObserve(self, pwd) skip:1] map:^id _Nullable(id  _Nullable value) {
            return [NSString stringWithFormat:@"www.%@",value];
            
        }] distinctUntilChanged]; // 避免重复发送相同信号
        
    }
    return self;
}

@end
