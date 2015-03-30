//
//  TheaterTableViewController.h
//  TableViewBeyondBasics
//
//  Created by student on 3/28/15.
//  Copyright (c) 2015 Ali Kooshesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TheaterDataSource.h"
//#import "TheaterTableViewController.h"

@interface TheaterTableViewController : UITableViewController<DataSourceReadyForUseDelegate2,UITableViewDelegate,UITableViewDataSource>

@end
