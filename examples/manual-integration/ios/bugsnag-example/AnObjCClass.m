#import "AnObjCClass.h"
#import "bugsnag_example-Swift.h"

@implementation AnObjCClass

- (void)makeAStackTrace:(AnotherClass *)other {
    [self bounce:other];
}

- (void)bounce:(AnotherClass *)other {
    [other crash3];
}

@end
