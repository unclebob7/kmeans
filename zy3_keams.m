
%% ��ң�����ݣ��Լ��������ǩ������

clear

%% read the data zy3sample1
Img = multibandread('zy3sample1',[400,400,4],'float',0,'bsq','n',{'Band','Direct',[1:4]});%���߹������ݶ���
test_class=1:4;
C=length(test_class);
NbRow=400;
NbCol=400;
NbDim=4;
dataname='zy3';
% image(Img);

%% ��3ά���ݣ�NbRow*NbCol*NbDim����Ϊ2ά(N*NbDim)������N=NbRow*NbCol�������ǣ�
% for i=1:NbDim  X(:,i)=reshape(Img(:,:,i),NbRow*NbCol,1);end
% for i=1:NbDim  
%     X(:,i)=reshape(Img(:,:,i),NbRow*NbCol,1);   %allocate new blocks of memory if necessary
% end

%choosing attrs , here we use a* and b* values
 %lab_img = rgb2lab(Img);    %convert the image to color space using rgb2lab , using attrs : luminosity , red-green axis , blue-yellow axis    

%% ��zy3���ݽ���k-means���� (classify the colors in a*b Space using K-means Clustering)
% ��ʾ��
% ���� result=My_kmeans(Img);%���result��NbRow*NbCol��С�Ľ������ֵ��1-4����ʾ�������
% ��һ����ͼ�������ѡ��C�����ģ��������ͨ�����ѡ����������ķ�ʽ�����������ͼ���Ϊ2άX�󣬾���16w���㣬Ȼ�����ѡ��4����index=randperm(160000);index_z=index(1:4)��
% ע�⣬�����4�����ĵĹ�����������ͬһ���������棬������һ��������һ���������������������ļ��㡣
% �ڶ�������ͼ����ÿ���㵽4�����ĵľ��룬���鲻Ҫ��for i=1:160000������ѭ�����������������;������㡣�ο�Euclidian_distance��SAM����
% ���ͼ�����̫�࣬ͬʱ����160000�����4�����ĵľ�����ܳ���out-of-memory�������ô���԰�160000��������Ĵ���
% ������Էֳ�160�ݣ�ÿ��1000���㣬�Ǿ���160��forѭ����ÿ��forѵ������1000�����4�����Ŵ�
% ���롣����ͼ��һ��һ�еĴ���ÿ1�м�����4�����ľ��룬��ôforѭ����400�Ρ�
% ���������ݾ�����з��࣬��������С�����Ӧ����𡣿�������min������help���������ôʹ�ã�
% Ȼ����ݵ�ǰ���������������ģ�������Ҫ�ҵ����ൽÿ1��ĵ�����Щ��������find������


%% �Ѿ�����������

%% ��������ͼ��ķ�����plot the classification result of the whole image
%% ����zy3����
 ColorTable=[160,82,45;0 255 0;255, 255, 255;255,0,0];
 ClassificationMap  = GenerateClassificationMap( size(Img,1), size(Img,2), ColorTable, reshape(result',size(Img,1)*size(Img,2),1));
 figure
 image(ClassificationMap);  axis off;
% imwrite(ClassificationMap, [dataname,'_ClusterMap.bmp'], 'bmp'); % save as bmp
% multibandwrite(ClassificationMap,[dataname,'_ClassificationMap'],'bsq'); % save as .bsq that can be opened with ENVI



