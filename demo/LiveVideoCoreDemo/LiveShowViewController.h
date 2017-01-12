//
//  LiveShowViewController.h
//  LiveVideoCoreDemo
//
//  Created by Alex.Shi on 16/3/2.
//  Copyright © 2016年 com.Alex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EILPublisher.h"
#import "ASValueTrackingSlider.h"

@interface LiveShowViewController : UIViewController<LIVEVCSessionDelegate, ASValueTrackingSliderDataSource, ASValueTrackingSliderDelegate>

@property (atomic, copy) NSURL* RtmpUrl;
@property (atomic, assign) Boolean IsHorizontal;
@property (atomic, assign) int fVideoSize;
@property (atomic, assign) Boolean IsD1;
@property (atomic, assign) Boolean bNetworkStrategy;
@property (atomic, assign) int fVideoBitRate;


- (void) LiveConnectionStatusChanged: (LIVE_VCSessionState) sessionState;

@end
