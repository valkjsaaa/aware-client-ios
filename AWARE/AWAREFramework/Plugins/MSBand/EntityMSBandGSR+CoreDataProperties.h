//
//  EntityMSBandGSR+CoreDataProperties.h
//  AWARE
//
//  Created by Yuuki Nishiyama on 6/26/16.
//  Copyright © 2016 Yuuki NISHIYAMA. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "EntityMSBandGSR.h"

NS_ASSUME_NONNULL_BEGIN

@interface EntityMSBandGSR (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *timestamp;
@property (nullable, nonatomic, retain) NSString *device_id;
@property (nullable, nonatomic, retain) NSNumber *gsr;

@end

NS_ASSUME_NONNULL_END
