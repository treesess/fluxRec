function S10 = T10dSelectedChCountSum_210928(T10d, M)

% 210926 cw based first


%% 0 common sequence
% 1 delete none selected rows
T10ds = T10d; 
T10ds.mappedch = cell2mat( values(M, num2cell(T10ds.ch))); % mapping
T10ds = T10ds(T10ds.mappedch>0,:); 
% for ddmmmyyyy
T10ds.ddmmmyyyy = datenum(T10ds.yyyy, T10ds.mo, T10ds.dd);
% for mmmyyyy 
T10ds.mmmyyyy = datenum(T10ds.yyyy, T10ds.mo, 15*ones(length(T10ds.mo),1));	

%% 1 cw % by week
T = table(); % the final output table
[G,T.cw] = findgroups(T10ds.cw); 
T.Ch_count = splitapply(@length,T10ds.cw,G);
T.f_sum = splitapply(@sum,T10ds.f,G);
T.a_sum = splitapply(@sum,T10ds.a,G);

% 3 make up tCol
T0 = array2table([1:max(T10d.cw)]' ,'VariableNames',{'cw'});
T = outerjoin(T0, T , 'MergeKeys',true);
T = fillmissing(T,'constant',0); % 211015 debugged NaN
S10.cw = T; % for export


%% 2 ddmmmyyyy % daily
% 2 findgroup and splitapply 
T = table(); % the final output table
[G,T.ddmmmyyyy] = findgroups(T10ds.ddmmmyyyy ); 
T.Ch_count = splitapply(@length, T10ds.ddmmmyyyy, G);
T.f_sum = splitapply(@sum, T10ds.f, G);
T.a_sum = splitapply(@sum, T10ds.a, G);

% 3 make up tCol
[~,ddmmmyyyy] = groupcounts(floor(T10d.datenum));
T0 = array2table( ddmmmyyyy ,'VariableNames',{'ddmmmyyyy'}); % be careful here
T = outerjoin(T0, T , 'MergeKeys',true);
T = fillmissing(T,'constant',0); % 211015 debugged NaN
T.datetime = datetime(T.ddmmmyyyy,'ConvertFrom','datenum'); % 210927 added
S10.ddmmmyyyy = T; % for export

%% 3 mmmyyyy % monthly
% 2 findgroup and splitapply 
T = table(); % the final output table
[G,T.mmmyyyy] = findgroups(T10ds.mmmyyyy); 
T.Ch_count = splitapply(@length,T10ds.mmmyyyy,G);
T.f_sum = splitapply(@sum,T10ds.f,G);
T.a_sum = splitapply(@sum,	T10ds.a,G);
T = sortrows(T, 'mmmyyyy');

% 3 make up tCol
T10d.mmmyyyy = datenum(T10d.yyyy, T10d.mo, 15*ones(length(T10d.mo),1));	
[~, IDy, IDm]= findgroups(T10d.yyyy, T10d.mo); 
mmmyyyy = datenum(IDy,IDm,15*ones(length(IDy),1));
T0 = array2table( mmmyyyy ,'VariableNames',{'mmmyyyy'});
T = outerjoin(T0, T , 'MergeKeys',true);
T = fillmissing(T,'constant',0); % 211015 debugged NaN
T.datetime = datetime(T.mmmyyyy,'ConvertFrom','datenum'); % 210927 added
S10.mmmyyyy = T;






end
