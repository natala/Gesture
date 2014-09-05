//
//  NZHttpRequest+Execute.m
//  Gesture
//
//  Created by Natalia Zarawska on 8/25/14.
//  Copyright (c) 2014 TUM. All rights reserved.
//

#import "NZWiFiPlugAction+Execute.h"

#import <Protocol/CMDFF_ServerException.h>
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


@implementation NZWiFiPlugAction (Execute)

- (void)execute
{
    NSLog(@"NZWiFiPlugAction - execute()");
}

- (void)prepareForExecution:(SEL)selector
{
    NSLog(@"preparing for execution");
    [self connect];
    
}

- (void)connect
{
    CMDHelper *helper = [CMDHelper shareInstance];
    helper.delegate = self;
        [CMDHelper setupConnectionWithIp:self.hostName Port:self.portNumber];
    CMD00_ConnectRequet *cmd00 = [[CMD00_ConnectRequet alloc] init];
    [helper sendCMD:cmd00];

}

- (void)login
{
    CMD02_Login *cmd02 = [[CMD02_Login alloc] initWithUser:self.username Pass:self.password Offset:0 appid:0];
    [[CMDHelper shareInstance] sendCMD:cmd02];
}

- (void)switchPlug
{
    CMD04_GetAllDeviceList *cmd04 = [[CMD04_GetAllDeviceList alloc] init];
    [[CMDHelper shareInstance] sendCMD:cmd04];
}

- (void)receivedDeviceList:(NSArray *)devices
{
    for (Device *dev in devices) {
        DeviceStatus *device = (DeviceStatus *)dev;
        if (device.name == self.plugName) {
            if (device.po) {
                <#statements#>
            }
        }
    }
}

- (void)switchPlug:(BOOL)on
{
    CMD04_GetAllDeviceList *cmd04 = alloc
}

#pragma mark - CMD Helper Delegate methods
-(void)receiveCMD:(ServerCommand*)cmd
{
    NSLog(@"received respond: %@", cmd);
    if (cmd->CommandNo == [CMD01_ServerLoginPermit commandConst]) {
        NSLog(@"login permit key: %@", ((CMD01_ServerLoginPermit *)cmd).key );
    } else if (cmd->CommandNo == [CMD03_ServerLoginRespond commandConst]) {
        NSLog(@"result: %d", ((CMD03_ServerLoginRespond *)cmd).result);
        NSLog(@"User Info: %@", ((CMD03_ServerLoginRespond *)cmd).info);
        BOOL res = ((CMD03_ServerLoginRespond *)cmd).result;
         if (res) {
             NSLog(@"plug did connect");
             //[self getAllDevices];
         }
    } else if (cmd->CommandNo == [CMD05_ServerRespondAllDeviceList commandConst]) {
       // self.deviceList = ((CMD05_ServerRespondAllDeviceList *)cmd).deviceList;
       // [self didReceiveDevices];
    } else if (cmd->CommandNo == [CMD07_ServerRespondDeviceStatus commandConst]) {
        //self.deviceStatus = ((CMD07_ServerRespondDeviceStatus *)cmd).status;
        //[self didReceiveDeviceStatus];
    } else if (cmd->CommandNo == [CMD09_ServerControlResult commandConst]) {
        NSLog(@"changes status?!");
    } else if (cmd->CommandNo == [CMDFF_ServerException commandConst]) {
        NSLog(@"error message from server");
    }
}

-(void)socketConnected
{
    NSLog(@"socket connected:%hhd", [[CMDHelper shareInstance] isConnected]);
    [self login];
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



@end
