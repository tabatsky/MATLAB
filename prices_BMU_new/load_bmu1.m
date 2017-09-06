function [all_goods, all_names, all_coefs, all_coef_units, time, realtime] = load_bmu1()
    xls = xlsread('BMU1_prices.xlsx');

    ii = 1:297;
    
    data = xls(ii, 2:18);
    
    time = ii;
    realtime = 1992 + 10/12 + time/12;

    gold = data(:,1); 
    silver = data(:,2); 
    platinum = data(:,3); 
    palladium = data(:,4);
    iridium = data(:,5); 
    rhodeum = data(:,6); 
    rhutenium = data(:,7);
    
    aluminum = data(:,8); 
    copper = data(:,9);  
    iron_ore = data(:,10); 
    lead = data(:,11); 
    nickel = data(:,12);
    tin = data(:,13);
    zinc = data(:,14);
    
    oil = data(:,15);
    gas = data(:,16);
    coal = data(:,17);
    
    goods1 = [gold silver platinum palladium iridium rhodeum rhutenium];
    names1 = {'Золото', 'Серебро', 'Платина', 'Палладий', 'Иридий', 'Родий', 'Рутений'};
    coefs1 = [31.1034768*1, 31.1034768, 31.1034768*1, 31.1034768*1, 31.1034768*1, 31.1034768*1, 31.1034768*1];
    coef_units1 = {'г','г', 'г', 'г', 'г', 'г', 'г'};
    goods2 = [aluminum copper iron_ore lead nickel tin zinc];
    names2 = {'Алюминий','Медь','Железная руда','Свинец','Никель','Олово','Цинк'};
    coefs2 = [10^3, 10^3, 10^3, 10^3, 10^3, 10^3, 10^3];
    coef_units2 = {'кг','кг','кг','кг','кг','кг','кг'};
    goods3 = [oil gas coal];
    names3 = {'Нефть','Газ','Уголь'};
    coefs3 = [155.988, 1000, 10^3];
    coef_units3 = {'л','тыс. БТЕ','кг'};

    all_goods = [goods1 goods2 goods3];    
    all_names = [names1 names2 names3];
    all_coefs = [coefs1 coefs2 coefs3];
    all_coef_units = [coef_units1 coef_units2 coef_units3];
end