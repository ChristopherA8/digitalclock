#line 1 "Tweak.xm"
#import "UIView+SmoothCorners.h"
#import "UIColor+Hex.h"
#import "Tweak.h"

@implementation DigitalClockView
@end


#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class SBClockApplicationIconImageView; 
static void _logos_method$_ungrouped$SBClockApplicationIconImageView$startTimer(_LOGOS_SELF_TYPE_NORMAL SBClockApplicationIconImageView* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$SBClockApplicationIconImageView$updateTime(_LOGOS_SELF_TYPE_NORMAL SBClockApplicationIconImageView* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$SBClockApplicationIconImageView$setIcon$location$animated$)(_LOGOS_SELF_TYPE_NORMAL SBClockApplicationIconImageView* _LOGOS_SELF_CONST, SEL, id, id, bool); static void _logos_method$_ungrouped$SBClockApplicationIconImageView$setIcon$location$animated$(_LOGOS_SELF_TYPE_NORMAL SBClockApplicationIconImageView* _LOGOS_SELF_CONST, SEL, id, id, bool); 

#line 8 "Tweak.xm"


__attribute__((used)) static UILabel * _logos_method$_ungrouped$SBClockApplicationIconImageView$test(SBClockApplicationIconImageView * __unused self, SEL __unused _cmd) { return (UILabel *)objc_getAssociatedObject(self, (void *)_logos_method$_ungrouped$SBClockApplicationIconImageView$test); }; __attribute__((used)) static void _logos_method$_ungrouped$SBClockApplicationIconImageView$setTest(SBClockApplicationIconImageView * __unused self, SEL __unused _cmd, UILabel * rawValue) { objc_setAssociatedObject(self, (void *)_logos_method$_ungrouped$SBClockApplicationIconImageView$test, rawValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
__attribute__((used)) static UILabel * _logos_method$_ungrouped$SBClockApplicationIconImageView$test2(SBClockApplicationIconImageView * __unused self, SEL __unused _cmd) { return (UILabel *)objc_getAssociatedObject(self, (void *)_logos_method$_ungrouped$SBClockApplicationIconImageView$test2); }; __attribute__((used)) static void _logos_method$_ungrouped$SBClockApplicationIconImageView$setTest2(SBClockApplicationIconImageView * __unused self, SEL __unused _cmd, UILabel * rawValue) { objc_setAssociatedObject(self, (void *)_logos_method$_ungrouped$SBClockApplicationIconImageView$test2, rawValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
__attribute__((used)) static UILabel * _logos_method$_ungrouped$SBClockApplicationIconImageView$words(SBClockApplicationIconImageView * __unused self, SEL __unused _cmd) { return (UILabel *)objc_getAssociatedObject(self, (void *)_logos_method$_ungrouped$SBClockApplicationIconImageView$words); }; __attribute__((used)) static void _logos_method$_ungrouped$SBClockApplicationIconImageView$setWords(SBClockApplicationIconImageView * __unused self, SEL __unused _cmd, UILabel * rawValue) { objc_setAssociatedObject(self, (void *)_logos_method$_ungrouped$SBClockApplicationIconImageView$words, rawValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }


static void _logos_method$_ungrouped$SBClockApplicationIconImageView$startTimer(_LOGOS_SELF_TYPE_NORMAL SBClockApplicationIconImageView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {

	NSLog(@"startTimer");
	NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
	[[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}


static void _logos_method$_ungrouped$SBClockApplicationIconImageView$updateTime(_LOGOS_SELF_TYPE_NORMAL SBClockApplicationIconImageView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {

	NSDate *now;
	NSDateFormatter *hourFormat;
	NSDateFormatter *minutesFormat;
	NSDateFormatter *amPm;

	amPm = [[NSDateFormatter alloc] init];
	[amPm setDateFormat:@"a"];
	now = [NSDate date];
	hourFormat = [[NSDateFormatter alloc] init];
	
	[hourFormat setDateFormat:@"hh"];
	minutesFormat = [[NSDateFormatter alloc] init];
	[minutesFormat setDateFormat:@"mm"];

	self.test.text = [hourFormat stringFromDate:now];
	self.test2.text = [minutesFormat stringFromDate:now];

	

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

static void _logos_method$_ungrouped$SBClockApplicationIconImageView$setIcon$location$animated$(_LOGOS_SELF_TYPE_NORMAL SBClockApplicationIconImageView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2, bool arg3) {
	_logos_orig$_ungrouped$SBClockApplicationIconImageView$setIcon$location$animated$(self, _cmd, arg1, arg2, arg3);

	if (![preferences boolForKey:@"enabled"]) return;

	if ([[self subviews] count] > 0) return;

	
	NSDate *now = [NSDate date];
	NSDateFormatter *hourFormat = [[NSDateFormatter alloc] init];
	
	[hourFormat setDateFormat:@"hh"];
	NSDateFormatter *minutesFormat = [[NSDateFormatter alloc] init];
	[minutesFormat setDateFormat:@"mm"];
	NSDateFormatter *amPm = [[NSDateFormatter alloc] init];
	[amPm setDateFormat:@"a"];
	
		
	DigitalClockView *digiView = [[DigitalClockView alloc] initWithFrame:self.frame];
	digiView.backgroundColor = [UIColor pf_colorWithHexString:iconColor alpha:1.0];
	
	digiView.layer.cornerRadius = 13.5;
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



static __attribute__((constructor)) void _logosLocalCtor_4ce779b0(int __unused argc, char __unused **argv, char __unused **envp) {
	NSLog(@"DigitalClock.dylib loaded");
	preferences = [[HBPreferences alloc] initWithIdentifier:@"com.chr1s.digitalclockprefs"];
	[preferences registerObject:&iconColor default:@"#FFFFFF" forKey:@"iconColor"];
	[preferences registerObject:&hourColor default:@"#000000" forKey:@"hourColor"];
	[preferences registerObject:&minuteColor default:@"#FF2D55" forKey:@"minuteColor"];
	[preferences registerObject:&amPmColor default:@"#FF2D55" forKey:@"amPmColor"];
}
static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$SBClockApplicationIconImageView = objc_getClass("SBClockApplicationIconImageView"); { char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$SBClockApplicationIconImageView, @selector(startTimer), (IMP)&_logos_method$_ungrouped$SBClockApplicationIconImageView$startTimer, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$SBClockApplicationIconImageView, @selector(updateTime), (IMP)&_logos_method$_ungrouped$SBClockApplicationIconImageView$updateTime, _typeEncoding); }{ MSHookMessageEx(_logos_class$_ungrouped$SBClockApplicationIconImageView, @selector(setIcon:location:animated:), (IMP)&_logos_method$_ungrouped$SBClockApplicationIconImageView$setIcon$location$animated$, (IMP*)&_logos_orig$_ungrouped$SBClockApplicationIconImageView$setIcon$location$animated$);}{ char _typeEncoding[1024]; sprintf(_typeEncoding, "%s@:", @encode(UILabel *)); class_addMethod(_logos_class$_ungrouped$SBClockApplicationIconImageView, @selector(test), (IMP)&_logos_method$_ungrouped$SBClockApplicationIconImageView$test, _typeEncoding); sprintf(_typeEncoding, "v@:%s", @encode(UILabel *)); class_addMethod(_logos_class$_ungrouped$SBClockApplicationIconImageView, @selector(setTest:), (IMP)&_logos_method$_ungrouped$SBClockApplicationIconImageView$setTest, _typeEncoding); } { char _typeEncoding[1024]; sprintf(_typeEncoding, "%s@:", @encode(UILabel *)); class_addMethod(_logos_class$_ungrouped$SBClockApplicationIconImageView, @selector(test2), (IMP)&_logos_method$_ungrouped$SBClockApplicationIconImageView$test2, _typeEncoding); sprintf(_typeEncoding, "v@:%s", @encode(UILabel *)); class_addMethod(_logos_class$_ungrouped$SBClockApplicationIconImageView, @selector(setTest2:), (IMP)&_logos_method$_ungrouped$SBClockApplicationIconImageView$setTest2, _typeEncoding); } { char _typeEncoding[1024]; sprintf(_typeEncoding, "%s@:", @encode(UILabel *)); class_addMethod(_logos_class$_ungrouped$SBClockApplicationIconImageView, @selector(words), (IMP)&_logos_method$_ungrouped$SBClockApplicationIconImageView$words, _typeEncoding); sprintf(_typeEncoding, "v@:%s", @encode(UILabel *)); class_addMethod(_logos_class$_ungrouped$SBClockApplicationIconImageView, @selector(setWords:), (IMP)&_logos_method$_ungrouped$SBClockApplicationIconImageView$setWords, _typeEncoding); } } }
#line 149 "Tweak.xm"
