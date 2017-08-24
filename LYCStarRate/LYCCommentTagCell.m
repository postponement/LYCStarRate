//
//  LYCCommentTagCell.m
//  LYCStarRate
//
//  Created by liuyanchi on 2017/8/21.
//  Copyright © 2017年 yidaoyongche. All rights reserved.
//

#import "LYCCommentTagCell.h"

#define LabWidth (  [UIScreen mainScreen].bounds.size.width - 120)/2

@interface LYCCommentTagCell ()
@property (strong, nonatomic) UIButton *leftBtn;
@property (strong, nonatomic) UIButton *rightBtn;
@end

static NSString *identifier;
@implementation LYCCommentTagCell

+ (instancetype)cellWithUITableView:(UITableView *)tableView withIndexPath:(NSIndexPath *)indexPath
{
     identifier = [NSString stringWithFormat:@"LYCCommentTagCellIdentifier%zd%zd",indexPath.section,indexPath.row];
    LYCCommentTagCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[LYCCommentTagCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
//    else{
//        while ([cell.contentView.subviews lastObject] != nil)
//        {
//            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
//        }
//    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.selected = NO;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI
{
    [self.contentView addSubview:self.leftBtn];
    [self.contentView addSubview:self.rightBtn];
}

- (void)setModel:(id)model
{
    _model = model;
    [self.leftBtn setBackgroundColor:[UIColor whiteColor]];
    [self.leftBtn setTitleColor:[UIColor grayColor] forState:0];
    self.leftBtn.selected = NO;
    [self.rightBtn setBackgroundColor:[UIColor whiteColor]];
    [self.rightBtn setTitleColor:[UIColor grayColor] forState:0];
    self.rightBtn.selected = NO;
}

- (void)buttonClick:(UIButton *)sender
{
    if (sender.selected) {
        [sender setBackgroundColor:[UIColor whiteColor]];
        [sender setTitleColor:[UIColor grayColor] forState:0];
        sender.selected = NO;
    }else{
        [sender setBackgroundColor:[UIColor redColor]];
        [sender setTitleColor:[UIColor whiteColor] forState:0];
        sender.selected = YES;
    }
    if (self.btnBlock) {
        self.btnBlock(sender.tag,sender.titleLabel.text,sender.selected);
    }
}

- (UIButton *)leftBtn
{
    if (!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.frame = CGRectMake(50, 10,LabWidth, 30);
        [_leftBtn setTitle:@"测试" forState:0];
        [_leftBtn setTitleColor:[UIColor grayColor] forState:0];
        _leftBtn.layer.borderWidth = 1;
        _leftBtn.layer.borderColor = [UIColor grayColor].CGColor;
        [_leftBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}

- (UIButton *)rightBtn
{
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.frame = CGRectMake(50 + LabWidth + 20, 10, LabWidth, 30);
        [_rightBtn setTitle:@"测试" forState:0];
        [_rightBtn setTitleColor:[UIColor grayColor] forState:0];
        _rightBtn.layer.borderWidth = 1;
        _rightBtn.layer.borderColor = [UIColor grayColor].CGColor;
        [_rightBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}

@end
