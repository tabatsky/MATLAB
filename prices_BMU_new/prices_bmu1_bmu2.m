[bmu1_prices, bmu1_names, bmu1_coefs, bmu1_coef_units, time, dates] = load_bmu1;
[bmu2_prices, bmu2_names, bmu2_coefs, bmu2_coef_units, time, dates] = load_bmu2;

bmu0_prices = [bmu1_prices bmu2_prices];
bmu0_names = [bmu1_names bmu2_names];
bmu0_coefs = [bmu1_coefs bmu2_coefs];
bmu0_coef_units = [bmu1_coef_units bmu2_coef_units];

[bmu1_rel, bmu1_norm, bmu1_mean, bmu1_std, bmu1_percent_std, bmu1_geom] = calc_relatives(bmu1_prices, time);
[bmu2_rel, bmu2_norm, bmu2_mean, bmu2_std, bmu2_percent_std, bmu2_geom] = calc_relatives(bmu2_prices, time);
[bmu0_rel, bmu0_norm, bmu0_mean, bmu0_std, bmu0_percent_std, bmu0_geom] = calc_relatives(bmu0_prices, time);

[bmu1_xx_norm, bmu1_A_norm] = calc_DP(bmu1_norm);
bmu1_xx_norm = bmu1_xx_norm ./ bmu1_mean';
bmu1_xx_norm = bmu1_xx_norm / sum(bmu1_xx_norm);

[bmu2_xx_norm, bmu2_A_norm] = calc_DP(bmu2_norm);
bmu2_xx_norm = bmu2_xx_norm ./ bmu2_mean';
bmu2_xx_norm = bmu2_xx_norm / sum(bmu2_xx_norm);

[bmu0_xx_norm, bmu0_A_norm] = calc_DP(bmu0_norm);
bmu0_xx_norm = bmu0_xx_norm ./ bmu0_mean';
bmu0_xx_norm = bmu0_xx_norm / sum(bmu0_xx_norm);

[bmu1_xx_rel, bmu1_A_rel] = calc_DP(bmu1_rel);
[bmu2_xx_rel, bmu2_A_rel] = calc_DP(bmu2_rel);
[bmu0_xx_rel, bmu0_A_rel] = calc_DP(bmu0_rel);

USD_per_bmu1_DP_rel = bmu1_prices*(bmu1_xx_rel);
USD_per_bmu2_DP_rel = bmu2_prices*(bmu2_xx_rel);
USD_per_bmu0_DP_rel = bmu0_prices*(bmu0_xx_rel);

USD_per_bmu1_DP_rel = USD_per_bmu1_DP_rel/USD_per_bmu1_DP_rel(1)*100;
USD_per_bmu2_DP_rel = USD_per_bmu2_DP_rel/USD_per_bmu2_DP_rel(1)*100;
USD_per_bmu0_DP_rel = USD_per_bmu0_DP_rel/USD_per_bmu0_DP_rel(1)*100;

USD_per_bmu1_DP_norm = bmu1_prices*(bmu1_xx_norm);
USD_per_bmu2_DP_norm = bmu2_prices*(bmu2_xx_norm);
USD_per_bmu0_DP_norm = bmu0_prices*(bmu0_xx_norm);

USD_per_bmu1_DP_norm = USD_per_bmu1_DP_norm/USD_per_bmu1_DP_norm(1)*100;
USD_per_bmu2_DP_norm = USD_per_bmu2_DP_norm/USD_per_bmu2_DP_norm(1)*100;
USD_per_bmu0_DP_norm = USD_per_bmu0_DP_norm/USD_per_bmu0_DP_norm(1)*100;

bmu1_geom = bmu1_geom/bmu1_geom(1)*100;
bmu2_geom = bmu2_geom/bmu2_geom(1)*100;
bmu0_geom = bmu0_geom/bmu0_geom(1)*100;

% Критерий. Цена ДП должна достаточно точно аппроксимировать среднее геометрическое всех цен: 

figure;
subplot(3,1,1);
title('ДП1 критерий');
plot(dates, [USD_per_bmu1_DP_rel USD_per_bmu1_DP_norm bmu1_geom]);
subplot(3,1,2);
title('ДП2 критерий');
plot(dates, [USD_per_bmu2_DP_rel USD_per_bmu2_DP_norm bmu2_geom]);
subplot(3,1,3);
title('ДП0 критерий');
plot(dates, [USD_per_bmu0_DP_rel USD_per_bmu0_DP_norm bmu0_geom]);

% Wrong method:
%[bmu1_xx_, bmu1_A_] = calc_DP_2(bmu1_rel, bmu1_mean);

bmu1_xx = bmu1_xx_norm;
bmu2_xx = bmu2_xx_norm;
bmu0_xx = bmu0_xx_norm;

%bmu1_DP = bmu1_norm*bmu1_xx;
%bmu2_DP = bmu2_norm*bmu2_xx;

%figure;
%subplot(2,1,1);
%plot(real_time, f_m_DP/mean(f_m_DP));
%subplot(2,1,2);
%plot(real_time, foods_DP/mean(foods_DP));
USD_per_bmu1_DP = bmu1_prices*(bmu1_xx);
USD_per_bmu2_DP = bmu2_prices*(bmu2_xx);
USD_per_bmu0_DP = bmu0_prices*(bmu0_xx);

%bmu1_prices(1, :) * bmu1_xx/USD_per_bmu1_DP(1)*100
%bmu2_prices(1, :) * bmu2_xx/USD_per_bmu2_DP(1)*100

bmu1_res = print_DP(bmu1_xx/USD_per_bmu1_DP(1)*100, bmu1_names, bmu1_coefs, bmu1_coef_units);
bmu2_res = print_DP(bmu2_xx/USD_per_bmu2_DP(1)*100, bmu2_names, bmu2_coefs, bmu2_coef_units);
bmu0_res = print_DP(bmu0_xx/USD_per_bmu0_DP(1)*100, bmu0_names, bmu0_coefs, bmu0_coef_units);

USD_per_bmu1_DP = USD_per_bmu1_DP/USD_per_bmu1_DP(1)*100;
USD_per_bmu2_DP = USD_per_bmu2_DP/USD_per_bmu2_DP(1)*100;
USD_per_bmu0_DP = USD_per_bmu0_DP/USD_per_bmu0_DP(1)*100;

bmu1_per_bmu2 = USD_per_bmu2_DP./USD_per_bmu1_DP;

figure;
subplot(2,1,1);
plot(dates, [USD_per_bmu1_DP USD_per_bmu2_DP USD_per_bmu0_DP]);
title('ДП1, ДП2, ДП0');
subplot(2,1,2);
plot(dates, bmu1_per_bmu2);
title('ДП1/ДП2');
