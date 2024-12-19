function a = compute_a(in1)
x = in1(1,:);
y = in1(2,:);
% t2 = x-2.0;
% t3 = y-1.0;
t2 = y.*2.0;
a = [t2-x; t2+x];
