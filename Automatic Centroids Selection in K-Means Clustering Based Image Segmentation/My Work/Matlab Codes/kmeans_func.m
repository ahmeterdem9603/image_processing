function [Im_out , PSNR , SSIM ] = kmeans_func (k , centers , Im_org)

[w1,h1] = size(Im_org);
new_centers = zeros(1,k);
classes   = zeros(k , w1 , h1);
distances = zeros(1 , k);
toplam = zeros(k,1);
count = zeros(k,1);

Im_out = Im_org;

    for i=1 : w1
        for j=1 : h1
            if Im_out(i,j) == 0
                Im_out(i,j) = 1;
            end
        end
    end 

while(1)
     for i=1 : w1
         for j=1 : h1
             for center_num = 1 : k
                 distances(1 , center_num) = round(sqrt(abs(power((Im_out(i,j) - centers(1 , center_num)),2))));  
             end     
                 [min_value , min_index] = min(distances) ;   
                 classes(min_index , i , j ) = Im_out(i,j);
                 distances = zeros(1 , k);
                 
                 if classes(min_index , i , j) ~= 0
                    toplam(min_index , 1) = toplam(min_index , 1) + classes(min_index , i , j);
                    count(min_index , 1) =  count(min_index , 1) + 1;
                 end
         end
     end
     
     for center_num = 1 : k
          toplam(center_num , 1) = round(toplam(center_num , 1) / count(center_num , 1));
          new_centers(1 , center_num) = toplam(center_num , 1); 
     end 
     
     flag = 0;
     for center_num = 1 : k 
         if new_centers(1,center_num) ~= centers(1,center_num)
            flag = flag + 1;
         end     
     end
     if flag ~= 0
            centers = new_centers;
            classes = zeros(k , w1 , h1);
            toplam  = zeros(k,1);
            count   = zeros(k,1);
     else
            for i=1 : w1
                for j=1 : h1
                    for center_num = 1 : k
                        if classes(center_num , i , j) ~= 0
                           classes(center_num , i , j) = centers(1 , center_num);
                           Im_out(i , j) = classes(center_num , i , j);
                        end
                    end
                end
            end
         break;
     end    
end

    figure; imshow(uint8(Im_out));      title('k-means segmented image');
    
    PSNR = abs(psnr1(Im_org,Im_out));
    [SSIM, SSIMMAP] = ssim(Im_out , Im_org);
    
   
end