
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "VCSimpleSession.h"

#define LIVE_VIDEO_DEF_WIDTH  360
#define LIVE_VIDEO_DEF_HEIGHT 640
#define LIVE_VIDEO_DEF_FRAMERATE 15
#define LIVE_VIDEO_DEF_BITRATE   500000

#define LIVE_VIEDO_SIZE_HORIZONTAL_CIF  (CGSizeMake(640, 360))
#define LIVE_VIEDO_SIZE_HORIZONTAL_D1   (CGSizeMake(960, 540))
#define LIVE_VIEDO_SIZE_HORIZONTAL_720P (CGSizeMake(1280, 720))

#define LIVE_VIEDO_SIZE_SMALL_CIF  (CGSizeMake(180, 320))
#define LIVE_VIEDO_SIZE_CIF  (CGSizeMake(360, 640))
#define LIVE_VIEDO_SIZE_D1   (CGSizeMake(540, 960))
#define LIVE_VIEDO_SIZE_720P (CGSizeMake(720, 1280))

typedef NS_ENUM(NSUInteger, LIVE_BITRATE) {
    LIVE_BITRATE_1Mbps=1500000,
    LIVE_BITRATE_800Kbps=800000,
    LIVE_BITRATE_600Kbps=600000,
    LIVE_BITRATE_300Kbps=300000
};

typedef NS_ENUM(NSUInteger, LIVE_FRAMERATE) {
    LIVE_FRAMERATE_30=30,
    LIVE_FRAMERATE_25=25,
    LIVE_FRAMERATE_20=20,
    LIVE_FRAMERATE_15=15
};

typedef NS_ENUM(NSInteger, LIVE_VCSessionState)
{
    LIVE_VCSessionStateNone,
    LIVE_VCSessionStatePreviewStarted,
    LIVE_VCSessionStateStarting,
    LIVE_VCSessionStateStarted,
    LIVE_VCSessionStateEnded,
    LIVE_VCSessionStateError
};

typedef NS_ENUM(NSUInteger, LIVE_FILTER_TYPE) {
    LIVE_FILTER_ORIGINAL,
    LIVE_FILTER_BEAUTY,
    LIVE_FILTER_ANTIQUE,
    LIVE_FILTER_BLACK
};

@protocol LIVEVCSessionDelegate <NSObject>
@required
- (void) LiveConnectionStatusChanged: (LIVE_VCSessionState) sessionState;
@end

@interface LiveVideoCoreSDK : NSObject<VCSessionDelegate>

+ (instancetype)sharedinstance;

@property (nonatomic, weak)   id<LIVEVCSessionDelegate> delegate;
@property (atomic, assign) float micGain;//0~1.0

- (void)EILLiveInit:(UIView*)previewView;
- (void)EILLiveInit:(NSURL*)rtmpUrl Preview:(UIView*)previewView;
- (void)EILLiveInit:(NSURL*)rtmpUrl Preview:(UIView*)previewView VideSize:(CGSize)videSize BitRate:(LIVE_BITRATE)iBitRate FrameRate:(LIVE_FRAMERATE)iFrameRate  highQuality:(Boolean)bhighQuality;

- (void)EILLiveRelease;

- (void)EILConnect:(NSURL*)rtmpUrl;
- (void)EILConnect;
- (void)EILDisconnect;

- (void)EILSetCameraFront:(Boolean)bCameraFrontFlag;
- (void)EILSetFilter:(LIVE_FILTER_TYPE) type;

- (void)EILFocuxAtPoint:(CGPoint)point;
//VCSessionDelegate protocal
- (void) connectionStatusChanged: (VCSessionState) sessionState;

@end
