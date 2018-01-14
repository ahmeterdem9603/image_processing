function [PSNR] = psnr1(Im_org,Im_out)
    
    [w,h] = size(Im_org);
    MSE = sum(sum((Im_out - Im_org).^2)) / w*h;
    PSNR = 20*log10(255/sqrt(MSE));

end