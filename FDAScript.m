clear
testfile=['fafc.txt';'fafb.txt';'dup1.txt';'dup2.txt'];
iii=2;
load(strcat(testfile(iii,1:4),'-lbp2.mat'));
for i = 1:size(train_labels,1)
train_labels{i}=str2num(train_labels{i});
end
train_labels=cell2mat(train_labels);
for i = 1:size(test_labels,1)
test_labels{i}=str2num(test_labels{i});
end
test_labels=cell2mat(test_labels);
rem=train_labels-(1:1196)';
for i = 1:size(test_labels,1)
test_labels(i) = test_labels(i)-rem(find(train_labels==test_labels(i)));
end
train_labels=train_labels-rem;


% train_image_feats=train_image_feats';
% test_image_feats=test_image_feats';
% 
%                  pca_coeff = princomp(train_image_feats);
%                  pca_coeff = pca_coeff(:, 1:floor(size(train_image_feats,2)/20));
%                  train_image_feats = (pca_coeff' * train_image_feats')';
%                  test_image_feats = (pca_coeff' * test_image_feats')';
% 
% train_image_feats=train_image_feats';
% test_image_feats=test_image_feats';

[Z,W] = FDA(train_image_feats,train_labels);


Zte= W'*bsxfun(@minus,test_image_feats,mean(test_image_feats,1));

predicted_categories = nearest_neighbor_classify(Z', train_labels, test_labels, Zte');
correct=0;
        m=size(test_labels,1);
        for i = 1:size(test_labels,1)
            if(test_labels(i)==predicted_categories(i))
                correct=correct+1;
            end
        end
        fprintf(testfile(iii,:));
        fprintf('\n');
        fprintf('%f',correct/m);
