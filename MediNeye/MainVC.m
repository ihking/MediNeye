//
//  MainVC.m
//  MediNeye
//
//  Created by HAN on 2016. 9. 26..
//  Copyright © 2016년 HAN. All rights reserved.
//

//barcord는 zbar library 사용

#import "MainVC.h"
#import "ZBarSDK.h" //barcode recognition
#import "Utils.h"

@import CoreLocation;

@interface MainVC () <CLLocationManagerDelegate, ZBarReaderDelegate>
@property (strong, nonatomic) IBOutlet SwipeView *swipeView;
@property (strong, nonatomic) IBOutlet UIImageView *pageRepresentImageView;

@property (nonatomic, strong) NSMutableArray *items;
@property (strong, nonatomic) CLLocationManager *locationManager;



typedef enum {
    searchPill,
    searchNearDrugStore,
    pillsAlram,
    nfcTag,
    handicapPersonWelfare,
    setting,
}pageType;

@end


@implementation MainVC

- (void)awakeFromNib {
    //set up data
    //your swipeView should always be driven by an array of
    //data of some kind - don't store data in your item views
    //or the recycling mechanism will destroy your data once
    //your item views move off-screen
    self.items = [NSMutableArray array];
    for (int i = 0; i < 6; i++) {
        [_items addObject:@(i)];
    }
}

- (void)dealloc {
    //it's a good idea to set these to nil here to avoid
    //sending messages to a deallocated viewcontroller
    //this is true even if your project is using ARC, unless
    //you are targeting iOS 5 as a minimum deployment target
    _swipeView.delegate = nil;
    _swipeView.dataSource = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _swipeView.pagingEnabled = YES;
    _swipeView.bounces = NO;
    
    self.currentPageIndex = 0;
    // Do any additional setup after loading the view.
    
    //위치정보 요청 매니저
    
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    _locationManager.distanceFilter = 500;
    
    //naviagation bar hide
    self.navigationController.navigationBar.hidden = YES;
    
    /*UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(pageClick)];
    [self.view addGestureRecognizer:tap];*/

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

#pragma mark -
#pragma mark iCarousel methods

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView {
    //return the total number of items in the carousel
    return [_items count];
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    self.representMediImageView = nil;
    self.representMediLabel     = nil;
    self.currentPageIndex       = index;

    //create new view if no view is available for recycling
    //view 대신 iamgeView로 가도되고 view위에 imageView를 씌워도 될듯.. hyundai source 보기
    //if(view == nil) {
        
    if (view == nil) {
        //don't do anything specific to the index within
        //this `if (view == nil) {...}` statement because the view will be
        //recycled and used with other index values later
        view = [[UIView alloc] initWithFrame:self.swipeView.bounds];
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        view.backgroundColor  = [UIColor colorWithHexString:@"#26292a"];

//        label = [[UILabel alloc] initWithFrame:view.bounds];
//        label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//        label.backgroundColor  = [UIColor clearColor];
//        label.textAlignment    = NSTextAlignmentCenter;
//        label.font = [label.font fontWithSize:50];
//        label.tag = 1;
//        [view addSubview:label];

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
        [self.representMediImageView autoresizingMask];

        self.representMediLabel     = (UILabel *)[view viewWithTag:mediTitleTag];

        //get a reference to the label in the recycled view
        //label = (UILabel *)[view viewWithTag:1];
    }

    switch (index) {
        case searchPill:
            self.representMediImageView.image = [UIImage imageNamed:@"pills"];
            self.representMediLabel.text = @"약 정보 검색";
            break;
        case searchNearDrugStore:
            self.representMediImageView.image = [UIImage imageNamed:@"pharm"];
            self.representMediLabel.text = @"주변 약국 검색";
            break;
        case pillsAlram:
            self.representMediImageView.image = [UIImage imageNamed:@"alarm"];
            self.representMediLabel.text = @"약 알람";
            break;
        case nfcTag:
            self.representMediImageView.image = [UIImage imageNamed:@"nfc_add"];
            self.representMediLabel.text = @"NFC";
            break;
        case handicapPersonWelfare:
            self.representMediImageView.image = [UIImage imageNamed:@"nfc_add"];
            self.representMediLabel.text = @"교통약자 복지";
            break;
        case setting:
            self.representMediImageView.image = [UIImage imageNamed:@"setting"];
            self.representMediLabel.text = @"설정";
            
            break;
        default:
            break;
    }

//    if(index == 2) {
//        self.pageRepresentImageView.image = [UIImage imageNamed:@"btn-barcode"];
//    } else {
//        self.pageRepresentImageView.image = [UIImage imageNamed:@"pills"];
//    }
    
    //set background color
//    view.backgroundColor = [UIColor colorWithRed:red
//                                           green:green
//                                            blue:blue
//                                           alpha:1.0];

    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    //label.text = [_items[index] stringValue];
    
    return view;
}

- (CGSize)swipeViewItemSize:(SwipeView *)swipeView {
    return self.swipeView.bounds.size;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)mediPageClickAction:(UIButton *)button {
    NSLog(@"mediPageClickAction 클릭 index %ld ", self.currentPageIndex);
    switch (self.currentPageIndex) {
        case searchPill:
            [self performSegueWithIdentifier:@"moveSearchPillVC" sender:self];
            break;

        default:
            break;
    }
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
