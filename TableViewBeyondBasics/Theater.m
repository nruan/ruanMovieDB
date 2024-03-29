//
//  Theater.m
//  TableViewBeyondBasics
//
//  Created by student on 3/28/15.
//  Copyright (c) 2015 Ali Kooshesh. All rights reserved.
//

#import "Theater.h"

enum {VIEW_HEIGHT = 90};

@interface Theater()

@property (nonatomic) NSMutableDictionary *theaterAttrs;

@end

@implementation Theater

-(id) initWithDictionary: (NSDictionary *) dictionary{
    if ((self = [super init]) == nil)
        return nil;
    self.theaterAttrs = [NSMutableDictionary dictionaryWithDictionary:dictionary];
    return self;
}

-(void) addValue:(NSString *)attrVal forAttribute:(NSString *)attrName
{
    [self.theaterAttrs setObject:attrVal forKey:attrName];
}

-(NSString *) getValueForAttribute: (NSString *) attr{
    return [self.theaterAttrs valueForKey:attr];
}

-(NSString *) title {
    return [self.theaterAttrs valueForKey:@"theaterTitle"];
}

-(CGSize) sizeOfListEntryView
{
    CGRect bounds = [[UIScreen mainScreen] applicationFrame];
    return CGSizeMake(bounds.size.width, VIEW_HEIGHT);
}

-(NSString *) imageNameForDetailedView
{
    return [self getValueForAttribute:@"largeImageURl"];
}

-(NSAttributedString *) compose: (NSString *) str withBoldPrefix:(NSString *) prefix
{
    const CGFloat fontSize = 13;
    UIFont *boldFont = [UIFont boldSystemFontOfSize:fontSize];
    UIFont *regularFont = [UIFont systemFontOfSize:fontSize];
    UIFont *italicFont = [UIFont italicSystemFontOfSize:fontSize];
    UIColor *foregroundColor = [UIColor blackColor];
    
    // Create the attributes
    NSMutableDictionary *attrs = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  regularFont, NSFontAttributeName,
                                  foregroundColor, NSForegroundColorAttributeName, nil];
    
    NSDictionary *boldAttrs = [NSDictionary dictionaryWithObjectsAndKeys:
                               boldFont, NSFontAttributeName, nil];
    
    NSMutableAttributedString *attrString = nil;
    if( [prefix isEqualToString: @""] ) {
        [attrs setObject:italicFont forKey:NSFontAttributeName];
        attrString = [[NSMutableAttributedString alloc] initWithString:str attributes:attrs];
    } else {
        NSString *text = [NSString stringWithFormat:@"%@: %@", prefix, str];
        attrString = [[NSMutableAttributedString alloc] initWithString:text attributes:attrs];
        NSRange range = NSMakeRange(0, prefix.length);
        [attrString setAttributes:boldAttrs range:range];
    }
    return attrString;
}

-(NSAttributedString *) descriptionForListEntry
{
//    NSMutableAttributedString *title = [[self titleForListEntry] mutableCopy];
//    NSMutableAttributedString *director = [[self directorForListEntry] mutableCopy];
//    NSMutableAttributedString *genre = [[self genreForListEntry] mutableCopy];
//    [title replaceCharactersInRange: NSMakeRange(title.length, 0) withString: @"\n"];
//    [director replaceCharactersInRange: NSMakeRange(director.length, 0) withString:@"\n"];
//    [title appendAttributedString:director];
//    [title appendAttributedString:genre];
//    return title;
    NSMutableAttributedString *title = [[self titleForListEntry] mutableCopy];
    [title replaceCharactersInRange:NSMakeRange(title.length, 0) withString:@"\n"];
    return title;
}

-(NSAttributedString *) titleForListEntry
{
    NSString *title = [self title];
    
    return [self compose:title withBoldPrefix:@""];
}

-(void) print
{
    NSEnumerator *mEnum = [self.theaterAttrs keyEnumerator];
    NSString *attrName;
    while( attrName = (NSString *) [mEnum nextObject] ) {
        NSLog( @"Attribute Name:  %@", attrName );
        NSLog( @"Atrribute Value: %@", [self.theaterAttrs objectForKey: attrName] );
    }
}



@end