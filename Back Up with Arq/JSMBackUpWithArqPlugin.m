//
//  JSMBackUpWithArqPlugin.m
//  Back Up with Arq
//
//  Created by Jonathon Mah on 2012-04-15.
//  Copyright (c) 2012 Jonathon Mah. All rights reserved.
//

#import "JSMBackUpWithArqPlugin.h"

#import "JSMBackUpWithArqAction.h"


@implementation JSMBackUpWithArqPlugin

#pragma mark SKPlugin

- (NSArray *)actions;
{
    return [NSArray arrayWithObject:[JSMBackUpWithArqAction class]];
}

@end
