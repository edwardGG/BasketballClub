//
//  VideoViewModel.m
//  TRProject
//
//  Created by tarena on 16/2/28.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "VideoViewModel.h"
#import "NSObject+ViewModel.h"
#import "VideoNetManager.h"
@implementation VideoViewModel

- (NSInteger)rowNumber{
    return self.multiArr.count;
}

- (VideoListModel *)modelForRow:(NSInteger)row{
    return self.multiArr[row];
}

- (NSString *)titleForRow:(NSInteger)row{
    return [self modelForRow:row].title;
}

- (NSString *)readartsForRow:(NSInteger)row{
    return [NSString stringWithFormat:@"%ld阅读", [self modelForRow:row].readarts];
}
- (NSString *)dateForRow:(NSInteger)row{
    return [self modelForRow:row].date;
}

- (NSURL *)imgForRow:(NSInteger)row{
    return [NSURL URLWithString:[self modelForRow:row].imglink];
}

- (NSURL *)urlForRow:(NSInteger)row{
    return [NSURL URLWithString:[self modelForRow:row].videolink];
}

- (NSMutableArray *)multiArr{
    if (!_multiArr) {
        _multiArr = [NSMutableArray new];
    }
    return _multiArr;
}

- (void)getDataWithRequestMode:(RequestMode)requestMode completionHanle:(void (^)(NSError *))completionHandle{
    NSInteger tmpPage = 0;
    switch (requestMode) {
        case RequestModeRefresh:{
            tmpPage = 0;
            break;
        }
        case RequestModeMore:{
            tmpPage = _page + 1;
            break;
        }
    }
    [VideoNetManager getVideoPage:tmpPage completionHandler:^(VideoModel *model, NSError *error) {
        if (!error) {
            if (requestMode == RequestModeRefresh) {
                [self.multiArr removeAllObjects];
            }
                [self.multiArr addObjectsFromArray:model.root.list];
                _page = tmpPage;
            }
        
        completionHandle(error);
    }];
}
@end
