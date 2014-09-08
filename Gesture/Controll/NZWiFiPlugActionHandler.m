//
//  NZWiFiPlugActionHandler.m
//  Gesture
//
//  Created by Natalia Zarawska on 9/5/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZWiFiPlugActionHandler.h"

#import <Protocol/CMDFF_ServerException.h>
#import <Protocol/CMDFB_ServerIdle.h>
#import <Protocol/CMDFE_Idle.h>
#import <Protocol/CMD00_ConnectRequet.h>
#import <Protocol/CMD01_ServerLoginPermit.h>
#import <Protocol/CMD02_Login.h>
#import <Protocol/CMD03_ServerLoginRespond.h>
#import <Protocol/CMD04_GetAllDeviceList.h>
#import <Protocol/CMD05_ServerRespondAllDeviceList.h>
#import <Protocol/CMD06_QueryDeviceStatus.h>
#import <Protocol/CMD07_ServerRespondDeviceStatus.h>
#import <Protocol/CMD08_ControlDevice.h>
#import <Protocol/CMD09_ServerControlResult.h>
#import <Protocol/DeviceStatus.h>
#import <Protocol/Device.h>

@interface NZWiFiPlugActionHandler()

@property BOOL executingAction;
@property (nonatomic, retain) DeviceStatus *device;

@end

@implementation NZWiFiPlugActionHandler

@synthesize action = _action;

- (id)initWithAction:(NZWiFiPlugAction *)action
{
    self = [super init];
    if (self) {
        self.action = action;
    }
    return self;
}

- (void)execute
{
    NSLog(@"EXECUTING!!!!!!");
    self.executingAction = true;
    [self.action execute];
    // turn on/off
    NZWiFiPlugAction *wifiAction = (NZWiFiPlugAction *)self.action;
    /*CMD06_QueryDeviceStatus *cmd06 = [[CMD06_QueryDeviceStatus alloc] initWithDevid:wifiAction.plugId];
    [[CMDHelper shareInstance] sendCMD:cmd06];*/
    
    [self getAllDevices];
    // get info about the current status...
}

- (void)connect
{
    if (!self.action) {
        NSLog(@"there is no action set to handle");
        return;
    }
    NZWiFiPlugAction *wifiPlugAction = (NZWiFiPlugAction *)self.action;
    CMDHelper *helper = [CMDHelper shareInstance];
    helper.delegate = self;
    [CMDHelper setupConnectionWithIp:wifiPlugAction.hostName Port:[wifiPlugAction.portNumber intValue]];
    CMD00_ConnectRequet *cmd00 = [[CMD00_ConnectRequet alloc] init];
    [helper sendCMD:cmd00];
}

- (void)login
{
    if (!self.action) {
        NSLog(@"there is no action set to handle");
        return;
    }
    NZWiFiPlugAction *wifiPlugAction = (NZWiFiPlugAction *)self.action;
    CMD02_Login *cmd02 = [[CMD02_Login alloc] initWithUser:wifiPlugAction.username Pass:wifiPlugAction.password Offset:0 appid:0];
    [[CMDHelper shareInstance] sendCMD:cmd02];
}

- (void)getAllDevices
{
    CMD04_GetAllDeviceList *cmd04 = [[CMD04_GetAllDeviceList alloc] init];
    [[CMDHelper shareInstance] sendCMD:cmd04];
}

- (void)receivedDevices:(NSArray *)deviceList
{
    // extract my plug
    
    if (!self.action && ![self.action isKindOfClass:[NZWiFiPlugAction class]]) {
        return;
    }
    NZWiFiPlugAction *wifiPlugAction = (NZWiFiPlugAction *)self.action;
    for (Device *device in deviceList) {
        if ([device.name isEqualToString:wifiPlugAction.plugName]) {
            //if ([device isKindOfClass:[DeviceStatus class]]) {
                DeviceStatus *devStatus = (DeviceStatus *)device;
                self.device = devStatus;
                [self.device setOneWayPower:![self.device getOneWayPower]];
                CMD08_ControlDevice *cmd08 = [[CMD08_ControlDevice alloc] initWithStatus:self.device];
                [[CMDHelper shareInstance] sendCMD:cmd08];
          //  }
        }
    }
}

