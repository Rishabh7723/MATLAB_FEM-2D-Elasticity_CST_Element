function plotField(x, y, titleStr, yLabelStr)
%PLOTFIELD Simple 1D line plot for a field variable.
%   plotField(x, y, titleStr, yLabelStr)
if nargin < 4 || isempty(yLabelStr)
    yLabelStr = 'Field value';
end

figure;
plot(x, y, '-o', 'LineWidth', 2, 'MarkerSize', 6);
xlabel('x');
ylabel(yLabelStr);
grid on;
title(titleStr);
end
