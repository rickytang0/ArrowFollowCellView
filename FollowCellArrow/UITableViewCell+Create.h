//
//  UITableViewCell+Create.h
//  RTIM
//
//  Created by 嘉宾 唐 on 12-11-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (Create)
+ (id)cellForTableView:(UITableView *)tableView;
+ (NSString *)cellIdentifier;

- (id)initWithCellIdentifier:(NSString *)cellID;

+ (UINib *)nib;
+ (NSString *)nibName;

+ (NSString *)cellIdentifier;
+ (id)cellForTableView:(UITableView *)tableView fromNib:(UINib *)nib andOwner:(id)owner;
@end
