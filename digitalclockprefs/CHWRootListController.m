#include "CHWRootListController.h"

@implementation CHWRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}
	((UITableView *)[self table]).keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;

	return _specifiers;
}

-(void)_returnKeyPressed:(id)arg1 {
	// Dismiss keyboard when return key pressed
	[self.view endEditing:YES];
}

-(void)respring {
	[HBRespringController respring];
}

-(void)discord {
	NSURL *discord = [NSURL URLWithString:@"https://discord.gg/zHN7yuGqYr"];
	[[UIApplication sharedApplication] openURL:discord options:@{} completionHandler:nil];
}

-(void)paypal {
	NSURL *paypal = [NSURL URLWithString:@"https://paypal.me/chr1sdev"];
	[[UIApplication sharedApplication] openURL:paypal options:@{} completionHandler:nil];
}

@end
