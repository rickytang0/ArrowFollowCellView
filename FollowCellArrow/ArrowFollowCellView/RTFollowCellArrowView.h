//
//  RTFollowCellArrowView.h
//  FollowCellArrow
//
//  Created by 唐 嘉宾 on 13-8-3.
//  Copyright (c) 2013年 唐 嘉宾. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RTFollowCellArrowView;

typedef enum {
    RTFollowArrowTypeOnLeft,
    RTFollowArrowTypeOnRight,
}RTFollowArrowType;

@protocol RTFollowCellArrowViewDelegate <NSObject>

@optional

-(CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath view:(RTFollowCellArrowView *)view;

-(void)willSelectRowAtIndexPath:(NSIndexPath *)indexPath view:(RTFollowCellArrowView *)view;

-(void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath view:(RTFollowCellArrowView *)view;

@end

@interface RTFollowCellArrowView : UIView<UITableViewDelegate,UITableViewDataSource>
{
    NSIndexPath *_lastIndexPath;
}

@property(nonatomic,strong)IBOutlet UITableView *tableView;
@property(nonatomic,strong)IBOutlet UIImageView *imageArrow;
@property(nonatomic,weak)IBOutlet id<UITableViewDataSource> dataSource;
@property(nonatomic,weak)IBOutlet id<RTFollowCellArrowViewDelegate> delegate;
@property(nonatomic,assign)RTFollowArrowType type;

-(void)setArrowToIndex:(NSIndexPath *)indexPath animation:(BOOL)isAnimation;
@end
