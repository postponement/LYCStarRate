//
//  GBCustomTextView.m
//  GreenBuild
//
//  Created by liuyanchi on 17/3/13.
//  Copyright © 2017年 ApesStudio. All rights reserved.
//

#import "GBCustomTextView.h"

@interface GBCustomTextView ()
@property(nonatomic ,strong)UILabel *placeholderLabel;
@property(nonatomic ,strong)UILabel *maxCharactersLabel;
@end

@implementation GBCustomTextView


- (instancetype)initWithFrame:(CGRect)frame;{
    self = [super initWithFrame:frame];
    if(self){
        [self setupUI];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.placeholderLabel];
    [self addSubview:self.maxCharactersLabel];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didBeginEditing:) name:UITextViewTextDidBeginEditingNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
}

#pragma mark - pravite methods
- (void)didBeginEditing:(NSNotification *)notification{
    
    
}

- (void)textChanged:(NSNotification *)notification{
    
    self.placeholderLabel.alpha = self.text.length==0?1:0;
    if(self.text.length>self.maxCharacters){
        self.text = [self.text substringWithRange:NSMakeRange(0, self.maxCharacters)];
    }
    self.maxCharactersLabel.text = [NSString stringWithFormat:@"%zd/%zd",[self.text length],self.maxCharacters];
}


- (void)setPlaceholder:(NSString *)placeholder{
        _placeholder = placeholder;
        [self.placeholderLabel removeFromSuperview];
        self.placeholderLabel = nil;
        [self addSubview:self.placeholderLabel];
        self.placeholderLabel.text = placeholder;
}

- (void)setMaxCharacters:(NSInteger)maxCharacters{
        _maxCharacters = maxCharacters;
        self.maxCharactersLabel.text = [NSString stringWithFormat:@"%zd/%zd",[self.text length],maxCharacters];
}

#pragma mark - getters/setters
- (UILabel *)placeholderLabel{
    if (!_placeholderLabel) {
        _placeholderLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0,self.bounds.size.width , 30)];
        _placeholderLabel.font = [UIFont systemFontOfSize:14.f];
        _placeholderLabel.numberOfLines = 0;
        _placeholderLabel.textColor =  [UIColor grayColor];
        _placeholderLabel.textAlignment = NSTextAlignmentLeft;
         [_placeholderLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    }
    return _placeholderLabel;
}

- (UILabel *)maxCharactersLabel{
    if (!_maxCharactersLabel) {
        _maxCharactersLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width  - 50, self.bounds.size.height - 100, 100, 30)];
        _maxCharactersLabel.font = [UIFont systemFontOfSize:14.f];
        _maxCharactersLabel.textColor =  [UIColor grayColor];
        _maxCharactersLabel.textAlignment = NSTextAlignmentLeft;
    [_maxCharactersLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    }
    return _maxCharactersLabel;
}

@end
