###########디렉토리 바꾸기랑, 인스톨 페키지.
setwd("c:/Rdata");
install.packages("ggplot2");
require(ggplot2);
##Or library(ggplot2);
x=c('a','a','b','c');
x;
qplot(x);
qplot(data=mpg,x=hwy);      ##hwy, cty etc...

#####################################################연습연습
#5명 점수 집어넣기
다섯명점수=c(80,60,70,50,90);
#평균점수구하기
mean(다섯명점수);
#변수에 넣기
avg = mean(다섯명점수);

#######################데이터 프레임 사용
english = c(90,80,60,70);
math = c(50,60,100,20);
df_midterm = data.frame(english,math);
df_midterm;

df_midterm$english;
df_midterm$math;

mean(df_midterm$math);
mean(df_midterm$english);

df_midterm=data.frame(english,math,class=c(1,1,2,2));
df_midterm;

제품=c('사과','딸기','수박');
가격=c(1800,1500,3000);
판매량=c(24,38,13);

temp=data.frame(제품,가격,판매량);

temp;

price_avg=mean(temp$가격);
sell_avg=mean(temp$판매량);

price_avg;
sell_avg;

####################Or!!!
#대소문자 구분함.
Temp=data.frame(product=c(1,2,3,4), 
                price=c(5,6,7,8), 
                value=c(9,10,11,12));

Temp;
product;      ##찾을수 없음. Temp안에 들간거기때문에.
Temp$product;
mean(Temp$price);

################엑셀여는패키지 설치
install.packages('readxl');
library(readxl);
require(readxl);
##setwd("c:/Rdata') 를 해놔서 저 안에 있는파일중 엑셀파일을 불러옴.
df_exam=read_excel('excel_exam.xlsx');
df_exam=data.frame(read_excel('excel_exam.xlsx'));
#위에 둘의 차이점... 잘 살펴보셈.
df_exam;

head(df_exam);      #맨위 6개.
tail(df_exam);      #맨 아래 6개.
head(df_exam,4);    #맨위 4개.
mean(df_exam$english);

#column name을 없앨때!!
df_exam_novar=data.frame(read_excel('excel_exam.xlsx',col_names = F));
df_exam_novar;

#시트 몇번째것을 불러올것인지.
df_exam_sheet=read_excel('excel_exam_sheet.xlsx',sheet = 3);
df_exam_sheet;

#csv파일 불러오기.
df_csv_exam=read.csv('csv_exam.csv');
df_csv_exam;

#문자가 있는거 가져오기
df_csv_exam=read.csv('csv_exam.csv',stringsAsFactors = F);
df_csv_exam;

#csv파일로 저장하긔
df_midterm;
write.csv(df_midterm,'df_midter1.csv');
#r파일로 저장하긔
save(df_midterm,file = 'df_midterm.rda');
#지우기~~
rm(df_midterm);
df_midterm;
#r파일로 저장한거 불러오기~
load("df_midterm.rda");
df_midterm;

#R 내장함수로 데이터추출하기
exam=read.csv('csv_exam.csv');
exam;

#dplyr package
install.packages('dplyr');
library(dplyr)
exam;
############Filter
#class가 1인 경우만 추출하고싶을때?
exam%>% filter(class==1);
#english점수가 80점 이상만 추출하고싶을때?
exam %>% filter(english>=80);
#class가 2가 아닌 인원들을 추출하고싶을때?
exam %>% filter(class!=2);
#수학점수가 80이상이거나, 영어점수가 90이상만 추출하고싶을때?
exam %>% filter(math>=80 | english>=90);
#수학이 70이상 영어 70이상 과학 70이상을 충족하는 인원 추출?
exam %>% filter(math>=70 & english>=70 & science>=70);
#1반 3반 5반만 추출?
exam %>% filter(class==1 | class==3 | class==5);
exam %>% filter(class!=2 & class!=4);
exam %>% filter(class %in%c(1,3,5));

############Select
#수학 영어 과학만 가져올래.
exam %>% select(math,english,science);
#수학, 영어빼고 다 가져올래.
exam %>% select(-math,-english);

