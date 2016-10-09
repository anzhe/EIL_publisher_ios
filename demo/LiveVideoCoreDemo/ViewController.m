//
//  ViewController.m
//  LiveVideoCoreDemo
//
//  Created by Alex.Shi on 16/3/2.
//  Copyright © 2016年 com.Alex. All rights reserved.
//

#import "ViewController.h"
#import "LiveShowViewController.h"
#import "ZJSwitch.h"

@interface ViewController ()

@end

@implementation ViewController
{
    LiveShowViewController* _LiveShowViewController;
    UILabel* _horizontalLabel;
    ZJSwitch* _horizontalSwitch;
    UITextField* _RtmpUrlTextField;
    UIButton* _StartButton;
    UITextField* _RtmpUrlTextFieldD;
    
    UILabel* _videoSizeLabel;
    ZJSwitch* _videoSizeSwitch;

}

-(void) UIInit{
    double fScreenW = [UIScreen mainScreen].bounds.size.width;
    
    _horizontalLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, 55, 30)];
    _horizontalLabel.text = @"横屏拍摄:";
    _horizontalLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    [self.view addSubview: _horizontalLabel];
    
    float fhorizontalSwitchX = 10 + 55 + 5 +40;
    float fhorizontalSwitchY = 60;
    float fhorizontalSwitchW = 30;
    float fhorizontalSwitchH = 30;
    _horizontalSwitch = [[ZJSwitch alloc] initWithFrame:CGRectMake(fhorizontalSwitchX, fhorizontalSwitchY, fhorizontalSwitchW, fhorizontalSwitchH)];
    [self.view addSubview:_horizontalSwitch];
    
    float fRtmpUrlTextFieldX = 10;
    float fRtmpUrlTextFieldY = 100+40;
    float fRtmpUrlTextFieldW = fScreenW-2*fRtmpUrlTextFieldX;
    float fRtmpUrlTextFieldH = 30;
    _RtmpUrlTextField = [[UITextField alloc] initWithFrame:CGRectMake(fRtmpUrlTextFieldX, fRtmpUrlTextFieldY, fRtmpUrlTextFieldW, fRtmpUrlTextFieldH)];
    _RtmpUrlTextField.backgroundColor = [UIColor lightGrayColor];
    [_RtmpUrlTextField setTextColor:[UIColor whiteColor]];
    _RtmpUrlTextField.layer.masksToBounds = YES;
    _RtmpUrlTextField.layer.cornerRadius  = 5;
    _RtmpUrlTextField.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:_RtmpUrlTextField];
    
    float fStartButtonW = 70;
    float fStartButtonH = 30;
    float fStartButtonX = fScreenW/2-fStartButtonW/2;
    float fStartButtonY = fRtmpUrlTextFieldY+fRtmpUrlTextFieldH+10;
    _StartButton = [[UIButton alloc] initWithFrame:CGRectMake(fStartButtonX, fStartButtonY, fStartButtonW, fStartButtonH)];
    _StartButton.backgroundColor = [UIColor blueColor];
    _StartButton.layer.masksToBounds = YES;
    _StartButton.layer.cornerRadius  = 5;
    [_StartButton setTitle:@"开始直播" forState:UIControlStateNormal];
    [_StartButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _StartButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:10];
    [_StartButton addTarget:self action:@selector(OnStartLiveClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_StartButton];
    
#define M_DEBUG
#ifdef M_DEBUG
    _videoSizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 100, 30)];
    _videoSizeLabel.text = @"分辨率(CIF,720P):";
    _videoSizeLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    [self.view addSubview: _videoSizeLabel];
    
    fhorizontalSwitchX = 10 + 55 + 5+40;
    fhorizontalSwitchY = 100;
    fhorizontalSwitchW = 30;
    fhorizontalSwitchH = 30;
    _videoSizeSwitch = [[ZJSwitch alloc] initWithFrame:CGRectMake(fhorizontalSwitchX, fhorizontalSwitchY, fhorizontalSwitchW, fhorizontalSwitchH)];
    [self.view addSubview:_videoSizeSwitch];

    NSLog(@"mmmmmmmmmm");
#endif
    
}

-(void)OnStartLiveClicked:(id)sender{
    NSLog(@"Start live Rtmp:%@", _RtmpUrlTextField.text);
    _LiveShowViewController = [[LiveShowViewController alloc] init];
    
    //[_LiveShowViewController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    _LiveShowViewController.RtmpUrl = [NSURL URLWithString:_RtmpUrlTextField.text];
    _LiveShowViewController.IsHorizontal = [_horizontalSwitch isOn];
    _LiveShowViewController.IsD1 = [_videoSizeSwitch isOn];
    
    [self presentViewController:_LiveShowViewController animated:YES completion:nil];
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return false;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self UIInit];
    
    //rtmp://pili-live-rtmp.qdtong.net/leju-live-2/faf0c4
    //_RtmpUrlTextField.text = @"rtmp://pili-publish.qdtong.net/leju-live-2/faf0c4?key=0d2f2ef7bfe40550&token=ejutest";
    _RtmpUrlTextField.text = @"rtmp://ossrs.net/live/eju1";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//隐藏键盘的方法
-(void)hidenKeyboard
{
    [_RtmpUrlTextField resignFirstResponder];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![_RtmpUrlTextField isExclusiveTouch]) {
        [_RtmpUrlTextField resignFirstResponder];
    }
}
@end
