//
//  SwipeBaseVC.h
//  MediNeye
//
//  Created by HAN on 2016. 9. 30..
//  Copyright © 2016년 HAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwipeView.h"
#import "BaseVC.h"
#import "Utils.h"

@interface SwipeBaseVC : BaseVC <SwipeViewDataSource, SwipeViewDelegate>

/**** 화면구성 ui ****/
@property (strong, nonatomic) UIImageView *representMediImageView;
@property (strong, nonatomic) UILabel     *representMediLabel;
@property (strong, nonatomic) UIView      *pageFrameView; //화면 격자뷰
//end

//화면 touch button
@property (strong, nonatomic) UIButton *btnMediPageClick;


@property NSInteger currentPageIndex; //현재 화면 Index


//ui tag enum
typedef enum {
    mediImageViewTag = 9999,
    mediTitleTag     = 999,
    currentIndexTag  = 99,
    
}pageCompositionTag;
@end
