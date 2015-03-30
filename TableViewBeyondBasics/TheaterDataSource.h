//
//  TheaterDataSource.h
//  TableViewBeyondBasics
//
//  Created by student on 3/28/15.
//  Copyright (c) 2015 Ali Kooshesh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Theater.h"
#import "DownloadAssistant.h"
//#import "TheaterTableViewController.h"

@protocol DataSourceReadyForUseDelegate2;
@interface TheaterDataSource : NSObject<WebDataReadyDelegate>

@property (nonatomic) id<DataSourceReadyForUseDelegate2> delegate;
@property (nonatomic) BOOL dataReadyForUse;

-(instancetype) initWithTheatersAtURLString: (NSString *) tURL;
-(Theater *) theaterWithTitle: (NSString *) theaterTitle;
-(NSMutableArray *) getAllTheaters;
-(Theater *) theaterAtIndex: (NSInteger) idx;
-(NSInteger) numberOfTheaters;
//-(NSString *) theaterTabBarTitle;
-(NSString *) theatersBarButtonItemBackButtonTitle;
-(BOOL) deleteTheaterAtIndex: (NSInteger) idx;

@end

@protocol DataSourceReadyForUseDelegate2 <NSObject>

@optional

-(void) dataSourceReadyForUse: (TheaterDataSource *) dataSource;

@end