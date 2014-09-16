//
//  BlueToothCentral.h
//  coin
//
//  Created by Kanishk Parashar on 8/10/13.
//  Copyright (c) 2013 Coin Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kCNCoinBLEServiceUUID @"0xFFC0"
#define kCNCoinBLEWriteCharacteristicUUID @"0xFFC1"
#define kCNCoinBLEReadCharacteristicUUID @"0xFFC2"

@class CBCharacteristic;
@class CBPeripheral;

@protocol CNBluetoothCentralDelegate;

@interface CNBluetoothCentral : NSObject

@property (nonatomic, weak) id<CNBluetoothCentralDelegate> delegate;

+ (CNBluetoothCentral *)sharedBluetoothCentral;

- (BOOL)startCentral;
- (BOOL)sendDataWithoutResponse:(NSString *) dataStr;
- (void)cleanup;
- (BOOL)isConnected;

@end

@protocol CNBluetoothCentralDelegate <NSObject>

@required

- (void)scanStarted;

- (void)centralDidNotStart:(NSString *)errorString;

- (void)centralConnectedwithPeripheral:(CBPeripheral *)peripheral withError:(NSError *)error;

- (void)centralDisconnectwithPeripheral:(CBPeripheral *)peripheral withError:(NSError *)error;

- (void)centralReadCharacteristic:(CBCharacteristic *)characteristic withPeripheral:(CBPeripheral *)peripheral withError:(NSError *)error;

- (void)centralWroteCharacteristic:(CBCharacteristic *)characteristic withPeripheral:(CBPeripheral *)peripheral withError:(NSError *)error;

@end
