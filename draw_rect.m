function [state,result]=draw_rect(img,startPosition,windowSize,showOrNot,t,target)
    if nargin < 4
        showOrNot = 1;
    end
    state=1;
    rgb = [255 0 0];                            
    lineSize = 1;                                    
    windowSize(1,1)=windowSize(1,1);
    windowSize(1,2) = windowSize(1,2);
    if windowSize(1,2) > size(img,1) ||...
            windowSize(1,1) > size(img,2)
        state = -1;                                    
        disp('the window size is larger then image...');
        return;
    end
    result = img;
    if size(img,3) == 3
        for k=1:3
            disp(k)
            for id=1:size(startPosition,1) 
                if(startPosition(id,1)>=0 && startPosition(id,2)>=0) && ~isempty(find(target==t(id)))
                    result(startPosition(id,2),startPosition(id,1):startPosition(id,1)+windowSize(id,1),k) = rgb(1,k); %çťä¸čžšćĄ  
                    result(startPosition(id,2):startPosition(id,2)+windowSize(id,2),startPosition(id,1)+windowSize(id,1),k) = rgb(1,k);%çťĺłčžšćĄ
                    result(startPosition(id,2)+windowSize(id,2),startPosition(id,1):startPosition(id,1)+windowSize(id,1),k) = rgb(1,k);  %çťä¸čžšćĄ 
                    result(startPosition(id,2):startPosition(id,2)+windowSize(id,2),startPosition(id,1),k) = rgb(1,k); 
                    disp(id) 
                end
            end
        end
    end

    if showOrNot == 1
        figure;
        hold on;
        imshow(result);
    end