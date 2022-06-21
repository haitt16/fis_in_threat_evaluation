data = load('test2.txt');
fis = readfis('ThreatEvalution_sum');
y = evalfis(data,fis);
% y = data(:,2)
x= zeros(length(data),1);
for i = 1:length(data)    
    x(i,1) = i;
end
plot(x,y,'-');
disp(y)