function [Im_blocks , used_indexs] = first_column (Im_blocks, num_of_line, blocks, line_part, line_inc, column_part, column_inc, used_indexs)
 %% initialization   
    diff_line          = 0;
    lower_val_line     = 0;
    index_of_block     = 0;
    [line , dimension] = size(used_indexs);
       
    %% correlation
        for block_num = 1 : line_part * column_part
            count           = 0;
            total_diff_line = 0;
            
        for dim = 1 : dimension
            if block_num == used_indexs(1 , dim)
                count = count + 1;
            end
        end          
            
            if (count == 0)
                
                for rgb = 1 : 3
                    diff_line       = max(crosscorr(Im_blocks( num_of_line + line_inc - 1 , 1 : column_inc , rgb ) , blocks( 1 , : , rgb , block_num ),3));
                    total_diff_line = total_diff_line + diff_line;
                end  
                
                        if total_diff_line > lower_val_line && sum(blocks( : , 1 , rgb , block_num )) == 0 %&& total_diff_line < 3 && count == 0
                                lower_val_line = total_diff_line;
                                index_of_block = block_num; 
                                used_indexs(1,dimension) = index_of_block;
                        end
            end
        end
        
        dimension = dimension + 1 ;
        
        Im_blocks( num_of_line + line_inc : num_of_line + 2 * line_inc - 1 , 1 : column_inc , : ) = blocks( : , : , : , index_of_block );
end