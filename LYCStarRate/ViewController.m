//
//  ViewController.m
//  LYCStarRate
//
//  Created by liuyanchi on 2017/8/18.
//  Copyright © 2017年 yidaoyongche. All rights reserved.
//

#import "ViewController.h"
#import "LYCCustomCommentView.h"

@interface ViewController ()
@property (strong, nonatomic) LYCCustomCommentView *commentView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    // 添加评论
    [self.view addSubview:self.commentView];
}

- (LYCCustomCommentView *)commentView
{
    if (!_commentView) {
        _commentView = [[LYCCustomCommentView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 150, self.view.bounds.size.width, 150)];;
    }
    return _commentView;
}


@end
