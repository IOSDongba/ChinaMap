//
//  ViewController.m
//  Testing
//
//  Created by apple on 17/1/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ViewController.h"
#import "ChinaMapWithName.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ChinaMapWithName *map = [[ChinaMapWithName alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:map];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
