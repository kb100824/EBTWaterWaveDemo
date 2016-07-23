//
//  EBTWaterWaveView.h
//  EBTWaterWaveDemo
//
//  Created by ebaotong on 16/7/21.
//  Copyright © 2016年 com.csst. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EBTWaterWaveView;
typedef void(^EBTWaterWaveViewCompleteHandler)(EBTWaterWaveView *waterWaveView);
/**
 *  用uiview来实现水波动画
 */
@interface EBTWaterWaveView : UIView
{
    EBTWaterWaveViewCompleteHandler waterWaveCompleteHandler;
}
/**
 *  显示水波动画
 *
 *  @param waterDepath         水波动画水平值
 *  @param waveColor           水波的颜色
 *  @param isStillAnimate      水波是否一直显示动画
 *  @param waveCompleteHandler 参数回调
 */
-(void)showWaterWaveViewWithDepath:(CGFloat)waterDepath withWaveFillColor:(UIColor *)waveColor withWaveStillAnimate:(BOOL)isStillAnimate withWaterWaveCompleteHandler:(EBTWaterWaveViewCompleteHandler)waveCompleteHandler;

/**
 *  移除水波动画
 */
- (void)stopWaterWaveViewAnimation;


@end
