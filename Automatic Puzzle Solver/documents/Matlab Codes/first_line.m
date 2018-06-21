function [Im_blocks , used_indexs] = first_line (Im_blocks, num_of_column, blocks, line_part, line_inc, column_part, column_inc, used_indexs)
 %% initialization
    diff_column        = 0;
    lower_val_column   = 0;
    index_of_block     = 0;
    [line , dimension] = size(used_indexs);
       
    %% correlation
        for block_num = 1 : line_part * column_part
            count             = 0;
            total_diff_column = 0;
            
        for dim = 1 : dimension
            if block_num == used_indexs(1 , dim)
                count = count + 1;
            end
        end       
        
            if (count == 0)
                
                for rgb = 1 : 3
                    diff_column = max(crosscorr(Im_blocks( 1 : line_inc , num_of_column + column_inc - 1 , rgb ) , blocks( : , 1 , rgb , block_num ),3));
                    total_diff_column = total_diff_column + diff_column;
                end              
         
                        if total_diff_column > lower_val_column && sum(blocks( 1 , : , rgb , block_num )) == 0 %&& total_diff_column < 3 %&& count == 0
                                lower_val_column = total_diff_column;
                                index_of_block   = block_num;
                                used_indexs(1,dimension) = index_of_block;
                        end
            end
        end
        
        dimension = dimension + 1 ;

        Im_blocks( 1 : line_inc , num_of_column + column_inc : num_of_column + column_inc * 2 - 1 , : ) = blocks( : , : , : , index_of_block );
end