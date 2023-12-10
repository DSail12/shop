//
//  TelescopeShoppingCartViewController.m
//  shop2
//
//  Created by Eugene Zvyagin on 10.12.2023.
// 

#import "TelescopeShoppingCartViewController.h"
#import "TelescopeShoppingItem.h"
#import "TelescopeShoppingCartCell.h"
#import "telescopeShoppingCart.h"

@interface TelescopeShoppingCartViewController ()

@property (nonatomic,weak) UIButton *deleteBtn;

@end

@implementation TelescopeShoppingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubview];
    self.tableView.rowHeight = 100;
    // Орентировочная высота строки чтобы избежать ячеек которые бы вышли в поле редактирования
    self.tableView.estimatedRowHeight = 20;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Удалить все ресурсы которые можно было бы восстановить
}

/**
 * Инициализация
 */
- (void)addSubview
{
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Редактировать" style:UIBarButtonItemStylePlain target:self action:@selector(enterEdittingMode)];
}

/**
 * Войти в режим редактирования
 */
- (void)enterEdittingMode
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Отмена" style:UIBarButtonItemStylePlain target:self action:@selector(cancelEditting)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"ОК" style:UIBarButtonItemStylePlain target:self action:@selector(confirmEditting)];
    
    //Добавить кнопку удаления
    UIButton *deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 40)];
    [deleteBtn addTarget:self action:@selector(deleteItem) forControlEvents:UIControlEventTouchUpInside];
    [deleteBtn setTitle:@"Удалить" forState:UIControlStateNormal];
    [deleteBtn setBackgroundColor:[UIColor redColor]];
    [deleteBtn setTintColor:[UIColor whiteColor]];
    [self.view.window addSubview:deleteBtn];
    self.deleteBtn = deleteBtn;
    [UIView animateWithDuration:0.5 animations:^{
        deleteBtn.transform = CGAffineTransformMakeTranslation(0, -deleteBtn.frame.size.height);
    }];
    //Уведомление
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Редактирование" object:nil];
    
    //Копирование резервное
    self.backupCart = [[TelescopeShoppingCart sharedShoppingCart].cart copy];
}
/**
 * Выйти из режима редактирования
 */
- (void)exitEdittingMode
{
    [UIView animateWithDuration:0.5 animations:^{
        self.deleteBtn.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self.deleteBtn removeFromSuperview];
    }];
    
    [self.tableView endEditing:YES];
    //Уведомление
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Закончить редактирование" object:nil];
    [self addSubview];
}

//Отменить редактирование, откатиться
- (void)cancelEditting
{
    [TelescopeShoppingCart sharedShoppingCart].cart = [self.backupCart mutableCopy];
    [self exitEdittingMode];
    NSIndexSet *section = [[NSIndexSet alloc] initWithIndex:0];
    [self.tableView reloadSections:section withRowAnimation:UITableViewRowAnimationBottom];
}
//Подтвердить изменения, перезаписать резервную копию

- (void)confirmEditting
{
    [self deleteItem];
    self.backupCart = [[TelescopeShoppingCart sharedShoppingCart].cart copy];
    [self exitEdittingMode];
}

//Удалить элемент
- (void)deleteItem
{
    NSLog(@"Удалить");
    NSMutableArray *deleteArr = [NSMutableArray array];
    for (TelescopeShoppingItem *item in [[TelescopeShoppingCart sharedShoppingCart] listAllItems]) {
        if (item.canDelete) {
            [deleteArr addObject:item.iP];
        }
    }
    if (deleteArr.count != 0) {
        [[TelescopeShoppingCart sharedShoppingCart] cleanCart];
        [self.tableView deleteRowsAtIndexPaths:deleteArr withRowAnimation:UITableViewRowAnimationBottom];
        //Для анимации
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }
}

/**
 * Прокрутите, чтобы выйти из режима редактирования
 */

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.tableView endEditing:YES];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[TelescopeShoppingCart sharedShoppingCart] listAllItems].count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TelescopeShoppingCartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cartCell"];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TelescopeShoppingCartCell" owner:self options:nil] lastObject];
    }
    
    TelescopeShoppingItem *item = [[TelescopeShoppingCart sharedShoppingCart] listAllItems][indexPath.row];
    //набор свойств для анимации
    item.iP = indexPath;
    cell.item = item;
    
    return cell;
}

- (void)dealloc
{
    NSLog(@"Удалить его?");
}

@end
