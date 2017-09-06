function [all_goods, all_names, all_coefs, all_coef_units, time, real_time] = load_foods()
    %xls = readtable('data_1960_2014_foods.csv');
    xls = xlsread('data_1960_2014_foods.xlsx');
   
    ii = 1:711;
    jj = 1:13:711;
    ii(jj) = [];

    data = xls(ii,2:22);

    time = 1:656;
    real_time = 1960 + time/12; 

    barley = data(:,1); % Ячмень
    cocoa = data(:,2); % Какао
    coffee_arabica = data(:,3); % Кофе Арабика
    coffee_robusta = data(:,4); % Кофе Робуста
    cotton = data(:,5); % Хлопок
    logs = data(:,6); % Дрова
    maize = data(:,7); % Кукуруза
    beef = data(:,8); % Говядина
    chicken = data(:,9); % Курица
    rice = data(:,10); % Рис
    sorghum = data(:,11); % Сорго
    soybeans = data(:,12); % Соя
    sugar_eu = data(:,13); % Сахар
    sugar_us = data(:,14); % Сахар
    sugar_world = data(:,15); % Сахар
    tea_colombo = data(:,16); % Чай
    tea_kokata = data(:,17); % Чай
    tea_mombasa = data(:,18); % Чай
    tea_average = data(:,19); % Чай
    tobacco = data(:,20); % Табак
    wheat = data(:,21); % Пшеница

    goods1 = [barley maize rice sorghum soybeans wheat];
    names1 = {'Ячмень','Кукуруза','Рис','Сорго','Соя','Пшеница'};
    coefs1 = [10^6 10^6 10^6 10^6 10^6 10^6];
    coef_units1 = {'г','г','г','г','г','г'};
    goods2 = [cotton logs coffee_arabica cocoa sugar_world tea_average tobacco];
    names2 = {'Хлопок','Дрова','Кофе','Какао','Сахар','Чай','Табак'};
    coefs2 = [10^3 10^3 10^3 10^3 10^3 10^3 10^6];
    coef_units2 = {'г','куб. дм','г','г','г','г','г'};
    goods3 = [beef chicken];
    names3 = {'Говядина','Курица'};
    coefs3 = [10^3 10^3];
    coef_units3 = {'г','г'};

    all_goods = [goods1 goods2 goods3];    
    all_names = [names1 names2 names3];
    all_coefs = [coefs1 coefs2 coefs3];
    all_coef_units = [coef_units1 coef_units2 coef_units3];
    
    %all_goods = table2array(all_goods); 
end