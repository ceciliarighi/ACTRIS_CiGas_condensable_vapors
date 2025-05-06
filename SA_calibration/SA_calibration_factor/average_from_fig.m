function y_avg_all=average_from_fig()

a=get(gca,'children');
y_avg=[];
y_avg_all=[];
more=[];
while isempty(more)
times=ginput(2);
start_time=times(1,1);
end_time=times(2,1);



for i=1:length(a)
    x=get(a(i),'xdata');
    y=get(a(i),'ydata');
    ind1=min(find(x>start_time));
    ind2=max(find(x<end_time));
    y_avg(i,1)=nanmean(y(ind1:ind2)); %median
    
    hold on; 
    
end;
y_avg_all = [y_avg_all, y_avg];
more=input('More? 0 = no ');
end;

y_avg_all = flipud(y_avg_all)