function getAverageMouseInput(f)

% f in a row/column vector 
% We will find the average from one row/column to another row/column

close all;
data = f(:,1);
plot(data);
[x, y] = ginput(2)
mean(data(x(1):x(2)))

end