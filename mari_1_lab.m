
fid = fopen('C:\Users\Mary\Desktop\lab_1\input.txt');

nextline = fgetl(fid);
[X,~] =str2num(tline);
tline = fgetl(fid);
[U,~] =str2num(tline);
tline = fgetl(fid);
[N,~] =str2num(tline);
tline = fgetl(fid);
[Y,~] =str2num(tline);


X= X';
U= U';
N= N';
Y= Y';
A = randi([10 50],size(X,1),size(X,1));
B = randi([10 50],size(X,1),size(U,1));
E = randi([10 50],size(X,1),size(N,1));
C = randi([10 50],size(Y,1),size(X,1));
D = randi([10 50],size(Y,1),size(U,1));
F = randi([10 50],size(Y,1),size(N,1));


X = A*X + B*U + E*N; 
Y = C*X + D*U + F*N;



fclose(fid);
