
function oldresults(input_image, output_image)
%Read Original & Distorted Images
input_image=rgb2gray(input_image);
output_image=rgb2gray(output_image);

origImg = input_image(:,:,1);
distImg = output_image(:,:,1);
%If the input image is rgb, convert it to gray image

%Size Validation
origSiz = size(origImg);
distSiz = size(distImg);



%Mean Square Error 
MSE = MeanSquareError(origImg, distImg);
disp('Mean Square Error = ');
disp(MSE);


RMSE=sqrt(MSE)
%Peak Signal to Noise Ratio 
PSNR = PeakSignaltoNoiseRatio(origImg, distImg);
disp('Peak Signal to Noise Ratio = ');
disp(PSNR);

