# 用UIView或者两张图片来根据设置对应水位值来实现水波动画，支持纯代码、Xib、SB

# 可以通过设置对应的参数来控制水波动画是否一直执行。

#需要把文件夹名为“EBTWaterWaveView”里面的文件加入工程中，然后import引入一下对应的类文件。

#用UIView实现水波动画操作过程

首先:#import "EBTWaterWaveView.h" 类文件

然后:
#纯代码使用示例:
1:先创建水波动画view并添加self.view上面。
 waveView = [[EBTWaterWaveView alloc]initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH, SCREEN_HEIGHT)];
[self.view addSubview:waveView];

2:调用其方法

 [self.waveView showWaterWaveViewWithDepath:0.87 withWaveFillColor:[[UIColor redColor] colorWithAlphaComponent:0.5] withWaveStillAnimate:YES withWaterWaveCompleteHandler:^(EBTWaterWaveView *waterWaveView, UIBezierPath *bezierPath) {
        
        
    }];


# Xib或者SB示例

1:先在控制器上面拖一个view并将其class设置为“EBTWaterWaveView”,并托线条引出去。

2: 调用其方法

[self.waterWaveView showWaterWaveViewWithDepath:0.87 withWaveFillColor:[[UIColor redColor] colorWithAlphaComponent:0.5] withWaveStillAnimate:YES withWaterWaveCompleteHandler:^(EBTWaterWaveView *waterWaveView, UIBezierPath *bezierPath) {
        
        
    }];


#效果演示图
![Image](https://github.com/KBvsMJ/EBTWaterWaveDemo/blob/master/demogif/3.gif)






#用两张切图实现水波动画操作过程

首先: #import "EBTWaterImageWaveView.h" 类文件

然后:
#纯代码使用示例:
1:先创建水波动画view并添加self.view上面。
  customWaveView = [[EBTWaterImageWaveView alloc]initWithFrame:CGRectMake(120, 120, 105, 105)];
[self.view addSubview:customWaveView];

2:调用其方法

  [customWaveView showWaterImageWaveViewWithDepath:0.47 withWaveBackGroundImage:[UIImage imageNamed:@"wave"] withWaveFillImage:[UIImage imageNamed:@"wavegreen"] withWaveStillAnimate:YES withWaveImageViewCompleteHandler:^(EBTWaterImageWaveView *waveImageView) {
        
    }];



# Xib或者SB示例

1:先在控制器上面拖一个view并将其class设置为“EBTWaterImageWaveView”,并托线条引出去。

2: 调用其方法

 [self.waterImageView showWaterImageWaveViewWithDepath:0.47 withWaveBackGroundImage:[UIImage imageNamed:@"wave"] withWaveFillImage:[UIImage imageNamed:@"wavegreen"] withWaveStillAnimate:YES withWaveImageViewCompleteHandler:^(EBTWaterImageWaveView *waveImageView) {
        
    }];

#效果演示图
![Image](https://github.com/KBvsMJ/EBTWaterWaveDemo/blob/master/demogif/wave.gif)

