//
//  Reconnector.h
//  nRF Toolbox
//
//  Created by Kawajiri Ryoma on 10/23/15.
//  Copyright (c) 2015 Nordic Semiconductor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

#import "ScannerDelegate.h"

@interface Reconnector : NSObject<CBCentralManagerDelegate>

- (id)initWithDelegate:(id)delegate;

@end
