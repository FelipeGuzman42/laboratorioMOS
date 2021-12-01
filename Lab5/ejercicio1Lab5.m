syms x y;

y=x^5 - 8*x^3 + 10*x + 6;
d1_y=diff(y); %primera derivada
d2_y=diff(d1_y); %segunda derivada
figure;
ezplot(y);
xlim([-3 3]);
ylim([-10 20]);
grid("on");
hold on;
%return;
alfa=0.1;
dx_conv=0.001;  % convergencia
x0=-2.5;  %valor inicial
x_old=x0;
x_values = [];
y_values = [];

cont=1;
for i=-3:3
    x_old = i;
    d1_y_eval_double=subs(d1_y, x, x_old);
    while abs(d1_y_eval_double)>dx_conv
        cont=cont+1;       
        d1_y_eval=subs(d1_y,x_old); 
        d1_y_eval_double=double(d1_y_eval);
        d2_y_eval=subs(d2_y,x_old);
        d2_y_eval_double=double(d2_y_eval);
        x_new=x_old - alfa*(d1_y_eval_double/d2_y_eval_double);
        x_new_double=double(x_new);
        x_old=x_new_double;
        y_eval=subs(y,x_old);
        y_eval_double=double(y_eval);
        plot(x_old, y_eval_double, 'or')
    end
    eval = subs(y,x, x_old);
    x_values = [x_values x_old];
    y_values = [y_values eval];
end


y_coor=double(subs(y,x_new_double));

plot(x_new_double,y_coor,'o')
max_global = find(y_values == max(y_values));
min_global = find(y_values == min(y_values));
fprintf("Mínimo global: %f\n", x_values(min_global));
fprintf("Máximo global: %f", x_values(max_global));