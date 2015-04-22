function numplot(pos,values, color, ptype)
% numplot(positions,values, color)
%
% plot values at positions on current plot window

if nargin < 4, ptype = 'gx'; end

if (nargin <= 2) 
 color = [0 0 0];
elseif (size(color,2) ~= 3)
 color = [0 0 0];
end

if nargin <= 1
 values = 1:size(pos,1);
end

for l = values
labels = str2mat(labels, num2str(l));
end
labels = labels(2:length(values)+1,:);

text(pos(:,1),pos(:,2),labels,'color',color);
hold;
plot(pos(:,1),pos(:,2), ptype);
hold;
