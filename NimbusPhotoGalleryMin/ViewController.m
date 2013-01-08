//
//  ViewController.m
//  NimbusPhotoGalleryMin
//
//  Created by Garrett Richards on 1/8/13.
//  Copyright (c) 2013 Garrett Richards. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "NIInMemoryCache.h"

@interface ViewController ()
@property(nonatomic, retain) NSArray *imageUrls;
@property(nonatomic, retain) NSOperationQueue *queue;
@property(nonatomic, retain) NIMemoryCache * highQualityImageCache;
@end

@implementation ViewController


- (void)loadView {
    [super loadView];
    
    self.queue = [[NSOperationQueue alloc] init];
    self.highQualityImageCache = [[NIMemoryCache alloc] init];
    
    self.photoAlbumView.dataSource = self;
    //    self.photoScrubberView.dataSource = self;
    
    // Dribbble is for mockups and designs, so we don't want to allow the photos to be zoomed
    // in and become blurry.
    self.photoAlbumView.zoomingAboveOriginalSizeIsEnabled = NO;
    
    // This title will be displayed until we get the results back for the album information.
    self.title = NSLocalizedString(@"Loading...", @"Navigation bar title - Loading a photo album");
    
    self.imageUrls = @[@"http://farm9.staticflickr.com/8487/8280858269_3912e12336_z.jpg"
    , @"http://farm9.staticflickr.com/8499/8280846365_eabfc3e4df_c.jpg"
    , @"http://farm9.staticflickr.com/8338/8281913400_e2fb37d65c_c.jpg"
    , @"http://farm9.staticflickr.com/8078/8281912906_69a9f08aa0_c.jpg"
    , @"http://farm9.staticflickr.com/8491/8281475608_529c0412dd_z.jpg"];
    
    self.photoAlbumView.loadingImage = [UIImage imageWithContentsOfFile: NIPathForBundleResource(nil, @"NimbusPhotos.bundle/gfx/default.png")];
    
    
    [self loadAlbumInformation];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)loadAlbumInformation
{
    [self.photoAlbumView reloadData];
    [self refreshChromeState];
    
}

- (void)requestImageFromSource:(NSString *)source photoSize:(NIPhotoScrollViewPhotoSize)photoSize photoIndex:(NSInteger)photoIndex
{
    NSURL *url = [NSURL URLWithString:source];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.timeoutInterval = 30;
    
    AFImageRequestOperation *readOp =  [AFImageRequestOperation imageRequestOperationWithRequest:request imageProcessingBlock:nil success: ^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image)
                                        {
                                            NSLog(@"%s request = %@", __func__, [request.URL absoluteString]);
                                            [self.photoAlbumView didLoadPhoto:image atIndex:photoIndex photoSize:photoSize];
                                            [_highQualityImageCache storeObject:image withName:[NSString stringWithFormat:@"%i", photoIndex]];
                                            
                                        } failure: ^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error)
                                        {
                                            NSLog(@"%s error = %@", __func__, [error localizedDescription]);
                                        }];
    
    readOp.imageScale = 1;
    [readOp setQueuePriority:NSOperationQueuePriorityNormal];
    
    
    [_queue addOperation:readOp];
}


- (NSInteger)numberOfPagesInPagingScrollView:(NIPhotoAlbumScrollView *)photoScrollView {
    return [_imageUrls count];
}

- (UIImage *)photoAlbumScrollView: (NIPhotoAlbumScrollView *)photoAlbumScrollView photoAtIndex: (NSInteger)photoIndex
                        photoSize: (NIPhotoScrollViewPhotoSize *)photoSize
                        isLoading: (BOOL *)isLoading
          originalPhotoDimensions: (CGSize *)originalPhotoDimensions
{
    UIImage * image = [self.highQualityImageCache objectWithName:[NSString stringWithFormat:@"%i", photoIndex]];
    
    if (image != nil)
    {
        *photoSize = NIPhotoScrollViewPhotoSizeOriginal;
    }
    else
    {
        [self requestImageFromSource:[_imageUrls objectAtIndex:photoIndex] photoSize:NIPhotoScrollViewPhotoSizeOriginal photoIndex:photoIndex];
        *isLoading = YES;
    }
    
    return image;
}

- (id<NIPagingScrollViewPage>)pagingScrollView:(NIPagingScrollView *)pagingScrollView pageViewForIndex:(NSInteger)pageIndex {
    return [self.photoAlbumView pagingScrollView:pagingScrollView pageViewForIndex:pageIndex];
}

@end
