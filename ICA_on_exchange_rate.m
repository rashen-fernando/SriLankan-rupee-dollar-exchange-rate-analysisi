%opts = delimitedTextImportOptions('E:\projects\STOCK MARKET ICA\DIPD Historical Data.csv');
data = readmatrix('E:\projects\exchange rate\USD_LKR Historical Data.csv');
data = data(701:end,:);
t=(1:size(data,1));
s1 = data(:,2);
s2 = data(:,3);
s3 = data(:,4);
s4 = data(:,5);

X=[s1' ; s2' ; s3' ; s4' ];

m=mean(X');
X=X'-m;
[E,D] = eigs(cov(X));
X_white = E * sqrt(inv(D)) * E' * X';
X=abs(X_white);


lr = 0.001;

W1 = rand(1,4) %size 1 2
W2 = rand(1,4)

estimate1 = W1*X;
kurt1 =abs( kurtosis(estimate1) );
estimate2 = W2*X;
kurt2 =abs( kurtosis(estimate2) );


dkurt_w1_1 = rand; %random initialization
dkurt_w1_2 = rand;
dkurt_w1_3 = rand;
dkurt_w1_4 = rand;
dW1 = [dkurt_w1_1 dkurt_w1_2 dkurt_w1_3 dkurt_w1_4];

dkurt_w2_1 = rand; %random initialization
dkurt_w2_2 = rand;
dkurt_w2_3 = rand;
dkurt_w2_4 = rand;
dW2 = [dkurt_w2_1 dkurt_w2_2 dkurt_w2_3 dkurt_w2_4];

W3 = rand(1,4) %size 1 2
W4 = rand(1,4)

estimate3 = W3*X;
kurt3 =abs( kurtosis(estimate3) );
estimate4 = W4*X;
kurt4 =abs( kurtosis(estimate4) );


dkurt_w3_1 = rand; %random initialization
dkurt_w3_2 = rand;
dkurt_w3_3 = rand;
dkurt_w3_4 = rand;
dW3 = [dkurt_w3_1 dkurt_w3_2 dkurt_w3_3 dkurt_w3_4];

dkurt_w4_1 = rand; %random initialization
dkurt_w4_2 = rand;
dkurt_w4_3 = rand;
dkurt_w4_4 = rand;
dW4 = [dkurt_w4_1 dkurt_w4_2 dkurt_w4_3 dkurt_w4_4];

for i = 1:100
    prev_kurt1 = kurt1;
    prev_kurt2 = kurt2;
    prev_W1 = W1;
    prev_W2 = W2;
    
    W1 = W1+lr*dW1;
    W2 = W2+lr*dW2;
    
    estimate1 = W1*X;
    estimate2 = W2*X;
    kurt1 =abs( kurtosis(estimate1) );
    kurt2 =abs( kurtosis(estimate2) );
    
    dkurt_w1_1  = (kurt1-prev_kurt1)/(W1(1,1)-prev_W1(1,1));
    dkurt_w1_2  = (kurt1-prev_kurt1)/(W1(1,2)-prev_W1(1,2));
    dkurt_w1_3  = (kurt2-prev_kurt1)/(W1(1,3)-prev_W1(1,3));
    dkurt_w1_4  = (kurt2-prev_kurt1)/(W1(1,4)-prev_W1(1,4));
    
    dkurt_w2_1  = (kurt1-prev_kurt2)/(W2(1,1)-prev_W2(1,1));
    dkurt_w2_2  = (kurt1-prev_kurt2)/(W2(1,2)-prev_W2(1,2));
    dkurt_w2_3  = (kurt2-prev_kurt2)/(W2(1,3)-prev_W2(1,3));
    dkurt_w2_4  = (kurt2-prev_kurt2)/(W2(1,4)-prev_W2(1,4));
    
    dW1 = [dkurt_w1_1 dkurt_w1_2 dkurt_w1_3 dkurt_w1_4];
    dW2 = [dkurt_w2_1 dkurt_w2_2 dkurt_w2_3 dkurt_w2_4];
    
    prev_kurt3 = kurt3;
    prev_kurt4 = kurt4;
    prev_W3 = W3;
    prev_W4 = W4;
    
    W3 = W3+lr*dW3;
    W4 = W4+lr*dW4;
    
    estimate3 = W3*X;
    estimate4 = W4*X;
    kurt3 =abs( kurtosis(estimate3) );
    kurt4 =abs( kurtosis(estimate4) );
    
    dkurt_w3_1  = (kurt3-prev_kurt3)/(W3(1,1)-prev_W3(1,1));
    dkurt_w3_2  = (kurt3-prev_kurt3)/(W3(1,2)-prev_W3(1,2));
    dkurt_w3_3  = (kurt4-prev_kurt3)/(W3(1,3)-prev_W3(1,3));
    dkurt_w3_4  = (kurt4-prev_kurt3)/(W3(1,4)-prev_W3(1,4));
    
    dkurt_w4_1  = (kurt3-prev_kurt4)/(W4(1,1)-prev_W4(1,1));
    dkurt_w4_2  = (kurt3-prev_kurt4)/(W4(1,2)-prev_W4(1,2));
    dkurt_w4_3  = (kurt4-prev_kurt4)/(W4(1,3)-prev_W4(1,3));
    dkurt_w4_4  = (kurt4-prev_kurt4)/(W4(1,4)-prev_W4(1,4));
    
    dW3 = [dkurt_w3_1 dkurt_w3_2 dkurt_w3_3 dkurt_w3_4];
    dW4 = [dkurt_w4_1 dkurt_w4_2 dkurt_w4_3 dkurt_w4_4];
    scatter(i,kurt1,'r');hold on;scatter(i,kurt2,'b');hold on;scatter(i,kurt3,'y');hold on;scatter(i,kurt4,'g');xlabel('iteration');ylabel('kurtosis');legend('kurtosis1','kurtosis2','kurtosis3','kurtosis4');
end

% subplot(8,1,1)
% plot(t,s1,'b');
% ylabel('source 1');xlabel('time');
% 
% 
% subplot(8,1,2)
% plot(t,s2,'b');
% ylabel('source 2');xlabel('time');
% 
% subplot(8,1,3)
% plot(t,s3,'b');
% ylabel('source 3');xlabel('time');
% 
% subplot(8,1,4)
% plot(t,s4,'b');
% ylabel('source 4');xlabel('time');
% 
% subplot(8,1,5)
% plot(t,estimate1,'r');
% ylabel('estimate1');xlabel('time');
% 
% subplot(8,1,6)
% plot(t,estimate2,'r');
% ylabel('estimate2');xlabel('time');
% 
% subplot(8,1,7)
% plot(t,estimate3,'r');
% ylabel('estimate3');xlabel('time');
% 
% subplot(8,1,8)
% plot(t,estimate4,'r');
% ylabel('estimate4');xlabel('time');
% 
% 
