function [Im_morp] = morphology (Im_org , Im_out , T2)

[w1,h1] = size(Im_org);
Im_morp = zeros(w1,h1);

    for i=1 : w1
        for j=1 : h1
            if Im_org(i,j) >= T2
               Im_morp(i,j) = 255;         
            end
        end
    end 

   figure; imshow(uint8(Im_morp));               title('otsu image');
   
%    morf = strel('disk',6);                      % for badminton image
%    Im_morp = imclose(Im_morp,morf);
%    Im_morp = medfilt3(Im_morp);
%    morf = strel('disk',7);
%    Im_morp = imopen(Im_morp,morf);

%    morf = strel('disk',22);                     % for aggasi image
%    Im_morp = imclose(Im_morp,morf);
%   
%    morf = strel('disk',5);                     % for aggasi image
%    Im_morp = imclose(Im_morp,morf);
   
   
%    morf = strel('disk',7);                    % for balik3
%    Im_morp = imclose(Im_morp,morf);
%     
%    morf = strel('disk',30);
%    Im_morp = imopen(Im_morp,morf);
   
%    morf = strel('disk',7);                    % for eller
%    Im_morp = imclose(Im_morp,morf);
     
    morf = strel('disk',3);                     
    Im_morp = imclose(Im_morp,morf);
    
    morf = strel('disk',30);
    Im_morp = imopen(Im_morp,morf);
   
   figure; imshow(uint8(Im_morp));               title('morphological operated image');
   

   
   for i=1 : w1
        for j=1 : h1
            if Im_morp(i,j) == 255
               Im_morp(i,j) = Im_out(i,j);         
            end
        end
   end 
   
   figure; imshow(uint8(Im_morp));              title('morp. output image');
    
end