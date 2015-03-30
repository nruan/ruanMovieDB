//
//  TheaterDataSource.m
//  TableViewBeyondBasics
//
//  Created by student on 3/28/15.
//  Copyright (c) 2015 Ali Kooshesh. All rights reserved.
//

#import "TheaterDataSource.h"
//#import "Theater.h"
//#import "DownloadAssistant.h"

//@protocol DataSourceReadyForUseDelegate;


@interface TheaterDataSource(){
    BOOL _debug;
}

@property (nonatomic, copy) NSString *theatersURLString;
@property (nonatomic) NSData *theatersNSData;
@property (nonatomic) NSMutableArray *allTheaters;
@property (nonatomic) DownloadAssistant *downloadAssistant;

@end

@implementation TheaterDataSource

-(NSMutableArray *) allTheaters
{//initialize all theater array
    if(! _allTheaters)
        _allTheaters = [[NSMutableArray alloc] init];
    return _allTheaters;
}

-(instancetype) initWithTheatersAtURLString:(NSString *)tURL {
    if ((self = [super init]) == nil) {
        return nil;
    }
    self.theatersURLString = tURL;
    _debug = YES;
    
    _downloadAssistant.delegate = [[DownloadAssistant alloc] init];
    self.downloadAssistant.delegate = self;
    self.dataReadyForUse = NO;
    
    NSURL *url = [NSURL URLWithString:self.theatersURLString];
    [self.downloadAssistant downloadContentsOfURL:url];
    return self;
}

-(void) processTheatersJSON{
    NSError *parseError = nil;
    NSArray *jsonString = [NSJSONSerialization JSONObjectWithData:self.theatersNSData options:0 error:&parseError];
    if(_debug)
        NSLog(@"%@", jsonString);
    if (parseError) {
        NSLog(@"Badly formed JSON string");
        return;
    }
    for (NSDictionary *theaterTuple in jsonString) {
    //for(int i = 0, i < 22, i++){
        Theater *theater = [[Theater alloc] initWithDictionary:theaterTuple];
        if (_debug) {
            [theater print];
        }
        [self.allTheaters addObject:theater];
        NSLog(@"num theaters %@", @([self.allTheaters count]));
    }
    self.theatersNSData = nil;
    if ([self.delegate respondsToSelector:@selector(dataSourceReadyForUse:)]) {
        [self.delegate performSelector:@selector(dataSourceReadyForUse:) withObject:self];
    }
}

-(void) print {
    for (Theater *t in self.allTheaters) {
        [t print];
    }
}

-(void) acceptWebData:(NSData *)webData forURL:(NSURL *)url{
    self.theatersNSData = webData;
    [self processTheatersJSON];
    [self print];
    NSLog(@"Completing printing theaters.");
    self.dataReadyForUse = YES;
    
}

-(Theater *) theaterWithTitle: (NSString *) theaterTitle{
    // not complete
    if ([self.allTheaters count] == 0)
        return nil;
    for (Theater *theater in self.allTheaters)
        if ([theater.title isEqualToString: theaterTitle])
            return theater;
    
    return nil;
    
}

-(BOOL) deleteTheaterAtIndex: (NSInteger) idx
{
    [self.allTheaters removeObjectAtIndex:idx];
    return YES;
}

-(NSArray *) getAllTheaters {
    return self.allTheaters;
    
}

-(Theater *) theaterAtIndex: (NSInteger) idx {
    if (idx >= [self.allTheaters count])
        return nil;
    return [self.allTheaters objectAtIndex:idx];
    
}

-(NSInteger) numberOfTheaters {
    return [self.allTheaters count];
}
-(NSString *) theatersTabBarTitle {
    return @"Theaters";
}

-(NSString *) theatersBarButtonItemBackButtonTitle{
    return @"Theaters";
    
}

@end
