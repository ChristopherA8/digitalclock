#import <Cephei/HBPreferences.h>

static HBPreferences *preferences;

static NSString *iconColor;
static NSString *hourColor;
static NSString *minuteColor;
static NSString *amPmColor;

@interface SBClockApplicationIconImageView : UIView // : SBHClockApplicationIconImageView <SBDateTimeOverrideObserver>
@property (readonly, copy) NSString *debugDescription;
@property (readonly, copy) NSString *description;
@property (readonly) Class superclass;
// %property
@property (nonatomic, retain) UILabel *test;
@property (nonatomic, retain) UILabel *test2;
@property (nonatomic, retain) UILabel *words;

+ (void)initialize;  
- (void)controller:(id)arg1 didChangeOverrideDateFromDate:(id)arg2;
- (void)setIcon:(id)arg1 location:(id)arg2 animated:(bool)arg3;
// %new
-(void)startTimer;
-(void)updateTime;

@end

@interface DigitalClockView : UIView
@end