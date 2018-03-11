
fid = fopen('C:\Users\Mary\Desktop\dynamic-model-master\input.txt');

tline = fgetl(fid);
[X,~] =str2num(tline);
tline = fgetl(fid);
[U,~] =str2num(tline);
tline = fgetl(fid);
[N,~] =str2num(tline);
tline = fgetl(fid);
[Y,~] =str2num(tline);
tline = fgetl(fid);
[T,~] =str2num(tline);

X= X';
U= U';
N= N';
Y= Y';

A = randn(size(X,1),size(X,1));
% A=[[-0.03333333 0.1 0.01666667 0.2 0.26666667 0.02 ]
% [ 0.33333333 0.03333333 -0.33333333 0.33333333 0.06666667 0.33333333]
% [-0.33333333 -0.33333333 -0.2 0.33333333 0.1 0.16666667]
% [ 0.02333333 -0.03 0.33333333 0.06666667 -0.16666667 -0.26666667]
% [ 0.33333333 -0.33333333 0.23333333 0.3 -0.3 -0.1 ]
% [ 0.33333333 0.33333333 0.26666667 0.16666667 0.13333333 0.06666667]];


B = randn(size(X,1),size(U,1));
E = randn(size(X,1),size(N,1));
C = randn(size(Y,1),size(X,1));
D = randn(size(Y,1),size(U,1));
F = randn(size(Y,1),size(N,1));

outputs=[];

t=0;
while t < T
    X = A*X + B*U + E*N; 
    Y = C*X + D*U + F*N;
    t=t+1;
    outputs=[outputs,Y];
end

dlmwrite('C:\Users\Mary\Desktop\dynamic-model-master\output.txt', Y);
fclose(fid);

stability=0;
e=eig(A);
for i=1:size(e,1) 
    if abs(e(i))>1
       stability=1;
    elseif (abs(e(i))==1) && (stability~=1) 
        stability=2;
    end
end

switch stability
    case 0  
        disp('Система устойчива')
    case 1 
        disp('Система неустойчива')
    case 2 
        disp('Система на границе устойчивости')
end

time=0:(T-1); 
plot(time,outputs);

    