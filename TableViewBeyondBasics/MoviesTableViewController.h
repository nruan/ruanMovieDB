//
//  MoviesTableViewController.h
//  CS470Feb27
//
//  Created by AAK on 2/27/14.
//  Copyright (c) 2014 Ali Kooshesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoviesDataSource.h"
#import "Theater.h"
@interface MoviesTableViewController : UITableViewController<DataSourceReadyForUseDelegate,UITableViewDelegate,UITableViewDataSource>

-(instancetype) initWithTheater: (Theater *) theater;
@end
