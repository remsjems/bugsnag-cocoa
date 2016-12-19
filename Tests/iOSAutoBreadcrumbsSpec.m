#import <XCTest/XCTest.h>
#import <Kiwi/Kiwi.h>

#import "Bugsnag.h"
#import "BugsnagNotifier.h"
#import "BugsnagBreadcrumb.h"

@interface Bugsnag ()
+ (BugsnagNotifier*)notifier;
@end

SPEC_BEGIN(AutoBreadcrumbs)

beforeAll(^{
    [Bugsnag startBugsnagWithApiKey:@"My API key"];
});

beforeEach(^{
    [Bugsnag clearBreadcrumbs];
});

describe(@"orientation breadcrumbs", ^{

    it(@"creates a breadcrumb for orientation change", ^{
        [[UIDevice currentDevice] stub:@selector(orientation) withBlock:^id(NSArray *params) {
            return [KWValue valueWithInteger:UIDeviceOrientationFaceDown];
        }];
        [[NSNotificationCenter defaultCenter] postNotificationName:UIDeviceOrientationDidChangeNotification object:nil];
        BugsnagBreadcrumbs *crumbs = [Bugsnag notifier].configuration.breadcrumbs;
        [[@(crumbs.count) should] equal:@1];
        BugsnagBreadcrumb *crumb = crumbs[0];
        [[crumb.name should] equal:@"UIDeviceOrientationDidChange"];
        [[crumb.metadata should] equal:@{@"orientation": @"facedown"}];
    });

    it(@"does not duplicate breadcrumbs for same orientation", ^{
        [[UIDevice currentDevice] stub:@selector(orientation) withBlock:^id(NSArray *params) {
            return [KWValue valueWithInteger:UIDeviceOrientationFaceUp];
        }];
        [[NSNotificationCenter defaultCenter] postNotificationName:UIDeviceOrientationDidChangeNotification object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:UIDeviceOrientationDidChangeNotification object:nil];
        BugsnagBreadcrumbs *crumbs = [Bugsnag notifier].configuration.breadcrumbs;
        [[@(crumbs.count) should] equal:@1];
    });

    it(@"adds a new breadcrumb for each change", ^{
        [[UIDevice currentDevice] stub:@selector(orientation) withBlock:^id(NSArray *params) {
            return [KWValue valueWithInteger:UIDeviceOrientationPortrait];
        }];
        [[NSNotificationCenter defaultCenter] postNotificationName:UIDeviceOrientationDidChangeNotification object:nil];
        [[UIDevice currentDevice] stub:@selector(orientation) withBlock:^id(NSArray *params) {
            return [KWValue valueWithInteger:UIDeviceOrientationLandscapeLeft];
        }];
        [[NSNotificationCenter defaultCenter] postNotificationName:UIDeviceOrientationDidChangeNotification object:nil];
        BugsnagBreadcrumbs *crumbs = [Bugsnag notifier].configuration.breadcrumbs;
        [[@(crumbs.count) should] equal:@2];
    });
});

SPEC_END
