function A = computeA(in1)

x = in1(1,:);
y = in1(2,:);
A = reshape([0.0,1.0,x.*2.0-4.0,1.0,1.0,y.*2.0-2.0],[3,2]);
