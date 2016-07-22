//
//  EBTWaterImageWaveView.m
//  EBTWaterWaveDemo
//
//  Created by ebaotong on 16/7/22.
//  Copyright © 2016年 com.csst. All rights reserved.
//

#import "EBTWaterImageWaveView.h"
#define kMAXYValue  2.5
#define kWeakSelf(weakSelf)  __weak __typeof(self)weakSelf = self

@interface EBTWaterImageWaveView ()
{
     UIImageView * backGroundImageView;
     UIImageView * fillImageView;
     BOOL waveImageDirection;
    CGFloat waveImageMaxYValue ;//用来控制y坐标的值
    CGFloat waveImageXValue;//改变x坐标的值
    CGFloat waterWaveImageDepath;//设置image的深度
    CGRect  waveImageFrame; //frame
    UIImage *waveBackImage;
    UIImage *waveFillImage;
   
    
}
@property(nonatomic,strong) NSTimer *timer;
@end

@implementation EBTWaterImageWaveView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        waveImageDirection = NO;
        waveImageMaxYValue = kMAXYValue;
        waveImageXValue = 0;
        backGroundImageView = [[UIImageView alloc]init];
        backGroundImageView.frame = self.bounds;
       backGroundImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:backGroundImageView];
        
        fillImageView = [[UIImageView alloc]init];
        fillImageView.frame = self.bounds;
         fillImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:fillImageView];
        
       
        
    }
    return self;
}
- (void)awakeFromNib{
    
    self.backgroundColor = [UIColor clearColor];
    waveImageDirection = NO;
    waveImageMaxYValue = kMAXYValue;
    waveImageXValue = 0;
   
    backGroundImageView = [UIImageView new];
    backGroundImageView.frame = self.bounds;
    backGroundImageView.contentMode = UIViewContentModeScaleAspectFit;
    backGroundImageView.image = waveBackImage;
    [self addSubview:backGroundImageView];
    
    fillImageView = [UIImageView new];
    fillImageView.frame = self.bounds;
     fillImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:fillImageView];
    
    
    
    
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
//停止定时器
- (void)stopWaterWaveViewAnimation{
    
    [self stopTimer];
    
}

- (void)dealloc{
    [self stopTimer];
}

- (void)waterFillWave{
    
    waveImageMaxYValue += waveImageDirection?0.01f:-0.01f;
    if (waveImageMaxYValue<=kMAXYValue) {
        waveImageDirection = YES;
    }
    else if (waveImageMaxYValue>=kMAXYValue){
        waveImageDirection = NO;
    }
    waveImageXValue += 0.1f;
    
    [self createWavePath];
    
}
//绘制水波
- (void)createWavePath{
    
    /**----------xib或者sb需要重新布局frame获取最新的frame-------------*/
    [self layoutIfNeeded];
    fillImageView.frame = self.bounds;
    backGroundImageView.frame = self.bounds;
   
    waveImageFrame = self.bounds;
    /**----------xib或者sb需要重新布局frame获取最新的frame-------------*/
    CAShapeLayer *shapelayer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat waterWaveY = (1 - (waterWaveImageDepath > 1.f? 1.f :waterWaveImageDepath)) * waveImageFrame.size.height;
    CGFloat y = waterWaveY;
    [path moveToPoint:CGPointMake(0, y)];
    path.lineWidth = 1.f;
    for (CGFloat x = 0; x<= waveImageFrame.size.width; x++) {
        y = waveImageMaxYValue*sin(x/180*M_PI+4*waveImageXValue/M_PI)*5 + waterWaveY;
        [path addLineToPoint:CGPointMake(x, y)];
    }
    [path addLineToPoint:CGPointMake(waveImageFrame.size.width, y)];
    [path addLineToPoint:CGPointMake(waveImageFrame.size.width, waveImageFrame.size.height)];
    [path addLineToPoint:CGPointMake(0, waveImageFrame.size.height)];
    shapelayer.path = path.CGPath;
    backGroundImageView.image = waveBackImage;
    fillImageView.image = waveFillImage;
    fillImageView.layer.mask = shapelayer;
    [path closePath];
    if (waterWaveImageViewCompleteHandler) {
        waterWaveImageViewCompleteHandler(self);
    }
    
    
    
    
}


- (void)showWaterImageWaveViewWithDepath:(CGFloat)waterDepath withWaveBackGroundImage:(UIImage *)backGroundImage withWaveFillImage:(UIImage *)fillImage withWaveStillAnimate:(BOOL)isStillAnimate withWaveImageViewCompleteHandler:(EBTWaterImageWaveViewCompleteHandler) waveImageCompleteHandler{

    waterWaveImageDepath = waterDepath;
    waveBackImage = backGroundImage;
    waveFillImage = fillImage;
    waterWaveImageViewCompleteHandler = waveImageCompleteHandler;
     [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    kWeakSelf(weakSelf);
    if (!isStillAnimate) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf stopWaterWaveViewAnimation];
        });
    }
    
    
    

}
@end
