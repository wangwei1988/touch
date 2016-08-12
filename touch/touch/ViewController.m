//
//  ViewController.m
//  touch
//
//  Created by  王伟 on 16/8/10.
//  Copyright © 2016年  王伟. All rights reserved.
//

#import "ViewController.h"
#import "myView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    myView *myview = [[myView alloc]initWithFrame:self.view.bounds];
    myview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:myview];
}



@end
