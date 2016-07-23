//
//  EBTWaterImageWaveView.h
//  EBTWaterWaveDemo
//
//  Created by ebaotong on 16/7/22.
//  Copyright © 2016年 com.csst. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EBTWaterImageWaveView;

typedef void(^EBTWaterImageWaveViewCompleteHandler)(EBTWaterImageWaveView *waveImageView);

@interface EBTWaterImageWaveView : UIView
{
    EBTWaterImageWaveViewCompleteHandler  waterWaveImageViewCompleteHandler;
}

/**
 *   使用两张图片来实现水波动画
 *
 *  @param waterDepath     水位值
 *  @param backGroundImage  背景图
 *  @param fillImage       水波填充的图
 *  @param isStillAnimate  设置水波动画是否一直执行
 *  @param waveImageCompleteHandler 参数回调
 */


- (void)showWaterImageWaveViewWithDepath:(CGFloat)waterDepath withWaveBackGroundImage:(UIImage *)backGroundImage withWaveFillImage:(UIImage *)fillImage withWaveStillAnimate:(BOOL)isStillAnimate withWaveImageViewCompleteHandler:(EBTWaterImageWaveViewCompleteHandler) waveImageCompleteHandler;
/**
 *  停止水波动画
 */
- (void)stopWaterWaveViewAnimation;
@end
