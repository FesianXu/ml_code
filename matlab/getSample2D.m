function [posspl, negspl] = getSample2D()
figure
grid on
posspl = [] ;
negspl = [] ;
axis([0,10,0,10])
counter = 1 ;
while 1
    [x,y,but] = ginput(1) ;
    if but == 3 
        break ;
    end
    posspl(counter,:) = [x,y] ;
    plot(x,y,'r*')
    axis([0,10,0,10])
    grid on
    hold on
    disp(['pos No.=',num2str(counter)]);
    counter = counter+1 ;
end
axis([0,10,0,10])
counter = 1 ;
while 1
    [x,y,but] = ginput(1) ;
    if but == 3
        break ;
    end
    negspl(counter,:) = [x,y] ;
    plot(x,y,'b*')
    axis([0,10,0,10])
    grid on
    hold on
    disp(['neg No.=',num2str(counter)]);
    counter = counter+1 ;
end

