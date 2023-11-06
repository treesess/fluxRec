%% startup
mea = mea_starter_210929(); % make of path
M = mea_map_230701(mea); % make of map
[T10, T10d, T60, T60d] = mea_mu_210927(mea);  % read all .xlsx raw files. 
save(fullfile(mea.path,['fxR', datestr(today,'yymmdd'), '.mat']),'T10','T60','T10d','T60d');
