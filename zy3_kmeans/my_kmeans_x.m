function [ result , center ] = my_kmeans_x( data )

% my_kmeans_x

% number of clusters
K = 4;

% acquiring info from data
sample_num = size(data, 1);       % num of row(element)
sample_identifier = size(data, 2); % num of dimensions(identifiers) of element

% randomly initialize the centroid location of each cluster
index=randperm(160000);
index_z=index(1:4);

% 4*4 matrix saving centroid location
clusters = zeros(K, sample_identifier);
clusters(1,:) = data(index_z(1),:);
clusters(2,:) = data(index_z(2),:);
clusters(3,:) = data(index_z(3),:);
clusters(4,:) = data(index_z(4),:);

% saving category of each element allocated to
category = zeros(sample_num, 1); 

% percision for convergence
PRECISION = 0.0001;

% times of iteration
iter = 5; 

for i=1:iter
    % traverse every element to pinpoint its category
    for j=1:sample_num
		%uclidian_distance
		%uclidian_distance(data1,data2)
		%ed_distance = @(x) uclidian_distance(x,clusters(l,:));
        trans_matrix = repmat(data(j,:), K, 1);
        trans_matrix = trans_matrix - clusters;   % norm:length of each vector
        dis_mastrix = arrayfun(@(n) norm(trans_matrix(n,:)), (1:K)');
        [~, min_ed_row] = min(dis_mastrix);		% minIdx returning row-attr of the opt ed_distance
        category(j) = min_ed_row;
    end
    
    % traverse every element to update each centroid location
    convergence = 0;
    for j=1:K
        ele_sum = 0;
        ele_num = 0;
        for k=1:sample_num
			% using mean value of elements of each cluster to update its centroid location
            ele_sum = ele_sum + (category(k)==j) * data(k,:);
            ele_num = ele_num + (category(k)==j);
        end
        new_cluster = ele_sum/ele_num;
        delta = clusters(j,:) - new_cluster;
        if (norm(delta) <= PRECISION)
			% if delta < precision , process of convergence complete
            convergence = 1;
			disp(['converged at the', num2str(i), 'iteration']);
        end
        clusters(j,:) = new_cluster;
    end
    
end

for q = 1:sample_num
	result(q) = category(q);
end

for w = 1:K
	center(w,:) = clusters(w,:);
end