############응용
#filter랑 select랑 두개 다 써볼래, 1반 5반 아이들중 수학 영어점수만 가져올래.
exam %>% filter(class %in%c(1,5)) %>% select(class,math,english);
#위에랑 문제 같은데 나는 위에서 5개만 가져올끄야!
exam %>%filter(class %in%c(1,5)) %>% select(class,math,english) %>% head(5);
#위에랑 문제는 같은데 나는 !!! 수학 점수 대로 arrange할꺼야!!!
exam %>%filter(class %in%c(1,5)) %>% select(class,math,english) %>% arrange(math) %>% head(5);
#위에랑 같은데 arrange를 내림차순으로 할끄야!!
exam %>%filter(class %in%c(1,5)) %>% select(class,math,english) %>% arrange(desc(math)) %>% head(10);

###########Mutate(파생??) - - 맨 뒤에다가 붙이는거.
exam %>% mutate(total = math+english+science)
#total 이랑 평균 만들겨
exam %>% mutate(total = math+english+science, 
                avg = round(total/3,1))
#ifelse문을 활용한 mutate 사용
exam %>% 
  mutate(test=ifelse(science >=60, 'pass','fail')) %>% 
  head(10);

#Summarise
exam %>% summarise(mean_math=mean(math));
#summarise활용
exam %>% 
  group_by(class) %>% 
  summarise(mean_math=mean(math));
#깔끔하게 만들래
data.frame(exam %>% 
             group_by(class) %>% 
             summarise(mean_math=mean(math)));
# %>% -> ctrl + shift + m

#미친듯한!!! 응용
exam %>% 
  group_by(class) %>% 
  summarise(mean_math = mean(math),
            sum_math = sum(math),
            median_math = median(math),
            count=n());

#중간고사 기말고사 데이터 합쳐보리기, 가로합치기
test1=data.frame(id=c(1:5), 
                 midterm = c(60,80,70,90,85));
test2=data.frame(id=1:5,
                 final = c(70,60,50,40,80));

total = left_join(test1,test2,by='id');
total;
#left_join 보여주긔~
name=data.frame(class=c(1:5),
                teacher=c('kim','lee','jang','chung','park'));
exam_new = left_join(exam,name,by='class');
exam_new;

#세로합치기
group_a=data.frame(id=c(1:5),
                   test=c(60,70,80,50,40));
group_b=data.frame(id=c(6:10),
                   test=c(70,83,92,45,100));

group_all=bind_rows(group_a,group_b);

#############################333

setwd('c:/Rdata');
#디렉토리 check 하기
getwd();
#list싹다 지우기
rm(list=ls());

#Crawling for Daum news.   -> 저작권 걸림.
install.packages('rvest');
install.packages('stringr');
library(rvest);
library(stringr);

title=c();
url=c();
press=c();
body=c();
time=c();

url_b='https://news.daum.net/breakingnews?page=';
t_css='#mArticle .tit_thumb .link_txt';
pt_css='.info_news';
body_css='.desc_thumb .link_txt';

for(i in 1:10){

  cr_url=paste(url_b,i,sep = '')
  hdoc=read_html(cr_url);
  t_node=html_nodes(hdoc,t_css);
  pt_node=html_nodes(hdoc,pt_css);
  b_node=html_nodes(hdoc,body_css);
  
  
  url_part=html_attr(t_node,'href');
  title_part=html_text(t_node);
  
  pt_part=html_text(pt_node);
  time_part=str_sub(pt_part,-5);
  press_part=str_sub(pt_part,end=-9);
  
  b_part=html_text(b_node);
  b_part=str_trim(b_part,side = 'both');
  
  
  title=c(title,title_part);
  press=c(press,press_part);
  time=c(time,time_part);
  body=c(body,b_part);
  url=c(url,url_part);
}


news=data.frame(title,press,time,body,url);
View(news);
write.csv(news,'Daum_News_20200814.csv');

####################################################################asd
#Text-minning for korea...
setwd('c:/Rdata');
getwd();
install.packages('KoNLP');
install.packages('wordcloud');
install.packages('wordcloud2');
library(wordcloud2);

Sys.setenv(JAVA_HOME='c:/Program Files/Java/jre1.8.0_144');

#########KoNlP 깔기.
install.packages("multilinguer")
library(multilinguer)
install_jdk()
install.packages(c('stringr', 'hash', 'tau', 'Sejong', 'RSQLite', 'devtools'), type = "binary")
install.packages("remotes")
remotes::install_github('haven-jeon/KoNLP', upgrade = "never", INSTALL_opts=c("--no-multiarch"))

library(KoNLP);

