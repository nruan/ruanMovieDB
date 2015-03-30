//
//  Theater.h
//  TableViewBeyondBasics
//
//  Created by student on 3/28/15.
//  Copyright (c) 2015 Ali Kooshesh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Theater : NSObject

-(void) addValue: (NSString *) attrVal forAttribute: (NSString *) attrName;
-(NSString *) getValueForAttribute: (NSString *) attr;
-(void) print;

-(NSString *) title;
-(NSAttributedString *) titleForListEntry;
-(NSString *) imageNameForDetailedView;
-(NSString *) htmlDescriptionForDetailedView;
-(NSAttributedString *) descriptionForListEntry;
-(id) initWithDictionary: (NSDictionary *) dictionary;

@end