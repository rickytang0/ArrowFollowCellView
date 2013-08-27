//
//  UITableViewCell+Create.m
//  RTIM
//
//  Created by 嘉宾 唐 on 12-11-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UITableViewCell+Create.h"

@implementation UITableViewCell (Create)


+ (NSString *)cellIdentifier {
    return NSStringFromClass([self class]);
}

+ (id)cellForTableView:(UITableView *)tableView {
    NSString *cellID = [self cellIdentifier];
    UITableViewCell *cell = [tableView 
                             dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell =[[self alloc] initWithCellIdentifier:cellID];
    }
    return cell;    
}


- (id)initWithCellIdentifier:(NSString *)cellID {
    return [self initWithStyle:UITableViewCellStyleSubtitle 
               reuseIdentifier:cellID];
}


#pragma mark -
#pragma mark Nib Cell generation


+ (id)cellForTableView:(UITableView *)tableView fromNib:(UINib *)nib andOwner:(id)owner {
    NSString *cellID = [self cellIdentifier];
    UITableViewCell *cell = [tableView 
                             dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        NSArray *nibObjects = [nib instantiateWithOwner:owner options:nil];
		
        NSAssert2(([nibObjects count] > 0) && 
                  [[nibObjects objectAtIndex:0] isKindOfClass:[self class]],
                  @"Nib '%@' does not appear to contain a valid %@", 
                  [self nibName], NSStringFromClass([self class]));
        
        cell = [nibObjects objectAtIndex:0];
    }
    return cell;
}

#pragma mark -
#pragma mark Nib support

+ (UINib *)nib {
    NSBundle *classBundle = [NSBundle bundleForClass:[self class]];
    return [UINib nibWithNibName:[self nibName] bundle:classBundle];
}

+ (NSString *)nibName {
    return [self cellIdentifier];
}

@end
