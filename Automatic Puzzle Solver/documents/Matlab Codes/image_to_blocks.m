function [blocks] = image_to_blocks (Im_org , line_part , column_part, size_line, size_column, rgb)
%% is done frame on edges 
Im_org(: , 1 , :) = 0;
Im_org(1 , : , :) = 0;
Im_org(: , size_column , :) = 0;
Im_org(size_line , : , :)   = 0;

%% line and column pixel increase
line_inc   = size_line / line_part;
column_inc = size_column / column_part;

%% empty matrix for blocks of image. It's same dimensions with image.
blocks = zeros( line_inc , column_inc , rgb , line_part * column_part );

%% separate to image
block_num = 1;
for i = 1 : line_part
   for j = 1 : column_part   
        blocks( 1 : line_inc , 1 : column_inc , : , block_num ) = Im_org( i * line_inc - line_inc + 1 : i * line_inc , j * column_inc - column_inc + 1 : j * column_inc , : );
            if block_num < line_part * column_part
                block_num = block_num + 1;
            else
                break;
            end
   end
end 
end