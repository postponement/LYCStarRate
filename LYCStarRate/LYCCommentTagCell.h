//
//  LYCCommentTagCell.h
//  LYCStarRate
//
//  Created by liuyanchi on 2017/8/21.
//  Copyright © 2017年 yidaoyongche. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BtnBlock)(NSInteger tag, NSString *title,BOOL isSelect);

@interface LYCCommentTagCell : UITableViewCell

// 数据
@property (strong, nonatomic) id model;
@property (copy, nonatomic) BtnBlock btnBlock;

+ (instancetype)cellWithUITableView:(UITableView *)tableView withIndexPath:(NSIndexPath *)indexPath;

@end
