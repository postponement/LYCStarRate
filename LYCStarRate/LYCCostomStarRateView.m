//
//  LYCCostomStarRateView.m
//  LYCStarRate
//
//  Created by liuyanchi on 2017/8/18.
//  Copyright © 2017年 yidaoyongche. All rights reserved.
//

#import "LYCCostomStarRateView.h"

#define btnWidth 38
#define margin (self.bounds.size.width - _starCount * btnWidth) / 2

@interface LYCCostomStarRateView ()
@property (strong, nonatomic) UILabel *commentLab;
@property (strong, nonatomic) NSArray *desArr;
@property (strong, nonatomic) UILabel *desLab;
@property (strong, nonatomic) UIView *line;
@end

@implementation LYCCostomStarRateView
{
    NSUInteger _starCount;
}

- (instancetype)initWithFrame:(CGRect)frame withStarCount:(NSUInteger)starCount
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        _starCount = starCount;
        [self setStarUI:starCount];
    }
    return self;
}

- (void)setStarUI:(NSUInteger)count
{
    [self addSubview:self.commentLab];
    [self addSubview:self.line];
    
    if (count == 0) {
        count = 5;// 默认五星
    }
    for (NSInteger i = 0; i < count; i++) {
        UIButton *starBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        starBtn.frame = CGRectMake(margin + i * btnWidth, 60, btnWidth, btnWidth);
        [starBtn setImage:[UIImage imageNamed:@"rateStarGray"] forState:UIControlStateNormal];
        starBtn.tag = i;
        starBtn.adjustsImageWhenHighlighted = NO;
        [starBtn addTarget:self action:@selector(starBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview: starBtn];
    }
    [self addSubview: self.desLab];
}

- (void)starBtnClick:(UIButton *)sender
{
    self.desLab.text = self.desArr[sender.tag];
    [self.subviews enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIButton class]]) {
            if (obj.tag < sender.tag) {
                obj.selected = YES;
                [obj setImage:[UIImage imageNamed:@"rateStarRed"] forState:UIControlStateSelected];
            }else if (obj.tag == sender.tag){
                    obj.selected = YES;
                    [obj setImage:[UIImage imageNamed:@"rateStarRed"] forState:UIControlStateSelected];
            }else {
                obj.selected = NO;
                [obj setImage:[UIImage imageNamed:@"rateStarGray"] forState:UIControlStateSelected];
            }
        }
    }];
    
    if (self.block) {
        self.block(sender.tag);
    }
    
}

- (UILabel *)commentLab
{
    if (!_commentLab) {
        _commentLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 40)];
        _commentLab.text  =@"请评价本次服务";
        _commentLab.font = [UIFont boldSystemFontOfSize:16.f];
        _commentLab.textColor = [UIColor blackColor];
        _commentLab.textAlignment = NSTextAlignmentCenter;
    }
    return _commentLab;
}

- (NSArray *)desArr
{
    if (!_desArr) {
        _desArr = @[@"非常不满意，各方面都很差",@"不满意，比较差",@"一般，还需改善",@"比较满意，仍可改善",@"非常满意，无可挑剔"];
    }
    return _desArr;
}

- (UILabel *)desLab
{
    if (!_desLab) {
        _desLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, self.bounds.size.width, 30)];
        _desLab.text  =@"您的评价会让司机做的更好";
        _desLab.font = [UIFont systemFontOfSize:14.f];
        _desLab.textColor = [UIColor orangeColor];
        _desLab.textAlignment = NSTextAlignmentCenter;
    }
    return _desLab;
}

- (UIView *)line
{
    if (!_line) {
        _line = [[UIView alloc] initWithFrame:CGRectMake(0, 40 + 10,self.bounds.size.width , 1)];
        _line.backgroundColor = [UIColor blackColor];
    }
    return _line;
}

@end
