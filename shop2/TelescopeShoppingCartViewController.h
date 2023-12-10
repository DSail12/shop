//
//  TelescopeShoppingCartViewController.h
//  shop2
//
//  Created by Eugene Zvyagin on 10.12.2023.
// 

#import <UIKit/UIKit.h>

@interface TelescopeShoppingCartViewController : UITableViewController

//Резервное копирование корзины

@property (nonatomic,strong) NSMutableDictionary *backupCart;

@end
