//
//  BasketballViewModel.m
//  TRProject
//
//  Created by tarena on 16/2/26.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "BasketballViewModel.h"
#import "NSObject+ViewModel.h"

@implementation BasketballViewModel

- (NSInteger)rowNumber{
    return self.multiArr.count;
}

- (BasketballListModel *)modelForRow:(NSInteger)row{
    return self.multiArr[row];
}

- (NSURL *)imglinkForRow:(NSInteger)row{
    return [NSURL URLWithString:[self modelForRow:row].imglink];
}

- (NSString *)titleForRow:(NSInteger)row{
    return [self modelForRow:row].title;
}
- (NSString *)contentForRow:(NSInteger)row{
    return [self modelForRow:row].content168;
}
- (NSString *)readartsForRow:(NSInteger)row{
    return (NSString *)[NSString stringWithFormat:@"阅读 %ld",[self modelForRow:row].readarts];
}
- (NSString *)dateForRow:(NSInteger)row{
    return [self modelForRow:row].date;
}
- (NSString *)authorForRow:(NSInteger)row{
    return [NSString stringWithFormat:@"%@",[self modelForRow:row].author];
}

- (NSMutableArray *)multiArr{
    if (!_multiArr) {
        _multiArr = [NSMutableArray new];
    }
    return _multiArr;
}

- (instancetype)initWithType:(basketballType)type{
    if (self = [super init]) {
        _type = type;
    }
    return self;
}

- (instancetype)init{
    NSAssert(NO, @"%s, 必须使用initWithType:方法初始化", __FUNCTION__);
    return nil;
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
    [BasketballNetManager getDataWithType:self.type page:tmpPage completionHandler:^(BasketballModel *model, NSError *error) {
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

- (NSURL *)urlForRow:(NSInteger)row{
    return [NSURL URLWithString:[self modelForRow:row].url];
}
@end
