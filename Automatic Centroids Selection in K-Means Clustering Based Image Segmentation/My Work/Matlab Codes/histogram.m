function [hist_array] = histogram ( Im_org ) 

    [w1,h1] = size(Im_org);

    hist_array = zeros(1,256);

    for i=1 : 1 : h1
        for j=1 : 1 : w1
            if i < w1 
                hist_array( Im_org (i,j) + 1 ) = hist_array( Im_org (i,j) + 1 ) + 1 ;
            else
                continue;
            end
        end
    end
end
