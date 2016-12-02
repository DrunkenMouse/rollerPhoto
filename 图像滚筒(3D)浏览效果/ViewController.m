//
//  ViewController.m
//  图像滚筒(3D)浏览效果
//
//  Created by 王奥东 on 16/11/29.
//  Copyright © 2016年 王奥东. All rights reserved.
//  参考： 开发实战 进阶

#define KCellIdentifier @"identifier"

#import "ViewController.h"
#import "ADMenuCollectionViewCell.h"
#import "ADCollectionViewLayout.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation ViewController {
    UICollectionView * _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, width, height) collectionViewLayout:[[ADCollectionViewLayout alloc] init]];
    [_collectionView registerClass:[ADMenuCollectionViewCell class] forCellWithReuseIdentifier:KCellIdentifier];
    
    _collectionView.backgroundColor = [UIColor grayColor];
    _collectionView.delegate = self;
    
    //偏移之后从0开始展示
    [_collectionView setContentOffset:CGPointMake(width, 0)];
    
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];

}

//获取块数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 9;
}

//获取每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ADMenuCollectionViewCell *cell = (ADMenuCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:KCellIdentifier forIndexPath:indexPath];
  
    if (!cell) {
        //Collection中Cell不可能为空
        return nil;
    }
    NSString *imageName = [NSString stringWithFormat:@"%d",(int)indexPath.row];
    
    cell.imageView.image = [UIImage imageNamed:imageName];
    cell.titleLabel.text = imageName;
    
    return cell;
}

#pragma mark - UIScrollViewDelegate
//滚动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //无限循环
    float targetX = scrollView.contentOffset.x;
    int numCount = [_collectionView numberOfItemsInSection:0];
    float item_width = scrollView.frame.size.width;
    
    //只有总数大于等于3才会滚动
    if (numCount >= 3) {
        //向左滚动小于cell的一半，即滚动超过cell的一半
        //此时调整偏移量，显示下一个
        if (targetX < item_width/2) {
            //让偏移量右移X+cell宽度的倍数
            scrollView.contentOffset = CGPointMake(targetX+item_width*numCount, 0);
        }
        //如果向右滚动
        else if (targetX > item_width/2 + item_width*numCount) {
            //同上，减去
            scrollView.contentOffset = CGPointMake(targetX-item_width * numCount, 0);
        }
    }

}


@end
