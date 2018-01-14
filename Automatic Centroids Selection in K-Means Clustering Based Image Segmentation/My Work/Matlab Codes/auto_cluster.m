function [pix_val , k] = auto_cluster(Im_org)

Im_org = medfilt2(Im_org);

hist_array = histogram ( Im_org );
diff_hist_array = diff(hist_array);

distance_pp = 0;
M = 0;

for i = 1 : 127       
        distance_pp = distance_pp + abs((diff_hist_array(1,2*i-1) - diff_hist_array(1,2*i)));
        M = M + 1;       
end

T1 = round(distance_pp / M);

centers = zeros(1,256);
pix_val = zeros(1,256);
cen_num = 1;

for i = 1 : 256
    if abs(centers(1,cen_num) - hist_array(1,i)) >= T1*4 && abs(i - pix_val(1,cen_num)) >= 5
        cen_num = cen_num + 1;
        centers(1,cen_num)= hist_array(1,i);
        pix_val(1,cen_num) = i;     
    end
end
k = cen_num - 1;

%centers_mean = round(sum(pix_val) / k+1);

end