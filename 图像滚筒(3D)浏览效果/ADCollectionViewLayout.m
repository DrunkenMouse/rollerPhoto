//
//  ADCollectionViewLayout.m
//  图像滚筒(3D)浏览效果
//
//  Created by 王奥东 on 16/11/29.
//  Copyright © 2016年 王奥东. All rights reserved.
//

#import "ADCollectionViewLayout.h"

@implementation ADCollectionViewLayout



-(CGSize)collectionViewContentSize {
    //collectionView Size
    //宽度是collectionView的宽度 * （cell数+2）
    //加2是为了防止只有3张图片时，要能显示动画
    float width = self.collectionView.frame.size.width*([self.collectionView numberOfItemsInSection:0]+2);
    float height = self.collectionView.frame.size.height;
    CGSize size = CGSizeMake(width, height);
    return size;
    
}

//当边界发生改变时，是否应该刷新布局
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}


//根据indexPath设置一个Attributes
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //动画核心，获取当前Cell的属性
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    UICollectionView *collection = self.collectionView;
    float width = collection.frame.size.width;
    //offsetX
    float x = collection.contentOffset.x;
  
    //第0组总cell数
    int numberOfVisibleItems = [self.collectionView numberOfItemsInSection:0];
    //cell
    attributes.center = CGPointMake(x+160, 240.0f);
    attributes.size = CGSizeMake(90.0f, 100.0f);
    
    //类似于缩放平移等属性的设置
    CATransform3D transform = CATransform3DIdentity;
    //要实现view（layer）的透视效果（就是近大远小），是通过设置m34的
    //值越小，效果越明显
    transform.m34 = -1.0f/700.0f;
    
    //角度
    CGFloat arc = M_PI * 2.0f;
    
    //z轴偏移，值越大，那么图层就越往外（接近屏幕），值越小，图层越往里
    CGFloat radius = attributes.size.width/2/tanf(arc/2.0f/numberOfVisibleItems);
    
    //Y轴旋转角度
    CGFloat angle = (indexPath.row - x / width+1)/numberOfVisibleItems *arc;
    
    //Y轴旋转
    transform = CATransform3DRotate(transform, angle, 0, 1.0f, 0);
  
    //Z轴偏移，tz值越大，那么图层就越往外（接近屏幕），值越小，图层越往里
    transform = CATransform3DTranslate(transform, 0, 0, radius);
    
    attributes.transform3D = transform;
    
    return attributes;
    
}

//返回rect中所有元素的布局属性,系统默认调用，也就是当前显示的Rect
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    //已设置就返回，没设置就设置
    NSArray *arr = [super layoutAttributesForElementsInRect:rect];
    if ([arr count] > 0) {
        return arr;
    }
    //给每个Cell设置属性
    NSMutableArray * attributes = [NSMutableArray array];
    for (NSInteger i = 0; i < [self.collectionView numberOfItemsInSection:0]; i++) {
        NSIndexPath * indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    return attributes;
}


@end
