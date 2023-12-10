//
//  TelescopeShoppingItem.m
//  shop2
//
//  Created by Eugene Zvyagin on 10.12.2023.
//

#import "TelescopeShoppingItem.h"

@implementation TelescopeShoppingItem

+ (instancetype)itemWithName:(NSString *)name andNumber:(NSInteger)num
{
    TelescopeShoppingItem *item = [[TelescopeShoppingItem alloc] init];
    item.itemName = name;
    item.number = num;
    return item;
}
 
+ (instancetype)itemWithName:(NSString *)name
{
    TelescopeShoppingItem *item = [[TelescopeShoppingItem alloc] init];
    item.itemName = name;
    item.number = 1;
    return item;
}

- (NSInteger)addItem
{
    return ++self.number;
}
- (NSInteger)removeItem
{
    return --self.number;
}

@end
