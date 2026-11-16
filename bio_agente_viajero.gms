
set
i /1*7/;

alias(i,j);

table c(i,j) *Tabla de costos

        1  2  3  4  5  6  7
    1   99 12 10 99 99 99 12
    2   12 99 8  12 99 99 99
    3   10 8  99 11 03 99 9
    4   99 12 11 99 11 10 99
    5   99 99 3  11 99 6  7
    6   99 99 99 10 6  99 9
    7   12 99 9  99 7  9  99;

variable z;
binary Variable x(i,j);
Positive variable u(i);
u.fx('1')=1;

Equations
    obj
    r1
    r2
    sub;
obj.. z=e=sum((i,j),c(i,j)*x(i,j));
r1(j).. sum(i,x(i,j))=e=1;
r2(i).. sum(j,x(i,j))=e=1;
*prevención de subtours
sub(i,j)$(ord(i)>1 and ord(j)>1 and ord(i)<>ord(j)).. u(i)-u(j)+card(i)*x(i,j)=l=card(i)-1;

model tsp /all/;
solve tsp using mip minimizing z;
display z.l,x.l, u.l;
