function dA = computedA(in1,in2)
dx = in2(1,:);
dy = in2(2,:);
dA = reshape([0.0,0.0,dx.*2.0,0.0,0.0,dy.*2.0],[3,2]);
