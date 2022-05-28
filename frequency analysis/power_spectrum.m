data = readmatrix('E:\projects\exchange rate\USD_LKR Historical Data monthly correct order.csv');
%data = data(701:end,:);
t=linspace(1990,2022,size(data,1));
s1 = data(:,2);
s2 = data(:,3);
s3 = data(:,4);
s4 = data(:,5);

x=[s1' ; s2' ; s3' ; s4' ];

pspectrum((s1+s2+s3+s4)/4);
specrogam((s1+s2+s3+s4)/4);
periodogram((s1+s2+s3+s4)/4);