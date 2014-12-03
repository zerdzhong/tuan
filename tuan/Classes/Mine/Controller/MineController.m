//
//  MineController.m
//  tuan
//
//  Created by zerd on 14-11-28.
//  Copyright (c) 2014年 zerd. All rights reserved.
//

#import "MineController.h"

@implementation MineController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"我的";
    
    //添加rightBarItem
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"退出登录" style:UIBarButtonItemStylePlain target:nil action:nil];
}

@end
