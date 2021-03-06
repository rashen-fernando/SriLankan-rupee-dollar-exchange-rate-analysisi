data = readmatrix('E:\projects\exchange rate\USD_LKR Historical Data monthly correct order.csv');
%data = data(701:end,:);
t=linspace(1990,2022,size(data,1));
s1 = data(:,2);
s2 = data(:,3);
s3 = data(:,4);
s4 = data(:,5);

x=[s1' ; s2' ; s3' ; s4' ];

%x=x.*x;  %making it nonlinear
%plot(t,x);title('Rupee vs Dollar 1990 to 2022');legend('price','open','high','low');

S  =cov(x'); 
[V,D]   = eigs(S);
Y   = V'*x;
% 
plot(t,Y);title('DATA projected on to principal componant axis');;legend('PCA 1','PCA 2','PCA 3','PCA 4')%hold on;
% axis equal;