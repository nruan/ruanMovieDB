//
//  TheaterTableViewController.m
//  TableViewBeyondBasics
//
//  Created by student on 3/28/15.
//  Copyright (c) 2015 Ali Kooshesh. All rights reserved.
//

#import "TheaterTableViewController.h"
#import "TheaterDataSource.h"
#import "MoviesTableViewController.h"
#import "MoviesDetailedViewController.h"
//#import "Theater.h"

@interface TheaterTableViewController()

@property(nonatomic) TheaterDataSource *tDataSource;
@property(nonatomic) UIActivityIndicatorView *tActivityIndicator;

@end

enum {THEATER_VIEW_HEIGHT = 90, GAP_BTWN = 5};

static NSString *CellIdentifier = @"Cell";

@implementation TheaterTableViewController

-(id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self){
        //custom init
    }
    self.title = @"Theater";
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    NSString *theatersURLString =@"http://www.cs.sonoma.edu/~nruan/movies/dbInterface.py?rType=movieTheaters";
    
    self.tDataSource = [[TheaterDataSource alloc] initWithTheatersAtURLString:theatersURLString];
    //self.tDataSource.delegate = self;
    self.tDataSource.delegate = self;
    
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(refreshTableView:) forControlEvents:UIControlEventValueChanged];
    
    _tActivityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.tActivityIndicator setCenter: self.view.center];
    [self.view addSubview: self.tActivityIndicator];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dataSourceReadyForUse:(TheaterDataSource *) dataSource{
    [self.tableView reloadData];
    [self.tActivityIndicator stopAnimating];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    if ( ![self.tDataSource dataReadyForUse]) {
        [self.tActivityIndicator startAnimating];
        [self.tActivityIndicator setHidesWhenStopped:YES];
    }
    return 1;
}

-(CGFloat) tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section
{
    return THEATER_VIEW_HEIGHT;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSLog(@"Number of rows in the table: %@", @([self.tDataSource numberOfTheaters]));
    return [self.tDataSource numberOfTheaters];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    //Theater *theater = [self.tDataSource theaterAtIndex:[indexPath row]];
    cell = [self theaterViewForIndex:[indexPath row] withTableViewCell:cell];
    //cell = [self ]
    //cell.textLabel.text = [theater title];
    return cell;
}

-(void) refreshTableView: (UIRefreshControl *) sender
{
    [self.tableView reloadData];
    [sender endRefreshing];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //   [self.tDataSource deleteMovieAtIndex:[indexPath row]];
    [self.tDataSource deleteTheaterAtIndex:[indexPath row]];
    [self.tableView deleteRowsAtIndexPaths: @[indexPath] withRowAnimation: UITableViewRowAnimationAutomatic];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Theater *theater = [self.tDataSource theaterAtIndex:[indexPath row]];
    //MoviesTableViewController *mController = [[MoviesDetailedViewController alloc] initWithTheater: theater];
    
    MoviesTableViewController *mController = [[MoviesTableViewController alloc] initWithTheater:theater];
    [self.navigationController pushViewController:mController animated:YES];
}

-(UITableViewCell *) theaterViewForIndex: (NSInteger) rowIndex withTableViewCell: (UITableViewCell *) cell
{
    enum {IMAGE_VIEW_TAG = 20, MAIN_VIEW_TAG = 50, LABEL_TAG = 30};
    
    Theater *theater = [self.tDataSource theaterAtIndex: rowIndex];
    UIView *view = [cell viewWithTag: MAIN_VIEW_TAG];
    
    if( view ) {
        UIImageView *iv = (UIImageView *)[view viewWithTag: IMAGE_VIEW_TAG];
        NSArray *views = [iv subviews];
        for( UIView *v in views )
            [v removeFromSuperview];
        //iv.image = [Theater imageForListEntry];
        //iv.image =
        UILabel *aLabel = (UILabel *) [view viewWithTag: LABEL_TAG];
        aLabel.attributedText = [theater descriptionForListEntry];
        return cell;
    }

    CGRect bounds = [[UIScreen mainScreen] applicationFrame];
    CGRect viewFrame = CGRectMake(0, 0, bounds.size.width, THEATER_VIEW_HEIGHT);
    
    UIView *thisView = [[UIView alloc] initWithFrame: viewFrame];
    
    //UIImage *img = [theater imageForListEntry];
    //CGRect imgFrame = CGRectMake(10, (viewFrame.size.height - IMAGE_HEIGHT) / 2, IMAGE_WIDTH, IMAGE_HEIGHT );
    //UIImageView *iView = [[UIImageView alloc] initWithImage: img];
    //iView.tag = IMAGE_VIEW_TAG;
    //iView.frame = imgFrame;
    //[thisView addSubview: iView];
    
    
    UILabel *theaterInfoLabel = [[UILabel alloc]
                               initWithFrame:CGRectMake(10, 5,
                                                        viewFrame.size.width - 10,
                                                        viewFrame.size.height -10)];
    
    theaterInfoLabel.tag = LABEL_TAG;
    NSAttributedString *desc = [theater titleForListEntry];
    theaterInfoLabel.attributedText = desc;
    theaterInfoLabel.numberOfLines = 0;
    [thisView addSubview: theaterInfoLabel];
    thisView.tag = MAIN_VIEW_TAG;
    [[cell contentView] addSubview:thisView];
    
    return cell;
}

/*
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: forIndexPath:indexPath];
 
 // Configure the cell...
 
 return cell;
 }
 */

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end