//
//  SecondViewController.m
//  EBTWaterWaveDemo
//
//  Created by ebaotong on 16/7/22.
//  Copyright © 2016年 com.csst. All rights reserved.
//

#import "SecondViewController.h"
#import "EBTWaterImageWaveView.h"
@interface SecondViewController ()
{
   
    EBTWaterImageWaveView *customWaveView;
}
@property (weak, nonatomic) IBOutlet EBTWaterImageWaveView *waterImageView;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   // customWaveView = [[EBTWaterImageWaveView alloc]initWithFrame:CGRectMake(120, 120, 105, 105)];
   // [self.view addSubview:customWaveView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnClick:(UIButton *)sender {
    
  
    sender.enabled = NO;
    
    [self.waterImageView showWaterImageWaveViewWithDepath:0.47 withWaveBackGroundImage:[UIImage imageNamed:@"wave"] withWaveFillImage:[UIImage imageNamed:@"wavegreen"] withWaveStillAnimate:YES withWaveImageViewCompleteHandler:^(EBTWaterImageWaveView *waveImageView) {
        
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        sender.enabled = YES;
    });

}


@end
