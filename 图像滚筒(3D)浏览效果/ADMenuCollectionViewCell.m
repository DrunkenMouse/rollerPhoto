//
//  ADMenuCollectionViewCell.m
//  图像滚筒(3D)浏览效果
//
//  Created by 王奥东 on 16/11/29.
//  Copyright © 2016年 王奥东. All rights reserved.
//

#import "ADMenuCollectionViewCell.h"

@implementation ADMenuCollectionViewCell

//初始化
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_imageView];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_titleLabel];
    }
    return self;
}

//布局
-(void)layoutSubviews {
    
    [super layoutSubviews];
    _imageView.frame = self.contentView.bounds;
    _titleLabel.frame = CGRectMake(0, 0, self.contentView.bounds.size.width, 44);
    
}


@end
