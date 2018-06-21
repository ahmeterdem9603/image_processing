function [Im_blocks , used_indexs] = corner_blocks (Im_blocks , line_part , column_part , blocks , line_inc , column_inc , used_indexs)
%% variables
block1_line   = 0;
block1_column = 0;
[line , dimension] = size(used_indexs);

for block_num=1 : line_part*column_part
%% (1,2) and (2,1) pixels values of the first block must be zero

    if(blocks(1,2,:,block_num) + blocks(2,1,:,block_num) == 0)
        Im_blocks(1 : line_inc , 1 : column_inc , : ) =  blocks( 1 : line_inc , 1 : column_inc , : , block_num );
        used_indexs(1,dimension) = block_num;
        dimension = dimension + 1 ;
    end
    
    if(blocks(1 , column_inc - 1 , : , block_num ) + blocks(2 , column_inc , : , block_num) == 0)
        Im_blocks( 1 : line_inc , (column_part - 1) * column_inc + 1 : column_part * column_inc , : ) =  blocks( 1 : line_inc , 1 : column_inc , : , block_num );
        used_indexs(1,dimension) = block_num;
        dimension = dimension + 1 ;
    end

    if(blocks(line_inc - 1 , 1 , : , block_num ) + blocks(line_inc , 2 , : , block_num) == 0)
        Im_blocks( (line_part - 1) * line_inc + 1 : line_part * line_inc , 1 : column_inc , : ) =  blocks( 1 : line_inc , 1 : column_inc , : , block_num );
        used_indexs(1,dimension) = block_num;
        dimension = dimension + 1 ;
    end

    if(blocks(line_inc - 1 , column_inc , : , block_num ) + blocks(line_inc , column_inc - 1 , : , block_num) == 0)
        Im_blocks( (line_part - 1) * line_inc + 1 : line_part * line_inc , (column_part - 1) * column_inc + 1 : column_part * column_inc , : ) =  blocks( 1 : line_inc , 1 : column_inc , : , block_num );
        used_indexs(1,dimension) = block_num;
        %dimension = dimension + 1 ;
    end

end
