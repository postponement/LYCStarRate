//
//  GBCustomTextView.h
//  GreenBuild
//
//  Created by liuyanchi on 17/3/13.
//  Copyright © 2017年 ApesStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef NS_ENUM(NSUInteger, HJTextViewType) {
//    HJTextView_normal = 0,//正常的textView
//    HJTextView_placeHolderAndCount,//显示placeHolder和字符数
//    HJTextView_onlyPlaceHolder//只显示placeHolder
//    
//};

@interface GBCustomTextView : UITextView

@property (nonatomic, copy) NSString * placeholder;
@property (nonatomic, assign) NSInteger maxCharacters;
//@property (nonatomic, assign) HJTextViewType textViewType;

@end

