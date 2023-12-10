//
//  TelescopeShoppingItem.h
//  shop2
//
//  Created by Eugene Zvyagin on 10.12.2023.
// 

#import <Foundation/Foundation.h>

@interface TelescopeShoppingItem : NSObject

@property (nonatomic,strong) NSString *itemName;
@property (nonatomic,assign) NSInteger number;
//Следуйте подсказкам
@property (nonatomic,weak) NSIndexPath *iP;
//Удалить отметку
@property (nonatomic,assign) BOOL canDelete;

+ (instancetype)itemWithName:(NSString *)name andNumber:(NSInteger)num;
+ (instancetype)itemWithName:(NSString *)name;

- (NSInteger)addItem;
- (NSInteger)removeItem;

@end
