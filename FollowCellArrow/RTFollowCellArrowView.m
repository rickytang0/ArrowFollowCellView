//
//  RTFollowCellArrowView.m
//  FollowCellArrow
//
//  Created by 唐 嘉宾 on 13-8-3.
//  Copyright (c) 2013年 唐 嘉宾. All rights reserved.
//

#import "RTFollowCellArrowView.h"
#import "BaseFollowArrowCell.h"

@implementation RTFollowCellArrowView
@synthesize tableView,imageArrow;
@synthesize dataSource,delegate,type=_type;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        //[self _init];
    }
    return self;
}

-(void)_init
{
    self.tableView.delegate = self;
    self.imageArrow.center = CGPointMake(CGRectGetWidth(self.tableView.frame)-CGRectGetWidth(self.imageArrow.frame)/2, CGRectGetHeight(self.tableView.frame));
    self.imageArrow.hidden = YES;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [self _init];
}


-(void)setDataSource:(id<UITableViewDataSource>)value
{
    self.tableView.dataSource = value;
}

-(void)setType:(RTFollowArrowType)value
{
    _type = value;
    //[self setNeedsDisplay];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.delegate heightForRowAtIndexPath:indexPath view:self];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    //最后点击的cell
    UITableViewCell *lastCell = [self.tableView cellForRowAtIndexPath:_lastIndexPath];
    CGRect lastRect = [self.tableView rectForRowAtIndexPath:_lastIndexPath];
    CGRect newLastRect = [self convertRect:lastRect fromView:self.tableView];
    
    BaseFollowArrowCell *lastItem = (BaseFollowArrowCell *)lastCell;
    
    //当前要求移动到的cell
    UITableViewCell *currentCell = [self.tableView cellForRowAtIndexPath:indexPath];
    [currentCell setSelected:NO animated:YES];
    
    CGRect rect = [self.tableView rectForRowAtIndexPath:indexPath];
    CGRect newRect = [self convertRect:rect fromView:self.tableView];
    
    BaseFollowArrowCell *currentItem = (BaseFollowArrowCell *)currentCell;

    
    //重新计算imageArrow当前位置
    self.imageArrow.center = CGPointMake(CGRectGetMidX(self.imageArrow.frame), CGRectGetMidY(newLastRect));
    
    
    if ([self.delegate respondsToSelector:@selector(willSelectRowAtIndexPath:view:)]) {
        [self.delegate willSelectRowAtIndexPath:indexPath view:self];
    }
    
    self.imageArrow.hidden = NO;
    lastItem.imageArrow.hidden = YES;
    [UIView animateWithDuration:0.3f animations:^(void){
        self.imageArrow.center = CGPointMake(CGRectGetMidX(self.imageArrow.frame), CGRectGetMidY(newRect));
    } completion:^(BOOL finished){
        currentItem.imageArrow.hidden = NO;

        _lastIndexPath = [indexPath copy];
        self.imageArrow.hidden = YES;
        
        if ([self.delegate respondsToSelector:@selector(didSelectRowAtIndexPath:view:)]) {
            [self.delegate didSelectRowAtIndexPath:indexPath view:self];
        }
    }];
}


@end
