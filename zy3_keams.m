
%% 读遥感数据，以及读入带标签的数据

clear

%% read the data zy3sample1
Img = multibandread('zy3sample1',[400,400,4],'float',0,'bsq','n',{'Band','Direct',[1:4]});%将高光谱数据读入
test_class=1:4;
C=length(test_class);
NbRow=400;
NbCol=400;
NbDim=4;
dataname='zy3';
% image(Img);

%% 把3维数据（NbRow*NbCol*NbDim）变为2维(N*NbDim)，其中N=NbRow*NbCol的命令是：
% for i=1:NbDim  X(:,i)=reshape(Img(:,:,i),NbRow*NbCol,1);end
% for i=1:NbDim  
%     X(:,i)=reshape(Img(:,:,i),NbRow*NbCol,1);   %allocate new blocks of memory if necessary
% end

%choosing attrs , here we use a* and b* values
 %lab_img = rgb2lab(Img);    %convert the image to color space using rgb2lab , using attrs : luminosity , red-green axis , blue-yellow axis    

%% 对zy3数据进行k-means聚类 (classify the colors in a*b Space using K-means Clustering)
% 提示：
% 例如 result=My_kmeans(Img);%输出result是NbRow*NbCol大小的结果（数值是1-4，表示所属类别）
% 第一步在图像中随机选择C个类心，例如可以通过随机选择行列坐标的方式，再例如可以图像变为2维X后，就是16w个点，然后随机选择4个点index=randperm(160000);index_z=index(1:4)。
% 注意，建议把4个类心的光谱特征放在同一个矩阵里面，而不是一个类心是一个变量。这样更方便后面的计算。
% 第二步计算图像中每个点到4个类心的距离，建议不要用for i=1:160000这样的循环，尽量利用向量和矩阵运算。参考Euclidian_distance和SAM程序。
% 如果图像点数太多，同时计算160000个点和4个类心的距离可能出现out-of-memory情况，那么可以把160000个点分批的处理，
% 例如可以分成160份，每份1000个点，那就是160个for循环，每个for训练计算1000个点和4个类信贷
% 距离。或者图像一行一行的处理，每1行计算与4个类心距离，那么for循环有400次。
% 第三步根据距离进行分类，就是找最小距离对应的类别。可以利用min函数（help这个函数怎么使用）
% 然后根据当前分类结果，更新类心，这里需要找到分类到每1类的点有哪些，可以用find函数。


%% 把聚类结果画出来

%% 画出整个图像的分类结果plot the classification result of the whole image
%% 对于zy3数据
 ColorTable=[160,82,45;0 255 0;255, 255, 255;255,0,0];
 ClassificationMap  = GenerateClassificationMap( size(Img,1), size(Img,2), ColorTable, reshape(result',size(Img,1)*size(Img,2),1));
 figure
 image(ClassificationMap);  axis off;
% imwrite(ClassificationMap, [dataname,'_ClusterMap.bmp'], 'bmp'); % save as bmp
% multibandwrite(ClassificationMap,[dataname,'_ClassificationMap'],'bsq'); % save as .bsq that can be opened with ENVI



