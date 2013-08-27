//
//  BaseFollowArrowCell.m
//  FollowCellArrow
//
//  Created by 唐 嘉宾 on 13-8-3.
//  Copyright (c) 2013年 唐 嘉宾. All rights reserved.
//

#import "BaseFollowArrowCell.h"

@implementation BaseFollowArrowCell
@synthesize imageArrow;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.imageArrow.hidden = YES;
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        self.imageArrow.hidden = YES;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)drawRect:(CGRect)rect
{
    self.imageArrow.hidden = YES;
    self.imageArrow.center = CGPointMake(CGRectGetWidth(self.frame)-CGRectGetWidth(self.imageArrow.frame)/2, CGRectGetHeight(self.frame)/2);
}

@end
