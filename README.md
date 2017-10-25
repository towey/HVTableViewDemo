# HVTableViewDemo
### 横竖滑动列表
### 效果
<br/>
![image](https://github.com/towey/HVTableViewDemo/blob/master/gif/hvTableView.gif)
<br/><br/>
### 集成说明：
1、将HVTableView文件夹拖到项目中，并添加头文件 TWHVTableView.h
<br/>
2、创建HVTableView设置相应的属性，最主要是数据源和代理
<br/>
3、实现以下数据源和代理相应方法，具体使用可以参照demo

```objc
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

//列表头部的高度
- (CGFloat)heightForHeadView;

//列表左边区域（左边固定部分）的宽度
- (CGFloat)widthForLeftView;

//列表右边区域（可以左右滑动）的宽度
- (CGFloat)widthForRightView;

//列表中项cell的高度
- (CGFloat)hvTableView:(TWHVTableView *)hvTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
```

