//
//  Gyroscope.m
//  AWARE
//
//  Created by Yuuki Nishiyama on 11/20/15.
//  Copyright © 2015 Yuuki NISHIYAMA. All rights reserved.
//

#import "Gyroscope.h"


@implementation Gyroscope{
    CMMotionManager* gyroManager;
    NSTimer* gTimer;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        gyroManager = [[CMMotionManager alloc] init];
    }
    return self;
}

- (instancetype)initWithSensorName:(NSString *)sensorName{
    self = [super init];
    if (self) {
        gyroManager = [[CMMotionManager alloc] init];
        [super setSensorName:sensorName];
    }
    return self;
}

- (BOOL)startSensor:(double)interval withUploadInterval:(double)upInterval{
    NSLog(@"Start Gyroscope!");
    gTimer = [NSTimer scheduledTimerWithTimeInterval:upInterval target:self selector:@selector(uploadSensorData) userInfo:nil repeats:YES];
    gyroManager.gyroUpdateInterval = interval;
    [gyroManager startGyroUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMGyroData * _Nullable gyroData, NSError * _Nullable error) {
        if( error ) {
            NSLog(@"%@:%ld", [error domain], [error code] );
        } else {
            NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
            NSNumber* unixtime = [NSNumber numberWithDouble:timeStamp];
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setObject:unixtime forKey:@"timestamp"];
            [dic setObject:[self getDeviceId] forKey:@"device_id"];
            [dic setObject:[NSNumber numberWithDouble:gyroData.rotationRate.x] forKey:@"axis_x"];
            [dic setObject:[NSNumber numberWithDouble:gyroData.rotationRate.y] forKey:@"axis_y"];
            [dic setObject:[NSNumber numberWithDouble:gyroData.rotationRate.z] forKey:@"axis_z"];
            [dic setObject:@0 forKey:@"accuracy"];
            [dic setObject:@"text" forKey:@"label"];
            [self setLatestValue:[NSString stringWithFormat:@"%f, %f, %f",gyroData.rotationRate.x,gyroData.rotationRate.y,gyroData.rotationRate.z]];
            [self saveData:dic toLocalFile:SENSOR_GYROSCOPE];
        }
    }];
    return YES;
}

- (BOOL)stopSensor{
    [gyroManager stopGyroUpdates];
    [gTimer invalidate];
    return YES;
}

- (void)uploadSensorData{
    NSString * jsonStr = [self getData:SENSOR_GYROSCOPE withJsonArrayFormat:YES];
    [self insertSensorData:jsonStr withDeviceId:[self getDeviceId] url:[self getInsertUrl:SENSOR_GYROSCOPE ]];
}


@end