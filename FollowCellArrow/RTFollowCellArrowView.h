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

@property(nonatomic,weak)IBOutlet UITableView *tableView;
@property(nonatomic,weak)IBOutlet UIImageView *imageArrow;
@property(nonatomic,strong)IBOutlet id<UITableViewDataSource> dataSource;
@property(nonatomic,strong)IBOutlet id<RTFollowCellArrowViewDelegate> delegate;
@property(nonatomic,assign)RTFollowArrowType type;

@end