- (void)didReceiveDeviceStatus
{
    if (self.executingAction) {
        //[self.device setOneWayPower:![self.device getOneWayPower]];
        CMD08_ControlDevice *cmd08 = [[CMD08_ControlDevice alloc] initWithStatus:self.device];
        [[CMDHelper shareInstance] sendCMD:cmd08];
    }
}

- (void)didConnect
{
    for (id<NZActionHandlerObserver> observer in self.observers) {
        if ([observer respondsToSelector:@selector(actionHandlerDidConnectAction:)]) {
            [observer actionHandlerDidConnectAction:self.action];
        }
    }
}

- (void)didFinishExecution
{
    self.executingAction = false;
    for (id<NZActionHandlerObserver> observer in self.observers) {
        if ([observer respondsToSelector:@selector(actionHandlerDidFinishExecutionOfAction:)]) {
            [observer actionHandlerDidFinishExecutionOfAction:self.action];
        }
    }
}

- (void)didDisconnect
{
    
    for (id<NZActionHandlerObserver> observer in self.observers) {
        if ([observer respondsToSelector:@selector(action:disconnectedWithErrorMessage:)]) {
            [observer action:self.action disconnectedWithErrorMessage:@"disconnected..."];
        }
    }
}

#pragma mark - CMDHelper delegate methods
-(void)receiveCMD:(ServerCommand*)cmd
{
    NSLog(@"received respond: %@", cmd);
    if (cmd->CommandNo == [CMD01_ServerLoginPermit commandConst]) {
        NSLog(@"login permit key: %@", ((CMD01_ServerLoginPermit *)cmd).key );
        [self login];
    } else if (cmd->CommandNo == [CMD03_ServerLoginRespond commandConst]) {
        NSLog(@"result: %d", ((CMD03_ServerLoginRespond *)cmd).result);
        NSLog(@"User Info: %@", ((CMD03_ServerLoginRespond *)cmd).info);
        BOOL res = ((CMD03_ServerLoginRespond *)cmd).result;
        if (res) {
            NSLog(@"plug did connect");
            [self didConnect];
        }
    } else if (cmd->CommandNo == [CMD05_ServerRespondAllDeviceList commandConst]) {
        [self receivedDevices:((CMD05_ServerRespondAllDeviceList *)cmd).deviceList];
    } else if (cmd->CommandNo == [CMD07_ServerRespondDeviceStatus commandConst]) {
        NSLog(@"received device status");
        Device *dev = ((CMD07_ServerRespondDeviceStatus *)cmd).status;
        if ([dev isKindOfClass:[DeviceStatus class]]) {
            self.device = (DeviceStatus *)dev;
            [self didReceiveDeviceStatus];
        }
    } else if (cmd->CommandNo == [CMD09_ServerControlResult commandConst]) {
        NSLog(@"changed status?!");
        [self didFinishExecution];
    } else if (cmd->CommandNo == [CMDFF_ServerException commandConst]) {
        NSLog(@"error message from server");
    } else if (cmd->CommandNo == [CMDFB_ServerIdle commandConst]){
        NSLog(@"server is idle");
    } else {
        NSLog(@"---");
        NSLog(@"received command: %@", cmd);
        NSLog(@"---");
    }
}

-(void)socketConnected
{
    NSLog(@"socket connected:%d", [[CMDHelper shareInstance] isConnected]);
  //  [self login];
}

-(void)socketClosed
{
    NSLog(@"socked closed");
    // reconnect
    NSLog(@"try to reconnect");
    [self connect];
    //[CMDHelper setupConnectionWithIp:@"ec2-54-217-214-117.eu-west-1.compute.amazonaws.com" Port:227];
    
}

-(void)socketWriteSucc
{
    NSLog(@"socked write succ!");
}


#pragma mark - getters and setters

/**
 * overriding the setter to allow the subclass NZWiFiPlugAction
 * its a fast solution for now..
 */
- (void)setAction:(NZAction *)action
{
    if ([action isKindOfClass:[NZWiFiPlugAction class]]) {
        _action = action;
    } else {
        NSLog(@"trying to assigne %@ to action in the NZWiFiActionHandler",[action class]);
    }
}

@end
