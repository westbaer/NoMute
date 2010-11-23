#import <objc/runtime.h>

%hook SpringBoard

- (void)ringerChanged:(int)y {
	id d = [objc_getClass("SBOrientationLockManager") sharedInstance];
	
	if(y == 0) {
		[d lock];
		if(![d lockOverride]) {
			[d setLockOverride:1 orientation:[d lockOrientation]];
		}
	} else {
		[d unlock];
		if(![d lockOverride]) {
			[d updateLockOverrideForCurrentDeviceOrientation];
		}
	}
}

%end