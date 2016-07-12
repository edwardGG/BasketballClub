//
//  SkillViewModel.m
//  TRProject
//
//  Created by tarena on 16/2/27.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "SkillViewModel.h"
#import "NSObject+ViewModel.h"
@implementation SkillViewModel

- (NSInteger)rowNumber{
    return self.mutliArr.count;
}

- (SkillListModel *)modelForRow:(NSInteger)row{
    return self.mutliArr[row];
}

- (NSString *)titleForRow:(NSInteger)row{
    return [self modelForRow:row].title;
}
- (NSURL *)imglinkForRow:(NSInteger)row{
    return [NSURL URLWithString:[self modelForRow:row].imglink];
}
- (NSString *)dateForRow:(NSInteger)row{
    return [self modelForRow:row].date;
}
- (NSString *)readartsForRow:(NSInteger)row{
    return [NSString stringWithFormat:@"%ld阅读",[self modelForRow:row].readarts];
}

- (NSMutableArray *)mutliArr{
    if (_mutliArr == nil) {
        _mutliArr = [NSMutableArray new];
    }
    return _mutliArr;
}

- (BOOL)hasThreeImage:(NSInteger)row{
    return [self modelForRow:row].TYPESETTING == 3;
}

- (BOOL)hasOneImage:(NSInteger)row{
    return [self modelForRow:row].TYPESETTING == 0;
}
- (BOOL)hasNoImage:(NSInteger)row{
    return [self modelForRow:row].TYPESETTING == 2;
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
    [SkillNetManager getSkillListPage:tmpPage completionHandler:^(SkillModel *model, NSError *error) {
        if (!error) {
            if (requestMode == RequestModeRefresh) {
                [self.mutliArr removeAllObjects];
            }
            [self.mutliArr addObjectsFromArray:model.root.list];
            _page = tmpPage;
        }
        completionHandle(error);
    }];
}

- (NSURL *)leftImgForRow:(NSInteger)row{
    return [NSURL URLWithString:[self modelForRow:row].imglink_1];
}
- (NSURL *)middleImgForRow:(NSInteger)row{
    return [NSURL URLWithString:[self modelForRow:row].imglink_2];
}
- (NSURL *)rightForRow:(NSInteger)row{
    return [NSURL URLWithString:[self modelForRow:row].imglink_3];
}

- (NSURL *)urlForRow:(NSInteger)row{
    return [NSURL URLWithString:[self modelForRow:row].url];
}
@end
