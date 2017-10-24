//
//  TWHVTableView.h
//  HVTableViewDemo
//
//  Created by Towey on 2017/10/24.
//  Copyright © 2017年 tw. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TWHVTableView;

@protocol TWHVTableViewDataSource <NSObject>

@required

//列表的组数
- (NSInteger)numberOfSectionsInTWHVTableView:(TWHVTableView *)hvTableView;

//列表中每一组的行数
- (NSInteger)hvTableView:(TWHVTableView *)hvTableView numberOfRowsInSection:(NSInteger)section;

//列表左边内容的cell
- (UITableViewCell *)hvTableViewLeftTableView:(UITableView *)leftTableView CellForRowAtIndexPath:(NSIndexPath *)indexPath;

//列表右边内容的cell
- (UITableViewCell *)hvTableViewRightTableView:(UITableView *)rightTableView CellForRowAtIndexPath:(NSIndexPath *)indexPath;

//列表左边头部
- (UIView *)leftHeadView;

//列表右边头部
- (UIView *)rightHeadView;

@end


@protocol TWHVTableViewDelegate <NSObject>

@required

//列表头部的高度
- (CGFloat)heightForHeadView;

//列表左边区域（左边固定部分）的宽度
- (CGFloat)widthForLeftView;

//列表右边区域（可以左右滑动）的宽度
- (CGFloat)widthForRightView;

//列表中项cell的高度
- (CGFloat)hvTableView:(TWHVTableView *)hvTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;


@optional

//点击列表项事件
- (void)hvTableView:(TWHVTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface TWHVTableView : UIView

@property (nonatomic, weak) id <TWHVTableViewDataSource> dataSource;

@property (nonatomic, weak) id <TWHVTableViewDelegate> delegate;

@end
