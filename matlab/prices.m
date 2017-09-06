xls = xlsread('data.xlsx');

time = 1:399;
real_time = 1979 + time/12; 

data = xls(time,2:23);

oil = data(:,1);
gold = data(:,2);
iron = data(:,3);
logs = data(:,4);
maize = data(:,5);
beef = data(:,6);
chicken = data(:,7);
gas = data(:,8);
liquid_gas = data(:,9);
tea = data(:,10);
tobacco = data(:,11);
wheat = data(:,12);
sugar = data(:,13);
soy = data(:,14);
silver = data(:,15);
rice = data(:,16);
platinum = data(:,17);
cotton = data(:,18);
copper = data(:,19);
coffee = data(:,20);
coal = data(:,21);
aluminum = data(:,22);

%all_goods = [oil gold iron logs maize beef chicken gas liquid_gas tea tobacco wheat sugar soy silver rice platinum cotton copper coffee coal aluminum];
all_goods = [oil gold logs maize beef chicken gas tea tobacco wheat sugar soy rice cotton copper coffee coal];
    
goods_count = size(all_goods, 2);

geom_average = ones(size(time))';

for i = 1:goods_count 
    geom_average = geom_average .* all_goods(:,i);
end

geom_average = geom_average .^ (1/goods_count);

all_goods_rel = zeros(size(all_goods));
all_goods_norm = zeros(size(all_goods));

mean_ = zeros(1,goods_count);
std_ = zeros(1,goods_count);
percent_std_ = zeros(1,goods_count);

for i = 1:goods_count
    all_goods_rel(:,i) = all_goods(:,i) ./ geom_average;
    mean_(i) = mean(all_goods_rel(:,i));
    all_goods_norm(:,i) = all_goods_rel(:,i) / mean_(i);
    std_(i) = std(all_goods_rel(:,i));
    percent_std_(i) = 100*std_(i)/mean_(i);
end

%figure;

%plot(real_time, all_goods_norm');
%axis([real_time(1) real_time(end) 0.0 5.0]);

% В идеале, оба методы должны давать одинаковый результат
% Но в связи с тем, что в матрице A_norm значения имеют одинаковый порядок
% А в матрице A_rel порядки значений могут сильно различаться
% А также в связи с тем, что точность вычисления в матлабе ограничена
% Результат метода с A_rel более точный
% На некоторых наборах из-за погрешности вычислений с A_rel
% Компоненты вектора x могут принимать отрицательные значения
% И соответствующие им товары не попадают в ДП
% В методе с A_norm такого быть не должно

A_rel = cov(all_goods_rel);
A_norm = cov(all_goods_norm);

cond = ones(1, goods_count);

B_rel = [2*A_rel cond'];
B_rel = [B_rel; [cond 0]];

B_norm = [2*A_norm cond'];
B_norm = [B_norm; [cond 0]];

b = [zeros(1, goods_count) 1]';
x_rel = (B_rel^-1)*b;
x_norm = (B_norm^-1)*b;

x_rel = x_rel(1:goods_count);
x_norm = x_norm(1:goods_count);
x_norm = x_norm./mean_';
x_norm = x_norm/sum(x_norm);

x = x_norm;

DP = all_goods_rel*x;

figure;

subplot(2,1,1);
plot(real_time, DP'/mean(DP));
axis([real_time(1) real_time(end) 0.8 1.2]);

DP_mean = mean(DP)
DP_std = std(DP)
DP_percent_std = 100*std(DP)/mean(DP)

USD_per_DP_norm_ = all_goods*x_norm;
USD_per_DP_rel_ = all_goods*x_rel;

USD_per_DP = all_goods*x;

subplot(2,1,2);
plot(real_time, USD_per_DP);

% Критерий. Цена ДП должна достаточно точно аппроксимировать среднее геометрическое всех цен: 
figure;
plot(real_time, [geom_average/geom_average(1) USD_per_DP_norm_/USD_per_DP_norm_(1) USD_per_DP_rel_/USD_per_DP_rel_(1)]);

return;

debt_xls = xlsread('usa_debt.xlsx');

debt_time = debt_xls(:,1);
end_index = size(debt_time,1);
start_index = (1:end_index)*(debt_time == 1978);
debt_time = debt_time(start_index:end_index);

debt_usd = debt_xls(start_index:end_index,2);
debt_percent = debt_xls(start_index:end_index,3);

debt_time = debt_time + 1; % данные о долге даны на конец года, что равносильно началу следующего

figure;
subplot(2,1,1);
plot(debt_time, debt_usd);
subplot(2,1,2);
plot(debt_time, debt_percent);

a = 1;
b = ones(1,24)/24;

debt_interp = interp1(debt_time, debt_percent, real_time, 'cubic')';
USD_per_DP_mov_av = filter(b, a, USD_per_DP);

debt_and_DP = [USD_per_DP_mov_av/mean(USD_per_DP_mov_av) debt_interp/mean(debt_interp)];

debt_DP_corr = corr2(debt_and_DP(:,1),debt_and_DP(:,2))

figure;
plot(real_time, debt_and_DP);