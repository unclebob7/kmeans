function [ img_out , center ] = My_kmeans( img_in , n )
% only display the final output.
opts = statset('Display','final');
% iteration threshold : 3
% Distance metric : 'cityblock'     
% 'Euclidean' for more satisfying clustering
[img_out , center] = kmeans(img_in,n,'Distance','cosine',...
    'Replicates',3,'Options',opts);

end

