//
//  TelescopeShoppingCart.h
//  shop2
//
//  Created by Eugene Zvyagin on 10.12.2023.
// 

#import <Foundation/Foundation.h>
#import "TelescopeShoppingItem.h"

@interface TelescopeShoppingCart : NSObject

@property (nonatomic,strong) NSMutableDictionary *cart;
// Добавть товар
- (void)addItem:(TelescopeShoppingItem *)item;
//Удалить товар по названию
- (void)removeItemWithName:(NSString *)name;
// Перечислить все товары в корзине
- (NSArray *)listAllItems;
//Очистить корзину и удалить товары отмеченные на удаление
- (void)cleanCart;

//Единичный случай
+(instancetype)sharedShoppingCart;

@end
