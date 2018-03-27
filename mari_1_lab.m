
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
X0 = X;
U= U';
N= N';
Y= Y';
Y0=Y;

%A = randn(size(X,1),size(X,1));
A=[[-0.03333333 0.1 0.01666667 0.2 0.26666667 0.02 ]
[ 0.33333333 0.03333333 -0.33333333 0.33333333 0.06666667 0.33333333]
[-0.33333333 -0.33333333 -0.2 0.33333333 0.1 0.16666667]
[ 0.02333333 -0.03 0.33333333 0.06666667 -0.16666667 -0.26666667]
[ 0.33333333 -0.33333333 0.23333333 0.3 -0.3 -0.1 ]
[ 0.33333333 0.33333333 0.26666667 0.16666667 0.13333333 0.06666667]];


B = randn(size(X,1),size(U,1));
E = randn(size(X,1),size(N,1));
C = randn(size(Y,1),size(X,1));
D = randn(size(Y,1),size(U,1));
F = randn(size(Y,1),size(N,1));

outputs=[];
states=[];
outputs0=[];

t=0;
while t < T
    X = A*X + B*U + E*N; 
    Y = C*X + D*U + F*N;
    t=t+1;
    outputs=[outputs,Y];
    states=[states,X];
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

window = 3;
alpha=1/window;

length_y = length(outputs);
MMAy = zeros(1, length_y);
MMAy(1) = outputs(1);
for i=2:length_y
     MMAy(i) = alpha*outputs(i) + (1-alpha)*MMAy(i-1);
end

hold on;
plot(MMAy);

tpp=0;
overshoot=0;
final_value=0;

if (stability==0) 
t=0;
    while t < 10000
        X0 = A*X0 + B*U + E*N; 
        Y0 = C*X0 + D*U + F*N;
        t=t+1;
        outputs0=[outputs0,Y0];
    end
final_value=outputs0(end);
overshoot=100*(max(outputs0)-final_value)/final_value;

for i=1:length(outputs0)
    if abs(outputs0(i)-final_value)/final_value > 0.05
        tpp=i;
    end    
end

end 

 disp(overshoot); 
 disp(tpp);
 disp(final_value);