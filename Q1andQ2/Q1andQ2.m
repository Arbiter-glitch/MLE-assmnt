%Q1 and Q2 Mean only 

load 'C:\Users\apple\Desktop\PRassmnt2\MeanOnly_1\D1.mat'
load 'C:\Users\apple\Desktop\PRassmnt2\MeanOnly_1\D2.mat'
load 'C:\Users\apple\Desktop\PRassmnt2\MeanOnly_1\testData.mat'
d=10;n=1000;E=eye(10);     %Dimension=10 and no.of vectors=1000
x11=D1;
x12=D2;
t1=testData;
load 'C:\Users\apple\Desktop\PRassmnt2\MeanOnly_2\D1.mat'
load 'C:\Users\apple\Desktop\PRassmnt2\MeanOnly_2\D2.mat'
load 'C:\Users\apple\Desktop\PRassmnt2\MeanOnly_2\testData.mat'
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
    u11(i,1)=sum11/n;
    u12(i,1)=sum12/n;
    u1=sum1/n;
    u21(i,1)=sum21/n;
    u22(i,1)=sum22/n;
    u2=sum2/n;
end
                               %The MLE Estimates
for i=1:n
   p11(1,i)=transpose(x11(:,i)-u11)*inv(E)*(x11(:,i)-u11);
   p12(1,i)=transpose(x12(:,i)-u12)*inv(E)*(x12(:,i)-u12);
   p1(1,i)=transpose(t1(:,i)-u1)*inv(E)*(t1(:,i)-u1); 
   p21(1,i)=transpose(x21(:,i)-u21)*inv(E)*(x21(:,i)-u21);
   p22(1,i)=transpose(x22(:,i)-u22)*inv(E)*(x22(:,i)-u22);
   p2(1,i)=transpose(t2(:,i)-u2)*inv(E)*(t2(:,i)-u2);
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
 xlswrite('Test1.xlsx',p1);
 xlswrite('Training11.xlsx',p11);
 xlswrite('Training12.xlsx',p12);
 xlswrite('Classified result1.xlsx',res1);
 xlswrite('Test2.xlsx',p2);
 xlswrite('Training21.xlsx',p21);
 xlswrite('Training22.xlsx',p22);
 xlswrite('Classified result2.xlsx',res2);
 disp(res1);
 disp(res2);
