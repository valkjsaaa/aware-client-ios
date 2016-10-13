//
//  SettingTableViewController.h
//  AWARE
//
//  Created by Yuuki Nishiyama on 9/28/16.
//  Copyright © 2016 Yuuki NISHIYAMA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingTableViewController : UITableViewController<UITableViewDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) NSString *selectedRowKey;

@property (nonatomic, strong) NSMutableArray *settingRows;

@end