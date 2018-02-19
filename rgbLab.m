img = zeros(100,100,3);
img(:,:,:) = 1;
imgLAB =rgb2lab(img);
count = 0
for i= 30:5:60
    for j = -128:10:-83
        for k = 30:10:127
            imgLAB(:,:,1)= i;       
            imgLAB(:,:,2)= j;         
            imgLAB(:,:,3)= k;
            imgRGB = lab2rgb(imgLAB);
            imwrite(imgRGB,strcat('image',num2str(i),num2str(j),num2str(k),'.jpg'))
            imshow(strcat('image',num2str(i),num2str(j),num2str(k),'.jpg'))
            pause(0.5)
        end        
    end
end
       
