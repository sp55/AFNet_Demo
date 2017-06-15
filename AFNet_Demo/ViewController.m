//
//  ViewController.m
//  AFNet_Demo
//
//  Created by admin on 2017/6/15.
//  Copyright © 2017年 AlezJi. All rights reserved.
//

#import "ViewController.h"
#import "AFHttpTool.h"

#define Home_Url @"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.song.userRecSongList&from=ios&bduss=25lQzlrTm5adDZ-V0lVa2t6SExNTnZIOWU3dk1wSTZNb3J0WnFkb0R-S0habGRWQVFBQUFBJCQAAAAAAAAAAAEAAADdUwg-uq52dna35wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIfZL1WH2S9VU&version=5.5.0"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [AFHttpTool requestWihtMethod:RequestMethodTypeGet url:Home_Url params:nil success:^(id response) {
//        NSLog(@"=====%@",response);
    } failure:^(NSError *err) {
        
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
