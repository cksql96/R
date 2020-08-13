
i= 13;
l= 10;
sum = i + l;
sum;

x = rnorm(100);
#rnorm - random normaility
y = hist(x, probability = T, breaks = 5)
# break = 몇개까지 나타낸다(근데 부정확)
lines(density(x),type='h',col=5);
# type은 타입. 채우는 타입. h s 등, col은 색깔.

shapiro.test(x);



##################################################################ㅁㅁ
##################################################################ㅁㅁ

가<- 2;
가 = 1;
가+3;
가+가;
f='바보';
f="밥오babo";
f;
f=3.141591;
f=1/4;

var1=c(1,2,5,7,9);   #c는 combine 배열같은거임.
var1;





var2=c(1:5);         #x : y -> x 부터 5까지
var2;

var3=seq(1,5,by=2);  #seq은 sequence 1부터 5까지, 2씩 증가.1 (1+2) (1+2+2)
var3;

str1=c('a','b','c');
str1;
str2=c('hello','world','is','good');
str2;

a=c(1,3,5,7,9);
a;
mean(a);
sd(a);
var(a);
min(a);
max(a);

paste(str2,collapse = ' ');  #paste는 (무엇을,collapse[붙인다] = ' ') 띄어쓰기로 붙인다.
paste(str2,collapse = '|');
