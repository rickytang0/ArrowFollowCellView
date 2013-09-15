//
//  RTFollowCellArrowView.m
//  FollowCellArrow
//
//  Created by 唐 嘉宾 on 13-8-3.
//  Copyright (c) 2013年 唐 嘉宾. All rights reserved.
//

#import "RTFollowCellArrowView.h"
#import "BaseFollowArrowCell.h"

@interface RTFollowCellArrowView ()
@property(nonatomic,strong)UITableViewCell *lastCell;
@end

@implementation RTFollowCellArrowView
@synthesize tableView,imageArrow;
@synthesize dataSource,delegate,type=_type;
@synthesize lastCell;

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
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.decelerationRate = 0.2f;
    self.imageArrow.center = CGPointMake(CGRectGetWidth(self.tableView.frame)-CGRectGetWidth(self.imageArrow.frame)/2+1, CGRectGetHeight(self.tableView.frame));
    self.imageArrow.hidden = YES;
    self.imageArrow.frame = CGRectMake(CGRectGetMinX(self.imageArrow.frame), CGRectGetMinY(self.imageArrow.frame), CGRectGetWidth(self.imageArrow.frame), 12);
    //RTLog(@"imageArrow rect %@",NSStringFromCGRect(self.imageArrow.frame));
    //RTLog(@"table rect %@",NSStringFromCGRect(self.tableView.frame));
    if ([self.dataSource tableView:self.tableView numberOfRowsInSection:0] < 1) {
        return;
    }
    [self setArrowToIndex:[NSIndexPath indexPathForRow:0 inSection:0] animation:YES];
}


-(void)dealloc
{
    self.tableView = nil;
    self.imageArrow = nil;
    self.dataSource = nil;
    self.delegate = nil;
    self.lastCell = nil;
}


-(void)setArrowToIndex:(NSIndexPath *)indexPath animation:(BOOL)isAnimation
{
    if (indexPath == nil) {
        return;
    }
    
    //最后点击的cell
    UITableViewCell *_lastCell = [self.tableView cellForRowAtIndexPath:_lastIndexPath];
    CGRect lastRect = [self.tableView rectForRowAtIndexPath:_lastIndexPath];
    CGRect newLastRect = [self convertRect:lastRect fromView:self.tableView];
    
    BaseFollowArrowCell *lastItem = (BaseFollowArrowCell *)_lastCell;
    [lastItem hightLightWith:NO];
    
    //当前要求移动到的cell
    UITableViewCell *currentCell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    CGRect currentRect = [self.tableView rectForRowAtIndexPath:indexPath];
    CGRect newCurrentRect = [self convertRect:currentRect fromView:self.tableView];
    
    BaseFollowArrowCell *currentItem = (BaseFollowArrowCell *)currentCell;
    
    
    //重新计算imageArrow当前位置
    self.imageArrow.center = CGPointMake(CGRectGetMidX(self.imageArrow.frame), CGRectGetMidY(newLastRect));
    
    
    if ([self.delegate respondsToSelector:@selector(willSelectRowAtIndexPath:view:)]) {
        [self.delegate willSelectRowAtIndexPath:indexPath view:self];
    }
    
    if (isAnimation) {
        self.imageArrow.hidden = NO;
        lastItem.imageArrow.hidden = YES;
        [UIView animateWithDuration:0.3f animations:^(void){
            self.imageArrow.center = CGPointMake(CGRectGetMidX(self.imageArrow.frame), CGRectGetMidY(newCurrentRect));
        } completion:^(BOOL finished){
            currentItem.imageArrow.hidden = NO;
            
            _lastIndexPath = indexPath;
            
            [currentItem hightLightWith:YES];
            
            self.imageArrow.hidden = YES;
            
            //将cell移动到可以看到的范围
            CGRect rect = [self.tableView rectForRowAtIndexPath:indexPath];
            [self.tableView scrollRectToVisible:rect animated:YES];
            
            if ([self.delegate respondsToSelector:@selector(didSelectRowAtIndexPath:view:)]) {
                [self.delegate didSelectRowAtIndexPath:indexPath view:self];
            }
        }];
        return;
    }
    
    //没有动画效果
    self.imageArrow.center = CGPointMake(CGRectGetMidX(self.imageArrow.frame), CGRectGetMidY(newCurrentRect));
    self.imageArrow.hidden = YES;
    currentItem.imageArrow.hidden = NO;
    
    [currentItem hightLightWith:YES];
    
    //将cell移动到可以看到的范围
    CGRect rect = [self.tableView rectForRowAtIndexPath:indexPath];
    [self.tableView scrollRectToVisible:rect animated:YES];
    
    if ([self.delegate respondsToSelector:@selector(didSelectRowAtIndexPath:view:)]) {
        [self.delegate didSelectRowAtIndexPath:indexPath view:self];
    }
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


#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //解决当cell移出可视范围时，再出现时之前的选中的cell会重复出现的问题
    if (![indexPath isEqual:_lastIndexPath]) {
        //UITableViewCell *lastCell = [self.tableView cellForRowAtIndexPath:indexPath];
        BaseFollowArrowCell *lastItem = (BaseFollowArrowCell *)cell;
        [lastItem hightLightWith:NO];
        lastItem.imageArrow.hidden = YES;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.delegate heightForRowAtIndexPath:indexPath view:self];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    [self setArrowToIndex:indexPath animation:YES];
}


@end
