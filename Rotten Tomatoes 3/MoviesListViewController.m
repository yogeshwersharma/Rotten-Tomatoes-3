//
//  MoviesListViewController.m
//  Rotten Tomatoes 3
//
//  Created by Yogi Sharma on 2/8/15.
//  Copyright (c) 2015 Yogi Sharma. All rights reserved.
//

#import "MoviesListViewController.h"
#import "MoviesListCell.h"
#import "UIImageView+AFNetworking.h"
#import "MovieViewController.h"


@interface MoviesListViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *moviesListTableView;
@property (strong, nonatomic) NSArray *moviesArray;
@property(strong, nonatomic) UIRefreshControl* refreshControl;

@end

@implementation MoviesListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.moviesListTableView.delegate = self;
    self.moviesListTableView.dataSource = self;
    self.moviesListTableView.rowHeight = 100;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshMoviesList:) forControlEvents:UIControlEventValueChanged];
    [self.moviesListTableView insertSubview:self.refreshControl atIndex:0];

    
    UINib *moviesListCell = [UINib nibWithNibName:@"MoviesListCell" bundle:nil];
    [self.moviesListTableView registerNib:moviesListCell forCellReuseIdentifier:@"MoviesListCell"];
    
    // NSURL *url = [NSURL URLWithString:@"http://api.rottentomatoes.com/api/public/v1.0/movies.json?apikey=wa8ym8ph9fdhv7ntwd6jtkcm&q=carolina"];
    
    NSURL *url = [NSURL URLWithString:@"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=wa8ym8ph9fdhv7ntwd6jtkcm"];
   
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.moviesArray = dict[@"movies"];
        // NSLog(@"Response from query: %@", self.moviesArray);
        [self.moviesListTableView reloadData];
    }];
    
}

- (void)refreshMoviesList:(id)sender
{
    // todo(yogi): Does not seem to be working.
    NSLog(@"Refreshing");
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // [self.moviesListTableView deselectRowAtIndexPath:indexPath animated:YES];
    MovieViewController *vc = [[MovieViewController alloc] init];
    vc.movieInfo = self.moviesArray[indexPath.row];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    // Can use the version without forIndexPath.
    MoviesListCell *cell = [self.moviesListTableView dequeueReusableCellWithIdentifier:@"MoviesListCell" forIndexPath:indexPath];
    
    cell.name.text = [NSString stringWithFormat:@"%@", [self.moviesArray[indexPath.row] valueForKeyPath:@"title"]];
    NSLog(@"movie name: %@", cell.name.text);
    
    NSURL *urlForImage = [NSURL URLWithString:[self.moviesArray[indexPath.row] valueForKeyPath:@"posters.thumbnail"]];
    NSLog(@"URL for movie image %@", urlForImage);
    [cell.image setImageWithURL:urlForImage];
    
    return cell;
}

// - (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//     return [[NSString alloc] initWithFormat:@"Section %ld", section];
// }

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.moviesArray.count;
}

@end
