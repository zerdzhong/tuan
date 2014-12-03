//
//  MoreController.m
//  tuan
//
//  Created by zerd on 14-11-29.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "MoreController.h"

@implementation MoreController

-(void)viewDidLoad{
    self.title = @"更多";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(onDone)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"意见反馈" style:UIBarButtonItemStyleDone target:self action:nil];
}

- (void)onDone{
    [self dismissViewControllerAnimated:YES completion:^{
        _moreItem.enabled = YES;
    }];
}

@end