library(wordcloud);
##############################################asd
##############################################asd
txt=readLines('hong.txt');
nouns=sapply(txt,extractNoun,USE.NAMES = F);
nouns=unlist(nouns);
nouns=Filter(function(x){nchar(x)>=2},nouns);

kk=table(nouns);
pp=head(sort(kk,decreasing = T),20);
tt= barplot(pp,ylim=c(0,30),las=2,col=rainbow(20));
text(tt,pp*1.01,label=paste(pp,'개',sep=''), col=2, cex=1.5, pos=3);

brewer.pal.info;

palette=brewer.pal(9,'Set1');

wordcloud(names(kk), #단어
          freq = kk,#빈도
          scale = c(5,0.5), #단어크기범위
          rot.per = 0.25, #단어 회전율
          min.freq = 3, #최소단어의 수
          random.order = F, #고 빈도 단어를 중앙에 배치
          random.color = T, #색상의 무작위 구성
          colors = palette);

wordcloud2(kk, #wordcloud2(data,size,shape)
           size = 3, #글자크기
           shape = 'triangle') #전체적 모양



###################################################asd

txt=readLines('park.txt');
nouns=sapply(txt,extractNoun,USE.NAMES = F);
nouns=unlist(nouns);
nouns=Filter(function(x){nchar(x)>=2},nouns);

kk=table(nouns);
pp=head(sort(kk,decreasing = T),20);
tt= barplot(pp,ylim=c(0,30),las=2,col=rainbow(20));
text(tt,pp*1.01,label=paste(pp,'개',sep=''), col=2, cex=1.5, pos=3);

brewer.pal.info;

palette=brewer.pal(9,'Set1');

wordcloud(names(kk), #단어
          freq = kk,#빈도
          scale = c(5,0.5), #단어크기범위
          rot.per = 0.25, #단어 회전율
          min.freq = 3, #최소단어의 수
          random.order = F, #고 빈도 단어를 중앙에 배치
          random.color = T, #색상의 무작위 구성
          colors = palette);

wordcloud2(kk, #wordcloud2(data,size,shape)
           size = 3, #글자크기
           shape = 'triangle') #전체적 모양

###########################################################asdf

txt=readLines('noh.txt');
nouns=sapply(txt,extractNoun,USE.NAMES = F);
nouns=unlist(nouns);
nouns=Filter(function(x){nchar(x)>=2},nouns);

kk=table(nouns);
pp=head(sort(kk,decreasing = T),20);
tt= barplot(pp,ylim=c(0,30),las=2,col=rainbow(20));
text(tt,pp*1.01,label=paste(pp,'개',sep=''), col=2, cex=1.5, pos=3);

brewer.pal.info;

palette=brewer.pal(9,'Set1');

wordcloud(names(kk), #단어
          freq = kk,#빈도
          scale = c(5,0.5), #단어크기범위
          rot.per = 0.25, #단어 회전율
          min.freq = 3, #최소단어의 수
          random.order = F, #고 빈도 단어를 중앙에 배치
          random.color = T, #색상의 무작위 구성
          colors = palette);

wordcloud2(kk, #wordcloud2(data,size,shape)
           size = 3, #글자크기
           shape = 'triangle') #전체적 모양
#########################################################asd

#r에서 지도 출력하기
install.packages('ggmap');
register_google(key = 'AIzaSyCcHwEAt_eIkxdA_qNS-rPwUc8WjBzlZN8');
library(ggmap);
install.packages('dplyr');
library(dplyr);

plot.new();
get_map(location='서울시 성북구 길음1동',
        zoom=15,
        maptype='hybrid',
        source='google') %>% ggmap();

qmap(location = '서울시 성북구 길음로 9길 40',
     zoom=12,
     maptype='hybrid',
     source='google');

#경도/위도 얻는법.
geocode(location='서울',
        output='latlon',
        source='google');

#내가 근무하고 있는 주소로 위 경도 얻는 방법 중심지점에 표식을 추가하는 방법
myloc=geocode(location='서울시 성북구 길음1동',
              output='latlon',
              source='google');
center=c(myloc$lon,myloc$lat)
center

qmap(location = center,
     zoom=18,
     maptype='hybrid',
     source='google')+
  geom_point(data=myloc,
           mapping = aes(x=lon,y=lat),
           shape='*',
           color='red',
           stroke=18,
           size=10)


