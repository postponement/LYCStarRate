//
//  LYCCostomStarRateView.h
//  LYCStarRate
//
//  Created by liuyanchi on 2017/8/18.
//  Copyright © 2017年 yidaoyongche. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^StarClickBlock)(NSInteger);
@interface LYCCostomStarRateView : UIView

- (instancetype)initWithFrame:(CGRect)frame withStarCount:(NSUInteger)starCount;

@property (copy, nonatomic) StarClickBlock block;

@end
