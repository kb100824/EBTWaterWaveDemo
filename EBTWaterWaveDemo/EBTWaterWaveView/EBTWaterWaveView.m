//
//  EBTWaterWaveView.m
//  EBTWaterWaveDemo
//
//  Created by ebaotong on 16/7/21.
//  Copyright © 2016年 com.csst. All rights reserved.
//

#import "EBTWaterWaveView.h"
#define kWeakSelf(weakSelf)  __weak __typeof(self)weakSelf = self
@interface EBTWaterWaveView ()
{
    CGRect  waveFrame; //frame
    BOOL    wavedirection;//方向
    CGFloat waveMaxYValue ;//用来控制y坐标的值 最大值为1.0
    CGFloat waveXValue;//改变x坐标的值
    CGFloat waterWaveDepath;//设置水的深度
    UIView  *waterWaveView; //填充水位的view
    UIColor *waterWaveColor; //view的背景颜色
}
@property(nonatomic,strong) NSTimer *timer;
@end
@implementation EBTWaterWaveView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
     
        self.backgroundColor = [UIColor clearColor];
        waveFrame = frame;
        wavedirection = NO;
        waveMaxYValue = 1.0;
        waveXValue = 0;
        waterWaveView = [[UIView alloc]initWithFrame:self.bounds];
        [self addSubview:waterWaveView];
        
    }
    return self;
}
- (void)awakeFromNib{
    self.backgroundColor = [UIColor clearColor];
    waveFrame = self.frame;
    wavedirection = NO;
    waveMaxYValue = 1.0;
    waveXValue = 0;
    waterWaveView = [[UIView alloc]initWithFrame:self.bounds];
    [self addSubview:waterWaveView];

}
- (NSTimer *)timer{

    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(waterFillWave) userInfo:nil repeats:YES];
    }
    return _timer;
    
}
- (void)stopTimer{
    
    [self.timer invalidate];
    self.timer = nil;
    
    
}

- (void)waterFillWave{

    waveMaxYValue += wavedirection?0.01f:-0.01f;
    if (waveMaxYValue<=1.0f) {
        wavedirection = YES;
    }
    else if (waveMaxYValue>=1.0f){
        wavedirection = NO;
    }
    waveXValue += 0.1f;
    
    [self createWavePath];
    
}
//绘制水波
- (void)createWavePath{

    CAShapeLayer *shapelayer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat waterWaveY = (1 - (waterWaveDepath > 1.f? 1.f :waterWaveDepath)) * waveFrame.size.height;
     CGFloat y = waterWaveY;
    [path moveToPoint:CGPointMake(0, y)];
    
    path.lineWidth = 1.f;
    
    for (CGFloat x = 0; x<= waveFrame.size.width; x++) {
        y = waveMaxYValue*sin(x/180*M_PI+4*waveXValue/M_PI)*5 + waterWaveY;
        [path addLineToPoint:CGPointMake(x, y)];
    }
    
    [path addLineToPoint:CGPointMake(waveFrame.size.width, y)];
    [path addLineToPoint:CGPointMake(waveFrame.size.width, waveFrame.size.height)];
    [path addLineToPoint:CGPointMake(0, waveFrame.size.height)];
    shapelayer.path = path.CGPath;
    waterWaveView.layer.mask = shapelayer;
    waterWaveView.backgroundColor = waterWaveColor;
    [path closePath];
    if (waterWaveCompleteHandler) {
        waterWaveCompleteHandler(self,path);
    }
    
    
    
}
-(void)showWaterWaveViewWithDepath:(CGFloat)waterDepath withWaveFillColor:(UIColor *)waveColor withWaveStillAnimate:(BOOL)isStillAnimate withWaterWaveCompleteHandler:(EBTWaterWaveViewCompleteHandler)waveCompleteHandler{

    kWeakSelf(weakSelf);
    waterWaveColor = waveColor?waveColor:[[UIColor purpleColor] colorWithAlphaComponent:0.5];
    waterWaveDepath = waterDepath;
    waterWaveCompleteHandler = waveCompleteHandler;
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    if (isStillAnimate) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf stopWaterWaveViewAnimation];
        });

    }
    
    
    
    

}
//停止定时器
- (void)stopWaterWaveViewAnimation{
    
    [self stopTimer];
    
}

- (void)dealloc{
   [self stopTimer];
}
@end


