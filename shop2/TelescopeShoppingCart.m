//
//  TelescopeShoppingCart.m
//  shop2
//
//  Created by Eugene Zvyagin on 10.12.2023.
//

#import "TelescopeShoppingCart.h"

@implementation TelescopeShoppingCart

- (void)addItem:(TelescopeShoppingItem *)item
{
    self.cart[item.itemName] = item;
}

- (void)removeItemWithName:(NSString *)name
{
    [self.cart removeObjectForKey:name];
}

- (NSArray *)listAllItems
{
    return self.cart.allValues;
}
- (NSMutableDictionary *)cart
{
    if (_cart == nil) {
        _cart = [NSMutableDictionary dictionary];
    }
    return _cart;
}

- (void)cleanCart
{
    for (TelescopeShoppingItem *item in self.cart.allValues) {
        if (item.canDelete || (item.number == 0)) {
            [self.cart removeObjectForKey:item.itemName];
        }
    }
   }


   #pragma mark - единственный случай

   +(instancetype)sharedShoppingCart{
       return [[self alloc] init];
   }

   - (id)copyWithZone:(NSZone *)zone{
       return self;
   }

   + (instancetype)allocWithZone:(struct _NSZone *)zone {
       static id instance;
       static dispatch_once_t onceToken;
       dispatch_once(&onceToken, ^{
           instance = [super allocWithZone:zone];
       });
       return instance;
   }

   @end
