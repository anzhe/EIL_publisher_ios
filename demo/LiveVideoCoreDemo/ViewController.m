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
    
    UILabel* _VideoBitRateLabel;
    UITextField* _VideoBitRateTextField;
}

-(void) UIInit{
    double fScreenW = [UIScreen mainScreen].bounds.size.width;
    float   beginY = 60;
    
    // 横竖屏
    {
        _horizontalLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, beginY, 55, 30)];
        _horizontalLabel.text = @"横屏拍摄:";
        _horizontalLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
        [self.view addSubview: _horizontalLabel];
        
        float fhorizontalSwitchX = 10 + 55 + 5 +40;
        float fhorizontalSwitchY = beginY;
        float fhorizontalSwitchW = 30;
        float fhorizontalSwitchH = 30;
        _horizontalSwitch = [[ZJSwitch alloc] initWithFrame:CGRectMake(fhorizontalSwitchX, fhorizontalSwitchY, fhorizontalSwitchW, fhorizontalSwitchH)];
        [self.view addSubview:_horizontalSwitch];
    }
    
    // 分辨率
    {
        _videoSizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, beginY+40, 100, 30)];
        _videoSizeLabel.text = @"分辨率(CIF,720P):";
        _videoSizeLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
        [self.view addSubview: _videoSizeLabel];
        
        float fhorizontalSwitchX = 10 + 55 + 5+40;
        float fhorizontalSwitchY = beginY+40;
        float fhorizontalSwitchW = 30;
        float fhorizontalSwitchH = 30;
        _videoSizeSwitch = [[ZJSwitch alloc] initWithFrame:CGRectMake(fhorizontalSwitchX, fhorizontalSwitchY, fhorizontalSwitchW, fhorizontalSwitchH)];
        [self.view addSubview:_videoSizeSwitch];
    }
    
    // 视频码率
    {
        _VideoBitRateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, beginY+40*2, 100, 30)];
        _VideoBitRateLabel.text = @"码率(100~3000):";
        _VideoBitRateLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
        [self.view addSubview: _VideoBitRateLabel];
        
        float fRtmpUrlTextFieldX = 10 + 55 + 5+40;
        float fRtmpUrlTextFieldY = beginY+40*2;
        float fRtmpUrlTextFieldW = 80;
        float fRtmpUrlTextFieldH = 30;
        _VideoBitRateTextField = [[UITextField alloc] initWithFrame:CGRectMake(fRtmpUrlTextFieldX, fRtmpUrlTextFieldY, fRtmpUrlTextFieldW, fRtmpUrlTextFieldH)];
        _VideoBitRateTextField.backgroundColor = [UIColor lightGrayColor];
        [_VideoBitRateTextField setTextColor:[UIColor whiteColor]];
        _VideoBitRateTextField.layer.masksToBounds = YES;
        _VideoBitRateTextField.layer.cornerRadius  = 5;
        _VideoBitRateTextField.returnKeyType = UIReturnKeyDone;
        _VideoBitRateTextField.delegate = self;
        [self.view addSubview:_VideoBitRateTextField];
    }
    
    // RTMP URL
    {
        float fRtmpUrlTextFieldX = 10;
        float fRtmpUrlTextFieldY = beginY+40*3;
        float fRtmpUrlTextFieldW = fScreenW-2*fRtmpUrlTextFieldX;
        float fRtmpUrlTextFieldH = 30;
        _RtmpUrlTextField = [[UITextField alloc] initWithFrame:CGRectMake(fRtmpUrlTextFieldX, fRtmpUrlTextFieldY, fRtmpUrlTextFieldW, fRtmpUrlTextFieldH)];
        _RtmpUrlTextField.backgroundColor = [UIColor lightGrayColor];
        [_RtmpUrlTextField setTextColor:[UIColor whiteColor]];
        _RtmpUrlTextField.layer.masksToBounds = YES;
        _RtmpUrlTextField.layer.cornerRadius  = 5;
        _RtmpUrlTextField.returnKeyType = UIReturnKeyDone;
        [self.view addSubview:_RtmpUrlTextField];
    }
    
    // 开始直播
    {
        float fRtmpUrlTextFieldX = 10;
        float fRtmpUrlTextFieldY = beginY+40*4;
        float fRtmpUrlTextFieldH = 30;
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
    }
    
    NSLog(@"UIInit...");
    
}

-(void)OnStartLiveClicked:(id)sender{
    NSLog(@"Start live Rtmp:%@", _RtmpUrlTextField.text);
    
    if([_RtmpUrlTextField.text length] == 0)
        return;
    
    _LiveShowViewController = [[LiveShowViewController alloc] init];
    
    //[_LiveShowViewController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    _LiveShowViewController.RtmpUrl = [NSURL URLWithString:_RtmpUrlTextField.text];
    _LiveShowViewController.IsHorizontal = [_horizontalSwitch isOn];
    _LiveShowViewController.IsD1 = [_videoSizeSwitch isOn];
    
    NSString * strBitRate = _VideoBitRateTextField.text;
    _LiveShowViewController.fVideoBitRate = [strBitRate intValue];
    
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
    //_RtmpUrlTextField.text = @"rtmp://pili-publish.qdtong.net/leju-live-2/07f8ff?key=956bd6c19d30f94e&token=ejutest";
    _RtmpUrlTextField.text = @"rtmp://ossrs.net/live/mao1";
    //_RtmpUrlTextField.text = @"rtmp://10.0.60.65:1935/live/159";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//隐藏键盘的方法
-(void)hidenKeyboard
{
    [_RtmpUrlTextField resignFirstResponder];
    [_VideoBitRateTextField resignFirstResponder];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![_RtmpUrlTextField isExclusiveTouch]) {
        [_RtmpUrlTextField resignFirstResponder];
    }
    if (![_VideoBitRateTextField isExclusiveTouch]) {
        [_VideoBitRateTextField resignFirstResponder];
    }
}

#pragma mark - UITextField限制输入数字
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if(textField == _VideoBitRateTextField){
        return [self validateNumber:string];
    }
    return YES;
}

#pragma mark - 验证是否是纯数字
- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet *tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            NSLog(@"请输入数字");
            break;
        }
        i++;
    }
    return res;
}

@end
