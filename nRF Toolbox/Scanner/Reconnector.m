//
//  Reconnector.m
//  nRF Toolbox
//
//  Created by Kawajiri Ryoma on 10/23/15.
//  Copyright (c) 2015 Nordic Semiconductor. All rights reserved.
//

#import "Reconnector.h"

@interface Reconnector ()

@property CBCentralManager *manager;
@property (nonatomic, weak) id <ScannerDelegate> del;

@end

@implementation Reconnector {
    id del;
}

@synthesize manager;


- (id)initWithDelegate:(id)delegate {
    if (self = [super init]) {
        del = delegate;

        dispatch_queue_t queue = dispatch_queue_create("no.nordicsemi.ios.nrftoolbox", DISPATCH_QUEUE_SERIAL);
        manager = [[CBCentralManager alloc] initWithDelegate:self queue:queue];
    }
    return self;
}

- (void) centralManagerDidUpdateState:(CBCentralManager *)central {
    if (central.state == CBCentralManagerStatePoweredOn) {
        NSDictionary *options = @{CBCentralManagerScanOptionAllowDuplicatesKey : @YES};
        [central scanForPeripheralsWithServices:nil options:options];
    }
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    NSLog(@"Discovered Peripheral: %d %@ %@", RSSI.intValue, peripheral.name, peripheral.identifier);
    if ([peripheral.name isEqualToString:@"StrbDFU"]) {
        [central stopScan];
        NSLog(@"Found Peripheral");
        [del centralManager:manager didPeripheralSelected:peripheral];
    }
}

@end
