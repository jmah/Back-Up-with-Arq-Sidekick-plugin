//
//  JSMBackUpWithArqAction.m
//  Back Up with Arq
//
//  Created by Jonathon Mah on 2012-04-15.
//

#import "JSMBackUpWithArqAction.h"


@protocol JSMMinimalArqAgentService <NSObject>
- (BOOL)agentIsBusy;
- (void)backUpNowImmediate;
@end


@implementation JSMBackUpWithArqAction

#pragma mark SKAction

+ (NSString *)actionID;
{ return NSStringFromClass([JSMBackUpWithArqAction class]); }

+ (BOOL)allowsMultipleInstances;
{ return NO; }

+ (NSString *)title;
{
    return NSLocalizedString(@"Back Up with Arq", @"Action title");
}

+ (NSImage *)icon;
{
    NSString *arqAppPath = [[NSWorkspace sharedWorkspace] absolutePathForAppBundleWithIdentifier:@"com.haystacksoftware.arq"];
    if (!arqAppPath)
        return [NSImage imageNamed:@"NSDefaultApplicationIcon"];
    return [[NSWorkspace sharedWorkspace] iconForFile:arqAppPath];
}

- (void)performAction;
{
    NSString *arqAgentRegisteredName = [NSString stringWithFormat:@"ArqAgent-%@", NSUserName()];
    @try {
        NSDistantObject *remoteAgentProxy = (id)[NSConnection rootProxyForConnectionWithRegisteredName:arqAgentRegisteredName host:nil];
        [remoteAgentProxy setProtocolForProxy:@protocol(JSMMinimalArqAgentService)];
        id<JSMMinimalArqAgentService> remoteAgent = (id)remoteAgentProxy;
        if (!remoteAgent.agentIsBusy)
            [remoteAgent backUpNowImmediate];
    }
    @catch (id ex) {
        NSLog(@"%s caught %@", __func__, ex);
    }
}

@end
