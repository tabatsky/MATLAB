function [all_goods, all_names, all_coefs, all_coef_units, time, realtime] = load_bmu1()
    xls = xlsread('BMU2_prices.xlsx');

    ii = 154:450;
    
    data = xls(ii, 2:25);
    
    time = ii - ii(1) + 1;
    realtime = 1992 + 10/12 + time/12;

    barley = data(:,1); 
    rice = data(:,2); 
    wheat = data(:,3); 
    
    beef = data(:,4);
    chicken = data(:,5); 
    pork = data(:,6); 
    
    coarse_wool = data(:,7);
    
    salmon = data(:,8); 
    shrimp = data(:,9);  
    fishmeal = data(:,10); 
    
    coffee = data(:,11); 
    cacao = data(:,12);
    tea = data(:,13);
    sugar = data(:,14);
    
    peanuts = data(:,15);
    oranges = data(:,16);
    bananas = data(:,17);
    
    sun_oil = data(:,18);
    olive_oil = data(:,19);
    palm_oil = data(:,20);
    
    hard_logs = data(:,21);
    soft_logs = data(:,22);
    rubber = data(:,23);
    
    cotton = data(:,24);
    
    
    goods1 = [barley rice wheat beef chicken pork coarse_wool];
    names1 = {'Ячмень', 'Рис', 'Пшеница', 'Говядина', 'Курица', 'Свинина', 'Грубая шерсть'};
    coefs1 = [1000, 1000, 1000,  45.359237, 45.359237, 45.359237, 100];
    coef_units1 = {'кг','кг', 'кг', 'кг', 'кг', 'кг', 'кг'};
    goods2 = [salmon shrimp fishmeal coffee cacao tea sugar];
    names2 = {'Лосось','Креветки','Рыбная мука','Кофе','Какао','Чай','Сахар'};
    coefs2 = [1, 45.359237, 1000, 45.359237, 1000, 100, 45.359237];
    coef_units2 = {'кг','кг','кг','кг','кг','кг','кг'};
    goods3 = [peanuts oranges bananas sun_oil olive_oil palm_oil];
    names3 = {'Арахис','Апельсины','Бананы', 'Подсолнечное масло', 'Оливковое масло', 'Пальмовое масло'};
    coefs3 = [1000, 1000, 1000, 1000, 1000, 1000];
    coef_units3 = {'кг','кг','кг','кг','кг','кг'};
    goods4 = [hard_logs soft_logs rubber cotton];
    names4 = {'Жесткие бревна','Мягкие бревна','Каучук','Хлопок'};
    coefs4 = [1000, 1000, 45.359237, 45.359237];
    coef_units4 = {'куб.дм','куб.дм','кг','кг'};
    
    all_goods = [goods1 goods2 goods3 goods4];    
    all_names = [names1 names2 names3 names4];
    all_coefs = [coefs1 coefs2 coefs3 coefs4];
    all_coef_units = [coef_units1 coef_units2 coef_units3 coef_units4];
end