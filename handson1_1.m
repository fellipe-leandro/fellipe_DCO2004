clear all;
t = 1:10;
f = 10;
s = cos(2*pi*f*t);
z = s + cos(2*pi*0.5*f*t);
chDisplays = ['O valor máximo de s é ' num2str(max(s))];
disp(chDisplays);
chDisplayz = ['O valor máximo de z é ' num2str(max(z))];
disp(chDisplayz);