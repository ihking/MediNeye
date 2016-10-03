//
//  SearchPillVC.m
//  MediNeye
//
//  Created by HAN on 2016. 9. 30..
//  Copyright © 2016년 HAN. All rights reserved.
//

#import "SearchPillVC.h"
#import "ZBarSDK.h"

@interface SearchPillVC () <ZBarReaderDelegate>
@property (strong, nonatomic) IBOutlet SwipeView *searchTypeSwipeView;

@end

@implementation SearchPillVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchTypeSwipeView.pagingEnabled = YES;
    self.searchTypeSwipeView.bounces = NO;

    //naviagation bar hide
    self.navigationController.navigationBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    self.representMediImageView = nil;
    self.representMediLabel     = nil;
    self.currentPageIndex       = index;

    if (view == nil) {
        //don't do anything specific to the index within
        //this `if (view == nil) {...}` statement because the view will be
        //recycled and used with other index values later
        view = [[UIView alloc] initWithFrame:self.searchTypeSwipeView.bounds];
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        view.backgroundColor  = [UIColor colorWithHexString:@"#26292a"];

        NSLog(@"View Position : %@", view);

        //화면 격자 View
        self.pageFrameView = [[UIView alloc] initWithFrame:CGRectMake(18.0f, 18.0f, ([Utils getDeviceSize:@"width"] - 36.0f), [Utils getDeviceSize:@"height"] - 36.0f)];
        self.pageFrameView.layer.borderColor = [UIColor whiteColor].CGColor;
        self.pageFrameView.layer.borderWidth = 1.0f;
        [view addSubview:self.pageFrameView];
        
        //화면 title Label
        self.representMediLabel = [[UILabel alloc] initWithFrame:CGRectMake(18.0f, 45.0f, [Utils getDeviceSize:@"width"] - 36.0f, 30.0f)];
        self.representMediLabel.textAlignment = NSTextAlignmentCenter;
        self.representMediLabel.font      = [UIFont fontWithName:@"Helvetica Bold" size:25.0f];
        self.representMediLabel.textColor = [UIColor whiteColor];
        self.representMediLabel.tag       = mediTitleTag;
        [view addSubview:self.representMediLabel];

        //화면 represent ImageView
        self.representMediImageView = [[UIImageView alloc] initWithFrame:CGRectMake(([Utils getDeviceSize:@"width"] - 150.0f) / 2.0f, ([Utils getDeviceSize:@"height"] - 150.0f) / 2.0f, 150.0f, 150.0f)];
        //self.representMediImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.representMediImageView.image = [UIImage imageNamed:@"pills"];
        self.representMediImageView.tag   = mediImageViewTag;
        [view addSubview:self.representMediImageView];
        
        //page click button
        self.btnMediPageClick = [[UIButton alloc] initWithFrame:CGRectMake(18.0f, 18.0f, ([Utils getDeviceSize:@"width"] - 36.0f), [Utils getDeviceSize:@"height"] - 36.0f)];
        [self.btnMediPageClick addTarget:self action:@selector(mediPageClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:self.btnMediPageClick];

    } else {
        self.representMediImageView = (UIImageView *)[view viewWithTag:mediImageViewTag];
        self.representMediLabel     = (UILabel *)[view viewWithTag:mediTitleTag];
    }

    switch (index) {
        case 0:
            self.representMediImageView.image = [UIImage imageNamed:@"pills"];
            self.representMediLabel.text = @"음성 검색";
            break;
        case 1:
            self.representMediImageView.image = [UIImage imageNamed:@"btn_barcode"];
            self.representMediLabel.text = @"바코드 검색";
            break;
    }

    return view;
}

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView {
    //return the total number of items in the carousel
    return 2;
}

//swipe view size
- (CGSize)swipeViewItemSize:(SwipeView *)swipeView {
    return self.searchTypeSwipeView.bounds.size;
}

-(IBAction)mediPageClickAction:(id)sender {
    switch (self.currentPageIndex) {
        case 0:
            break;
        
        case 1:
            [self selectSearchPill];
            break;
            
        default:
            break;
    }
}

- (void)selectSearchPill {
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;

    ZBarImageScanner *scanner = reader.scanner;
    // TODO: (optional) additional reader configuration here
    
    // EXAMPLE: disable rarely used I2/5 to improve performance
    [scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];

    // present and release the controller
    [self presentViewController:reader animated:YES completion:nil];
}

- (void)imagePickerController: (UIImagePickerController*) reader didFinishPickingMediaWithInfo: (NSDictionary*) info {
    // ADD: get the decode results
    id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
    
    NSLog(@"RESULT.. : %@", results);

    //regx 추가
    ZBarSymbol *symbol = nil;
    for(symbol in results) {
        NSLog(@"SYMBOL : %@", symbol.data);

        // EXAMPLE: just grab the first barcode
        //break;
    }
    // EXAMPLE: do something useful with the barcode data
    //_textFieldUrl.text = symbol.data;
    
    // ADD: dismiss the controller (NB dismiss from the *reader*!)
    [reader dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
