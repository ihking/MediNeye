//
//  ViewController.m
//  MediNeye
//
//  Created by HAN on 2016. 9. 20..
//  Copyright © 2016년 HAN. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //도레미파솔라시도? sound 필요
    //휴대폰 흔들림 감지
    //메인페이지는 약 정보 검색, 약국 정보 검색, NFC 태그, 설정 페이지로 나뉨
    //swipe를 할 경우 해당 페이지에 맞는 음계? 가 들림
    //NFC
    //#26292A

    NSString *pewPewPath = [[NSBundle mainBundle]
                            pathForResource:@"pew-pew-lei" ofType:@"caf"];
    NSURL *pewPewURL = [NSURL fileURLWithPath:pewPewPath];
    //AudioServicesCreateSystemSoundID((__bridge CFURLRef)pewPewURL, &self.pewPewSound);
    //AudioServicesPlaySystemSound(self.pewPewSound);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
