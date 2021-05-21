clear;
c = clock;

moi = 'nRv_f3_cap2_t20_etaf'; % model of interest

addpath(genpath('C:\Users\SN\Google Drive\z.functions\models'));

outdir = 'C:\Users\SN\Google Drive\p1.UG2_fMRI\180422_eta.8';

% data generation
infile = 'nRv_6models_cap2_t20_30trials_NC.mat';
load(infile);    % to get params (for data generation)
m = 4; % model number in the date file
nP = length(OFFER);
param_tru = param(:, :, m);
Xtru = X(:, :, m);
nx = sum(freeID(m, :));
Rsim = cell(nP, 1);
gg = str2func(['DGP_' moi]);

c(2, :) = clock;
disp('Run DGP!');
for i = 1:nP    
    offer = OFFER{i};
    %cond = COND{i};
    [Rsim{i}, ~] = gg(offer, fixed, Xtru(i,:));    
end

% fitting
Xest = zeros(nP, size(Xtru,2));
param_est = Xest;
BIC = zeros(nP, 1);
L = 1000 + BIC;
ff = str2func(moi);

options =optimset('TolFun',10^(-4),'TolX',10^(-4),'Largescale','off', ...
      'DerivativeCheck','off','GradObj','off', ...
      'MaxFunEvals',20000,'MaxIter',20000, 'Display', 'off');

c(3, :) = clock;
disp('Run fitting!');
for i = 1:nP     
    disp(i);
    offer = OFFER{i}; % no control offers
    resp = Rsim{i};  
    %cond = COND{i};
    nTr = length(offer); 
        for s =1:length(free0{m})
                x = free0{m}(s,:);
                [x, Likeold, ~, ~, ~, ~] = fminunc(@(x) ff(offer,resp,fixed,x), x, options);
                if (L(i,1) > Likeold)
                    L(i,1) = Likeold;
                    Xest(i,:) = x;                
                end
        end        
     BIC(i,1) = L(i,1) + nx/2*(log(nTr)-log(2*pi));         
end
c(4, :) = clock;
disp('Fitting done!');

 xidx = find(freeID(m, :)); 
 param_est(:, xidx) = 1./(1+exp(-Xest(:, xidx)));    % param transformiation   
 param_est(:, 1) = 20*param_est(:, 1);      % inverse temp
 param_est(:, 3) = 20*param_est(:, 3);      % initial norm
 param_est(:, 5) = 4*param_est(:, 5)-2;      % delta 
 %param_est(:, 6) = 4*param_est(:, 6)-2;      % delta change
 %param_est(:, 7) = (1 - param_est(:, 8)).*param_est(:, 7);      % eta change
   
% correlation
R = zeros(1, length(xidx));
P = zeros(1, length(xidx));
k = 0;
for i = xidx
    k = k+1;
    [r, p] = corrcoef(param_tru(1:nP, i), param_est(1:nP, i));
    R(k) = r(1, 2);
    P(k) = p(1, 2);
end

inModel = Model{m};
cd(outdir);
save(['recover_', moi, '_NC','.mat'], 'c', 'moi', 'nx', 'param_tru', 'param_est', 'Xtru', 'Xest', 'Rsim', 'R', 'P', 'infile', 'inModel')

c(5, :) = clock;
disp('Saved!');