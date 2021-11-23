% Autores: Felipe Guzmán Avendaño - 201813791
%          Juan Nicolás Bolaños - 201911676
clc, clear all, close all

syms x y z;

z = (1 - x).^2 + 100*(y - x.^2).^2;

figure
ezsurf(x,y,z)
hold on;

%return;

x0=[0;10];  %valor inicial

x_old=x0;

grad_z=gradient(z) %gradiente
grad_z_eval=subs(grad_z, [x y], [x0(1), x0(2)]);
grad_z_eval_double=double(grad_z_eval);

hess_z=hessian(z) %Hessiano
hess_z_eval=subs(hess_z, [x y], [x0(1), x0(2)]);
hess_z_eval_double=double(hess_z_eval);

conv=0.001;  % convergencia

alfa=0.9;

cont=1;
while norm(grad_z_eval_double)>conv
    cont=cont+1;       
    paso = norm(grad_z_eval_double);

    grad_z_eval=subs(grad_z, [x y], [x_old(1) x_old(2)]);
    grad_z_eval_double=double(grad_z_eval);
    
    hess_z_eval=subs(hess_z, [x y], [x_old(1) x_old(2)]);
    hess_z_eval_double=double(hess_z_eval);

    x_new=x_old - (alfa * inv(hess_z_eval_double) * grad_z_eval_double);
    x_new_double=double(x_new);
      
    x_old=x_new_double;
    
    z_eval=subs(z, [x y], [x_old(1) x_old(2)]);
    z_eval_double=double(z_eval);
    
    plot3(x_old(1), x_old(2), z_eval_double, 'or')
    
end
