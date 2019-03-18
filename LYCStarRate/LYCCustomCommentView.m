
//  LYCCustomCommentView.m
//  LYCStarRate
//
//  Created by liuyanchi on 2017/8/21.
//  Copyright © 2017年 yidaoyongche. All rights reserved.
//

#import "LYCCustomCommentView.h"
#import "LYCCommentTagCell.h"
#import "LYCCostomStarRateView.h"
#import "GBCustomTextView.h"

#define CellCountA 6
#define CellCountB 2
#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height


@interface LYCCustomCommentView ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (assign, nonatomic) NSInteger starTag;
@property (strong, nonatomic) GBCustomTextView *textView;
@property (strong, nonatomic) UITapGestureRecognizer *gestureRecognizer;
@property (strong, nonatomic) UIButton *commitBtn;

@end

@implementation LYCCustomCommentView
{
    CGRect _frame;
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self creatUI];
    }
    return self;
}

#pragma mark - CreatUI
- (void)creatUI
{
    LYCCostomStarRateView *starView = [[LYCCostomStarRateView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 150) withStarCount:5];
    typeof(self) __weak weakself = self;
    starView.block = ^(NSInteger starTag) {
        [weakself subViewFrameChangeWithStarTag:starTag];
        [weakself.tableView reloadData];
    };
    [self addSubview:starView];
    
    [self.tableView addGestureRecognizer:self.gestureRecognizer];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showKeyBoard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideKeyBoard:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)showKeyBoard:(NSNotification *)notification {
    [UIView animateWithDuration:0.25 animations:^{
        CGRect keyBoardframe = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        self.frame = CGRectMake(_frame.origin.x, _frame.origin.y - keyBoardframe.size.height + 100, _frame.size.width, _frame.size.height);
    }];
}

- (void)hideKeyBoard:(NSNotification *)notification {
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = _frame;
    }];
}

- (void)subViewFrameChangeWithStarTag:(NSInteger)tag
{
    [self addSubview:self.tableView];
    [self addSubview:self.textView];
    [self addSubview:self.commitBtn];
    [UIView animateWithDuration:0.5 animations:^{
        if (tag == 4) {
            self.frame = CGRectMake(self.frame.origin.x, 200, Width,Height - 200);
            self.tableView.frame = CGRectMake(0, 150, self.bounds.size.width, 100);
            _frame = self.frame;
        }else{
            self.frame = CGRectMake(self.frame.origin.x, 100, Width, Height - 100);
            self.tableView.frame = CGRectMake(0, 150, self.bounds.size.width, 200);
            _frame = self.frame;
        }
        self.textView.frame = CGRectMake(50, CGRectGetMaxY(self.tableView.frame) + 20, self.bounds.size.width - 100, 50);
        self.commitBtn.frame = CGRectMake(50 , CGRectGetMaxY(self.textView.frame) + 20, Width - 100, 30);
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.starTag == 4) {
        return CellCountB;
    }else{
        return CellCountA;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYCCommentTagCell *cell = [LYCCommentTagCell cellWithUITableView:tableView withIndexPath:indexPath];
    cell.model = [self testDataArr];
    cell.btnBlock = ^(NSInteger tag, NSString *title,BOOL isSelect) {
        if (isSelect) {
            self.commitBtn.enabled = YES;
            [self.commitBtn setBackgroundColor:[UIColor redColor]];
        } else {
            self.commitBtn.enabled = NO;
            [self.commitBtn setBackgroundColor:[UIColor grayColor]];
        }
        NSLog(@"%zd --- %@",tag,title);
        
    };
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

#pragma mark - UITextViewDelegate
-(BOOL)textView:(UITextView *)textView
shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSString *tempString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    if (![tempString isEqualToString:@""]) {
        self.commitBtn.enabled = YES;
        [self.commitBtn setBackgroundColor:[UIColor redColor]];
    }else{
        self.commitBtn.enabled = NO;
        [self.commitBtn setBackgroundColor:[UIColor grayColor]];
        
    }
    return YES;
    
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.5 animations:^{
        textView.frame = CGRectMake(50, CGRectGetMaxY(self.tableView.frame) + 20, self.bounds.size.width - 100, 100);
        self.commitBtn.frame = CGRectMake(50 , CGRectGetMaxY(textView.frame) + 20, Width - 100, 30);
    }];
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.5 animations:^{
        textView.frame = CGRectMake(50, CGRectGetMaxY(self.tableView.frame) + 20, self.bounds.size.width - 100, 30);
        self.commitBtn.frame = CGRectMake(50 , CGRectGetMaxY(textView.frame) + 20, Width - 100, 30);
    }];
    return YES;
}



#pragma mark - buttonClick
- (void)commitBtnClick:(UIButton *)sender
{
    NSLog(@"%@",@"递交按钮点击了");
    
}

#pragma mark - 退出键盘
- (void) hideKeyboard {
    [self.textView resignFirstResponder];
}

#pragma mark - get

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 150, self.bounds.size.width, 200)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (GBCustomTextView *)textView
{
    if (!_textView) {
        _textView = [[GBCustomTextView alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(self.tableView.frame) + 20, self.bounds.size.width - 100, 160)];
        _textView.maxCharacters = 60;
        _textView.placeholder  = @"其他想说的(将匿名并延迟告知司机)";
        _textView.delegate = self;
        _textView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _textView;
}


- (UITapGestureRecognizer *)gestureRecognizer
{
    if (!_gestureRecognizer) {
        _gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:
                              @selector(hideKeyboard)];
        _gestureRecognizer.numberOfTapsRequired = 1;
        _gestureRecognizer.cancelsTouchesInView = NO;
    }
    return _gestureRecognizer;
}

- (UIButton *)commitBtn
{
    if (!_commitBtn) {
        _commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _commitBtn.frame = CGRectMake(50 , CGRectGetMaxY(self.textView.frame) + 20, Width - 100, 30);
        [_commitBtn setTitle:@"匿名提交" forState:0];
        [_commitBtn setTitleColor:[UIColor whiteColor] forState:0];
        [_commitBtn setBackgroundColor:[UIColor grayColor]];
        [_commitBtn addTarget:self action:@selector(commitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commitBtn;
}

- (NSArray *)testDataArr
{
    return @[@"测试一",@"测试二"];
}

@end
