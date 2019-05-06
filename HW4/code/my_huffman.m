N=6;%N data
SiganlSourcewithoutNormilization = [3,8,13,19,23,34];
sum=0;
for n=1:N
    sum=sum+SiganlSourcewithoutNormilization(n);
end
SignalSource=SiganlSourcewithoutNormilization./sum;%Normalization to (0,1)
SignalSource = sort(SignalSource,'descend');
%ÅÅÐò
SortingMatrix=zeros(N,N);
for i=1:N
    P=sort(SignalSource,'descend');%descending sort
    SortingMatrix(i,1)=P(i);
end
rear=SortingMatrix(i,1)+SortingMatrix(i-1,1);%Minimum probability of combining
P(N-1)=rear;P(N)=0;
P=sort(P,'descend');
t=N-1;

for j=2:n%Generate additional columns of the code table
        for i=1:t
            SortingMatrix(i,j)=P(i);
        end
        if t>1
            K=find(P==rear);
            SortingMatrix(N,j)=K(end);%The last element in each column is used to record the location where the merge occurred.
            rear=(SortingMatrix(t-1,j)+SortingMatrix(t,j));
            P(t-1)=rear;
            P(t)=0;
            P=sort(P,'descend');
            t=t-1;
        else
            SortingMatrix(n,j)=1;
        end
    end
%%
    %Code table of sorted elements
    m=3;
    s1=str2sym('[2,1]');
    s2=s1;
    %Code table, with 1 for 0 and 2 for 1, because 0 will not be recorded because it is omitted.
    %Starting from the third last column
    for i=N-2:-1:1
        p=SortingMatrix(N,i+1);
        if p==1
            s2(1:m-2)=s1(2:m-1);
        elseif p==m
            s2(1:m-2)=s1(1:m-2);
        elseif p==2
            s2(1)=s1(1);
            s2(2:m-2)=s1(3:m-1);
        else
            s2(1:p-1)=s1(1:p-1);
            s2(p+1:m-2)=s1(p+1:m-2);
        end
        s2(m-1)=[char(s1(p)),'2'];
        s2(m)=[char(s1(p)),'1'];
        m=m+1;
        s1=s2;
    end
    L=zeros(1,N);
    for i=1:N
        [~,rear]=size(char(s2(i)));
        L(i)=rear;
    end

    %Convert the code table to 0 and 1 output
    array=zeros(1,N);
    array(1:n)=s2(1:N);
    String=[];
    for i=1:n
        s=num2str(array(i));
        s=strrep(s,'1','0');
        s=strrep(s,'2','1');
        if i==1
            String=s;
        else
            String=[String,' ',s];
        end
    end
    
   String = regexp(String,' ','split');%output the code table
  %%
   AverageLength=0;
   for n=1:N
       AverageLength=AverageLength+L(n)*SignalSource(n);
   end
    AverageLength;
    
    H=0;
    for n=1:N
        H=H-SignalSource(n)*log2(SignalSource(n));
    end
    H;
    
    Efficiency = H/AverageLength;%efficient
