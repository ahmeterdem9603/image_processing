clear all; close all; clc;

%% read the image
Im_org = double(imread('puzzle2.jpg'));
%puzzle4,5(20x20),puzzle8,puzzle9,puzzle10,oruntu1,lale1,balik4(16x12)

%% if it's necessary, resize the image 
line = 660;
column = 940;
temp = zeros(line,column,3);
temp = Im_org(1:line,1:column,:);
Im_org = temp(:,:,:);

%% hold dimensions
[size_line , size_column , rgb] = size(Im_org);
tic;

%% initialization
Im_blocks   = zeros(size_line , size_column , rgb);
column_part = 20;
line_part   = 10;
used_indexs = zeros(1 , 1);
line_inc    = size_line / line_part;
column_inc  = size_column / column_part;

%% image_to_blocks and first_block functions
blocks    = image_to_blocks (Im_org , line_part , column_part , size_line , size_column, rgb);
[Im_blocks , used_indexs] = corner_blocks (Im_blocks , line_part , column_part , blocks , line_inc , column_inc ,used_indexs);

%% corner lines and columns functions
for num_of_column = 1 : column_inc : size_column - (column_inc * 2)    
        [Im_blocks , used_indexs] = first_line (Im_blocks, num_of_column, blocks, line_part, line_inc, column_part, column_inc, used_indexs ); 
end
    
for num_of_line = 1 : line_inc : size_line - (line_inc * 2)   
        
        [Im_blocks , used_indexs] = first_column (Im_blocks, num_of_line, blocks, line_part, line_inc, column_part, column_inc, used_indexs); 
end

for num_of_column = 1 : column_inc : size_column - (column_inc * 2)    
        [Im_blocks , used_indexs] = last_line (Im_blocks, num_of_column, blocks, line_part, line_inc, column_part, column_inc, used_indexs ); 
end
    
for num_of_line = 1 : line_inc : size_line - (line_inc * 2)   
        
        [Im_blocks , used_indexs] = last_column (Im_blocks, num_of_line, blocks, line_part, line_inc, column_part, column_inc, used_indexs); 
end

%% correlation
for num_of_line = 1 : line_inc : size_line - line_inc*2
    for num_of_column = 1 : column_inc : size_column - column_inc*2
        
        [Im_blocks , used_indexs] = column_block (Im_blocks, num_of_line, num_of_column, blocks, line_part, line_inc, column_part, column_inc, used_indexs);
    end   
        [Im_blocks , used_indexs] = line_block (Im_blocks, num_of_line, blocks, line_part, line_inc, column_part, column_inc, used_indexs);
end 

%% show input and output images
 toc;
 figure; imshow(uint8(Im_blocks)); title('çýkýþ imgesi');
 figure; imshow(uint8(Im_org));    title('giriþ imgesi');

 Psnr = psnr(uint8(Im_blocks),uint8(Im_org));