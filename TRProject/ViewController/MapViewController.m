//
//  MapViewController.m
//  TRProject
//
//  Created by tarena on 16/3/16.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "MapViewController.h"
@import MapKit;
@import CoreLocation;

@interface MapViewController ()<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic) CLLocationManager *locationManager;
@end

@implementation MapViewController
//当用户位置信息发生变化时
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    //把地图范围缩小到用户位置
    //1.一个显示范围, 值是经纬度
    //1经度 ≈ 111km
    MKCoordinateSpan span = MKCoordinateSpanMake(0.01, 0.01);
    //2.设置显示区域, 参数1:中心点
    MKCoordinateRegion region = MKCoordinateRegionMake(userLocation.coordinate, span);
    [mapView setRegion:region animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //申请用户定位授权
    _locationManager = [CLLocationManager new];
    if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [_locationManager requestWhenInUseAuthorization];
    }
    //通过mapView的代理,来实现各种回调
    _mapView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
