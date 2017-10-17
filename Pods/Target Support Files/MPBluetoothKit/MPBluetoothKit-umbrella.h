#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "MPBluetoothKit.h"
#import "MPBluetoothKitBlocks.h"
#import "MPCentralManager.h"
#import "MPCharacteristic.h"
#import "MPDescriptor.h"
#import "MPPeripheral.h"
#import "MPService.h"

FOUNDATION_EXPORT double MPBluetoothKitVersionNumber;
FOUNDATION_EXPORT const unsigned char MPBluetoothKitVersionString[];

