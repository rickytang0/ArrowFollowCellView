//
//  RTViewController.m
//  FollowCellArrow
//
//  Created by 唐 嘉宾 on 13-8-3.
//  Copyright (c) 2013年 唐 嘉宾. All rights reserved.
//

#import "RTViewController.h"
#import "RTFollowCellArrowView.h"
#import "BaseFollowArrowCell.h"
#import "UITableViewCell+Create.h"

@interface RTViewController ()

@end

@implementation RTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    RTFollowCellArrowView *followView = (RTFollowCellArrowView *)self.view;
    followView.delegate = self;
    followView.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath view:(RTFollowCellArrowView *)view
{
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseFollowArrowCell *cell = [BaseFollowArrowCell cellForTableView:tableView fromNib:[BaseFollowArrowCell nib] andOwner:nil];
    
    return cell;
}

@end
