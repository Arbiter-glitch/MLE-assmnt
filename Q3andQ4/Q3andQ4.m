%Q3 and Q4 Mean and Covariance  only 

load 'C:\Users\apple\Desktop\PRassmnt2\MeanAndCovariance_1\D1.mat'
load 'C:\Users\apple\Desktop\PRassmnt2\MeanAndCovariance_1\D2.mat'
load 'C:\Users\apple\Desktop\PRassmnt2\MeanAndCovariance_1\testData.mat'
d=10;n=1000;          %Dimension=10 and no.of vectors=1000
 
x11=D1;
x12=D2;
t1=testData;

load 'C:\Users\apple\Desktop\PRassmnt2\MeanAndCovariance_2\D1.mat'
load 'C:\Users\apple\Desktop\PRassmnt2\MeanAndCovariance_2\D2.mat'
load 'C:\Users\apple\Desktop\PRassmnt2\MeanAndCovariance_2\testData.mat'

t2=testData;
x21=D1;
x22=D2;
                            %Finding  Sample mean vectors.
for i=1:d
    sum11=0;sum12=0;sum1=0;sum21=0;sum22=0;sum2=0;
   for j=1:n
     sum11=sum11+x11(i,j);
     sum12=sum12+x12(i,j);
     sum1=sum1+t1(i,j);
     sum21=sum21+x21(i,j);
     sum22=sum22+x22(i,j);
     sum2=sum2+t2(i,j);
   end
    u11(i,1)=sum11/1000;
    u12(i,1)=sum12/1000;
    u1(i,1)=sum1/1000;
    u21(i,1)=sum21/n;
    u22(i,1)=sum22/n;
    u2(i,1)=sum2/n;
end                            
                                %Finding Sample covariance matrices
 s11=zeros(d);s12=zeros(d);s1=zeros(d);s21=zeros(d);s22=zeros(d);s2=zeros(d);
    for j=1:n
        
        s11=s11+(x11(:,j)-u11)* transpose(x11(:,j)-u11);
        s12=s12+(x12(:,j)-u12)*transpose(x12(:,j)-u12);
        s1=s1+(t1(:,j)-u1)*transpose(t1(:,j)-u1);
        s21=s21+(x21(:,j)-u21)* transpose(x21(:,j)-u21);
        s22=s22+(x22(:,j)-u22)*transpose(x22(:,j)-u22);
        s2=s2+(t2(:,j)-u2)*transpose(t2(:,j)-u2);
    end
   E11=(1/n).*s11;
   E12=(1/n).*s12;
   E1=(1/n).*s1;
   E21=(1/n).*s21;
   E22=(1/n).*s22;
   E2=(1/n).*s2;
                              %The MLE Estimates
for i=1:n
   p11(1,i)=transpose(x11(:,i)-u11)*inv(E11)*(x11(:,i)-u11);
   p12(1,i)=transpose(x12(:,i)-u12)*inv(E12)*(x12(:,i)-u12);
   p1(1,i)=transpose(t1(:,i)-u1)*inv(E1)*(t1(:,i)-u1); 
   p21(1,i)=transpose(x21(:,i)-u11)*inv(E21)*(x21(:,i)-u11);
   p22(1,i)=transpose(x22(:,i)-u12)*inv(E22)*(x22(:,i)-u12);
   p2(1,i)=transpose(t2(:,i)-u2)*inv(E2)*(t2(:,i)-u2);
end
                              %Classification based on MLE
for i=1:n
    if (abs(p1(1,i)- p11(1,i))> abs(p1(1,i)- p12(1,i)))
       res1(1,i)=2;
    elseif abs(p1(1,i)-p11(1,i))< abs(p1(1,i)-p12(1,i))
       res1(1,i)=1;
    else
       res1(1,i)=0;
    end
    if (abs(p2(1,i)- p21(1,i))> abs(p2(1,i)- p22(1,i)))
       res2(1,i)=2;
    elseif abs(p2(1,i)-p21(1,i))< abs(p2(1,i)-p22(1,i))
       res2(1,i)=1;
    else
       res2(1,i)=0;
    end
    
end 
 xlswrite('Test3.xlsx',p1);
 xlswrite('Training31.xlsx',p11);
 xlswrite('Training32.xlsx',p12);
 xlswrite('Classified result3.xlsx',res1);
 xlswrite('Test4.xlsx',p2);
 xlswrite('Training41.xlsx',p21);
 xlswrite('Training42.xlsx',p22);
 xlswrite('Classified result4.xlsx',res2);
 disp(res1);
 disp(res2);
