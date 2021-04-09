#import "UIView+SmoothCorners.h"
#import "UIColor+Hex.h"
#import "Tweak.h"

@implementation DigitalClockView
@end

%hook SBClockApplicationIconImageView

%property (nonatomic, retain) UILabel *test;
%property (nonatomic, retain) UILabel *test2;
%property (nonatomic, retain) UILabel *words;

%new
-(void)startTimer {

	NSLog(@"startTimer");
	NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
	[[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

%new
-(void)updateTime {

	NSDate *now;
	NSDateFormatter *hourFormat;
	NSDateFormatter *minutesFormat;
	NSDateFormatter *amPm;


	amPm = [[NSDateFormatter alloc] init];
	amPm.dateStyle = NSDateFormatterMediumStyle;
	amPm.timeStyle = NSDateFormatterNoStyle;
	[amPm setDateFormat:@"a"];
	amPm.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];

	now = [NSDate date];
	hourFormat = [[NSDateFormatter alloc] init];
	//Add option for 24 hour or 12 hour time      HH = 24hr     hh = 12hr
	if (militaryTime) {
		[hourFormat setDateFormat:@"HH"];
	} else {
		[hourFormat setDateFormat:@"hh"];
	}
	minutesFormat = [[NSDateFormatter alloc] init];
	[minutesFormat setDateFormat:@"mm"];

	self.test.text = [hourFormat stringFromDate:now];
	self.test2.text = [minutesFormat stringFromDate:now];

	// NSLog(@"%@", [minutesFormat stringFromDate:now]);

	if ([[amPm stringFromDate:now] containsString:@"P"]) {
		self.words.text = @"P\nM";
	} else {
		self.words.text = @"A\nM";
	}

	now = nil;
	amPm = nil;
	minutesFormat = nil;
	hourFormat = nil;


}

- (void)setIcon:(id)arg1 location:(id)arg2 animated:(bool)arg3 {
	%orig;

	if (!enabled) return;

	if ([[self subviews] count] > 0) return;

	/* Date */
	NSDate *now = [NSDate date];
	NSDateFormatter *hourFormat = [[NSDateFormatter alloc] init];
	//Add option for 24 hour or 12 hour time      HH = 24hr     hh = 12hr
	if (militaryTime) {
		[hourFormat setDateFormat:@"HH"];
	} else {
		[hourFormat setDateFormat:@"hh"];
	}
	NSDateFormatter *minutesFormat = [[NSDateFormatter alloc] init];
	[minutesFormat setDateFormat:@"mm"];

	NSDateFormatter *amPm = [[NSDateFormatter alloc] init];
	amPm.dateStyle = NSDateFormatterMediumStyle;
	amPm.timeStyle = NSDateFormatterNoStyle;
	[amPm setDateFormat:@"a"];
	amPm.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
	/*      */
		
	DigitalClockView *digiView = [[DigitalClockView alloc] initWithFrame:self.frame];
	digiView.backgroundColor = [UIColor pf_colorWithHexString:iconColor alpha:1.0];
	// digiView.backgroundColor = UIColor.whiteColor;
	digiView.layer.cornerRadius = [preferences integerForKey:@"cornerRadius"] ? ((float)[preferences integerForKey:@"cornerRadius"] + 0.5) : 13.5;
	digiView.flx_continuousCorners = YES;
	digiView.layer.zPosition = 1;

	UIStackView *iconStack = [[UIStackView alloc] initWithFrame:self.frame];
	iconStack.axis = UILayoutConstraintAxisHorizontal;
	iconStack.layoutMargins = UIEdgeInsetsMake(5,5,5,2);
	iconStack.layoutMarginsRelativeArrangement = YES;
	iconStack.distribution = UIStackViewDistributionFillEqually;

	UIStackView *timeStack = [[UIStackView alloc] init];
	timeStack.axis = UILayoutConstraintAxisVertical;
	timeStack.layoutMargins = UIEdgeInsetsMake(0,0,0,0);
	timeStack.layoutMarginsRelativeArrangement = YES;
	timeStack.distribution = UIStackViewDistributionFillEqually;

	self.words = [[UILabel alloc] init];
	if ([[amPm stringFromDate:now] containsString:@"P"]) {
		self.words.text = @"P\nM";
	} else {
		self.words.text = @"A\nM";
	}
	self.words.textAlignment = NSTextAlignmentCenter;
	self.words.numberOfLines = 2;
	self.words.textColor = [UIColor pf_colorWithHexString:amPmColor alpha:1.0];
	if (@available(iOS 14, *)) {
		self.words.font = [UIFont monospacedSystemFontOfSize:20.0 weight:UIFontWeightBold];
	}

	self.test = [[UILabel alloc] init];
	self.test.text = [hourFormat stringFromDate:now];
	self.test.textAlignment = NSTextAlignmentCenter;
	self.test.numberOfLines = 1;
	self.test.textColor = [UIColor pf_colorWithHexString:hourColor alpha:1.0];
	if (@available(iOS 14, *)) {
		self.test.font = [UIFont monospacedSystemFontOfSize:20.0 weight:UIFontWeightBold];
	}

	self.test2 = [[UILabel alloc] init];
	self.test2.text = [minutesFormat stringFromDate:now];
	self.test2.textAlignment = NSTextAlignmentCenter;
	self.test2.numberOfLines = 1;
	self.test2.textColor = [UIColor pf_colorWithHexString:minuteColor alpha:1.0];
	if (@available(iOS 14, *)) {
		self.test2.font = [UIFont monospacedSystemFontOfSize:20.0 weight:UIFontWeightBold];
	}

	[iconStack addArrangedSubview:timeStack];
	[iconStack addArrangedSubview:self.words];

	[timeStack addArrangedSubview:self.test];
	[timeStack addArrangedSubview:self.test2];

	[digiView addSubview:iconStack];
	[self addSubview:digiView];

	[self startTimer];

}

%end

@interface SpringBoard
-(void)applicationDidFinishLaunching:(id)arg1;
@end

// %hook SpringBoard
// -(void)applicationDidFinishLaunching:(id)arg1 {
// 	%orig;

// 	NSDateFormatter *localTime = [[NSDateFormatter alloc] init];
// 	localTime.dateStyle = NSDateFormatterMediumStyle;
// 	localTime.timeStyle = NSDateFormatterNoStyle;
// 	[localTime setDateFormat:@"a"];

// 	NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
// 	timeFormatter.dateStyle = NSDateFormatterMediumStyle;
// 	timeFormatter.timeStyle = NSDateFormatterNoStyle;
// 	[timeFormatter setDateFormat:@"a"];
// 	timeFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];

// 	NSDate *date = [NSDate date];
// 	// NSLog(@"%@", [enTime descriptionWithLocale:[NSLocale localeWithLocaleIdentifier:@"en_US"]]);

// 	NSString *message = [NSString stringWithFormat:@"en_US: %@\nlocal: %@", [timeFormatter stringFromDate:date], [localTime stringFromDate:date]];
	
// 	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"↓↓ This should say 'PM' ↓↓"
// 										message:message 
// 										delegate:self 
// 										cancelButtonTitle:@"OK" 
// 										otherButtonTitles:nil];
// 	[alert show];

// }
// %end



%ctor {
	NSLog(@"DigitalClock.dylib loaded");
	preferences = [[HBPreferences alloc] initWithIdentifier:@"com.chr1s.digitalclockprefs"];
	// [preferences registerInteger:&radius default:13 forKey:@"cornerRadius"];
	[preferences registerBool:&enabled default:YES forKey:@"enabled"];
	[preferences registerBool:&militaryTime default:NO forKey:@"militaryTime"];
	[preferences registerObject:&iconColor default:@"#FFFFFF" forKey:@"iconColor"];
	[preferences registerObject:&hourColor default:@"#000000" forKey:@"hourColor"];
	[preferences registerObject:&minuteColor default:@"#FF2D55" forKey:@"minuteColor"];
	[preferences registerObject:&amPmColor default:@"#FF2D55" forKey:@"amPmColor"];
}