//
//  zoomInOutNavViewController.m
//  zoomInOutNav
//
//  Created by Zhang Peng on 13-11-4.
//  Copyright (c) 2013年 Zhang Peng. All rights reserved.
//

#import "zoomInOutNavViewController.h"

@interface zoomInOutNavViewController ()

@end

@implementation zoomInOutNavViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    testView = [[zoomInOutNavView alloc]initWithFrame:CGRectMake(0, 0, 300, 400)];
    [self.view addSubview:testView];
    testView.backgroundColor = [UIColor blueColor];
    
    for (int i=0; i<9; i++) {
        int row = i/3;
        int col = i%3;
        
        UIButton * tmpBtn = [[UIButton alloc]initWithFrame:CGRectMake(row *50, col * 50, 40, 40)];
        tmpBtn.backgroundColor =[UIColor greenColor];
        [testView addSubview:tmpBtn];
        
        [tmpBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void) onClick:(UIButton*)btn
{
    tmpView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 400)];
    tmpView.backgroundColor = [UIColor yellowColor];
    
    UIButton * backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
    backBtn.backgroundColor = [UIColor purpleColor];
    [tmpView addSubview:backBtn];
    [backBtn addTarget:self action:@selector(onBack) forControlEvents:UIControlEventTouchUpInside];
    
    [testView addSubview:tmpView fromRect:btn.frame byScale:3];
}

- (void)onBack
{
    [tmpView removeFromSuperview];
    tmpView = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
