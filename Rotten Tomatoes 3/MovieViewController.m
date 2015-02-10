//
//  MovieViewController.m
//  Rotten Tomatoes 3
//
//  Created by Yogi Sharma on 2/9/15.
//  Copyright (c) 2015 Yogi Sharma. All rights reserved.
//

#import "MovieViewController.h"
#import "UIImageView+AFNetworking.h"

@interface MovieViewController ()
// copied from the .h file.
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *synopsis;

@end

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSString *urlString = [NSString stringWithString:[self.movieInfo valueForKeyPath:@"posters.thumbnail"]];
    
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"_tmb.jpg" options:NSRegularExpressionCaseInsensitive error:&error];
    NSString *modifiedUrlString = [regex stringByReplacingMatchesInString:urlString options:0 range:NSMakeRange(0, [urlString length]) withTemplate:@"_ori.jpg"];
    NSLog(@"%@", modifiedUrlString);

    NSURL *urlForImage = [NSURL URLWithString:modifiedUrlString];
    NSLog(@"url for movie: %@", urlForImage);
    [self.backgroundImage setImageWithURL:urlForImage];
    
    self.scrollView.scrollEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(320,960);
    
    // NSLog(@"info: %@", self.movieInfo);
    
    self.name.text = [NSString stringWithString:self.movieInfo[@"title"]];
    // self.synopsisTextView.text = [NSString stringWithString:self.movieInfo[@"synopsis"]];
    // self.synopsisTextView.editable = NO;

    self.synopsis.text = [NSString stringWithString:self.movieInfo[@"synopsis"]];
    self.synopsis.numberOfLines = 0;
    // self.synopsis.lineBreakMode = UILineBreakModeWordWrap;
    [self.synopsis sizeToFit];
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.synopsis.frame.size.height + 500);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
