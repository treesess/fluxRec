function S60 = T60dSelectedChStats_211014(T60d, Mk)
% reminder: S60 for sum of T60

%% prepare table for every cats
T60df = T60d;
T60df = T60df(T60df.cat1==1 & T60df.cat2==1,:); % f only
T60da = T60d;
T60da = T60da(T60da.cat1==1 & T60da.cat2==2,:); % a only
T60deig = T60d;
T60deig = T60deig(T60deig.cat1==2 ,:); % eig only, no differential cat2
T60dcomp = T60d;
T60dcomp = T60dcomp(T60dcomp.cat1==3,:); % comp only, no differentials cat2


%% 1 comp (6/9)
% delete none selected rows
T60dcomp.mappedch = cell2mat( values(Mk, num2cell(T60dcomp.catVal))); % mapping
T60dcomp = T60dcomp(T60dcomp.mappedch==1,:); 

if  isempty(T60dcomp) % 211014 no match (i.e. T60dcomp.mappedch has no 1 inside!) 
	%% 1 cw, weekly
	cwCount = max(T60d.cw);
	
	T = table();
	T.cw = [1:cwCount]';
	T.Ch_count = zeros(cwCount,1); 
	S60.comp.cw = T;

	%% 2 ddmmmyyyy % daily
	[~,ddmmmyyyy] = groupcounts(floor(T60d.datenum));
	dayCounts = length(ddmmmyyyy); 

	T = table();
	T.ddmmmyyyy = ddmmmyyyy;
	T.Ch_count = zeros(dayCounts,1);
	T.datetime = datetime(T.ddmmmyyyy,'ConvertFrom','datenum');
	S60.comp.ddmmmyyyy = T;

	%% 3 mmmyyyy 
	T60d.mmmyyyy = datenum(T60d.yyyy, T60d.mo, 15*ones(length(T60d.mo),1));	
	[~, IDy, IDm]= findgroups(T60d.yyyy, T60d.mo); 
	mmmyyyy = datenum(IDy,IDm,15*ones(length(IDy),1)); 
	moCount = length(mmmyyyy);

	T = table();
	T.mmmyyyy = mmmyyyy;
	T.Ch_count = zeros(moCount,1);
	T.datetime = datetime(T.mmmyyyy,'ConvertFrom','datenum');
	S60.comp.mmmyyyy = T;
	
else % 
	%% 1 cw % by week
		% findgroup and splitapply 
		T = table(); % the final output table
		[G,T.cw] = findgroups(T60dcomp.cw); 
		T.Ch_count = splitapply(@length,T60dcomp.cw,G); % ★★ if mapping is empty, bug happened.

		% make up tCol
		T0 = array2table([1:max(T60d.cw)]' ,'VariableNames',{'cw'});
		T = outerjoin(T0, T , 'MergeKeys',true);
		T = fillmissing(T,'constant',0); % 211015 debugged NaN
		S60.comp.cw = T; % good

	%% 2 ddmmmyyyy % daily
		% findgroup and splitapply 
		T60dcomp.ddmmmyyyy = datenum(T60dcomp.yyyy, T60dcomp.mo, T60dcomp.dd);
		[G, IDy, IDm, IDd]= findgroups(T60dcomp.yyyy, T60dcomp.mo, T60dcomp.dd); 

		T = table();
		T.ddmmmyyyy = datenum(IDy, IDm, IDd);
		T.Ch_count = splitapply(@length,T60dcomp.ddmmmyyyy,G);

		% make up tCol
		[~,ddmmmyyyy] = groupcounts(floor(T60d.datenum)); 
		T0 = array2table( ddmmmyyyy ,'VariableNames',{'ddmmmyyyy'}); % be careful here
		T = outerjoin(T0, T , 'MergeKeys',true);
		T = fillmissing(T,'constant',0); % 211015 debugged NaN
		T.datetime = datetime(T.ddmmmyyyy,'ConvertFrom','datenum'); % 210927 added
		S60.comp.ddmmmyyyy = T; % good


	%% 3 mmmyyyy 
		% 2 findgroup and splitapply 
		T60dcomp.mmmyyyy = datenum(T60dcomp.yyyy, T60dcomp.mo, 15*ones(length(T60dcomp.mo),1));	% ref to %	D.dateNum{k} = datenum(D.dateYear{k}, D.dateMonth{k}, 15*ones(len,1));
		[G, IDy, IDm]= findgroups(T60dcomp.yyyy, T60dcomp.mo); 

		T = table();
		T.mmmyyyy = datenum(IDy, IDm,15*ones(length(IDy),1)); 
		T.Ch_count = splitapply(@length,T60dcomp.mmmyyyy,G);
		T = sortrows(T, 'mmmyyyy');

		% 3 make up tCol
		T60d.mmmyyyy = datenum(T60d.yyyy, T60d.mo, 15*ones(length(T60d.mo),1));	
		[~, IDy, IDm]= findgroups(T60d.yyyy, T60d.mo); 
		mmmyyyy = datenum(IDy,IDm,15*ones(length(IDy),1)); 
		T0 = array2table( mmmyyyy ,'VariableNames',{'mmmyyyy'}); % be careful here
		T = outerjoin(T0, T , 'MergeKeys',true);
		T = fillmissing(T,'constant',0); % 211015 debugged NaN
		T.datetime = datetime(T.mmmyyyy,'ConvertFrom','datenum'); % 210927 added
		S60.comp.mmmyyyy = T; % for export

% comp are finished.
end

%% 2 old f
% 1 cw
	T = table(); % the final output table
	[G, T.cw] = findgroups(T60df.cw); 
	T.f = splitapply(@sum, T60df.catVal, G);
	% make up tCol
	T0 = array2table([1:max(T60d.cw)]' ,'VariableNames',{'cw'});
	T = outerjoin(T0, T , 'MergeKeys',true);		
	T = fillmissing(T,'constant',0); % 211015 debugged NaN
	S60.f.cw = T; % good
	
% 2 ddmmmyyyy
	% findgroup and splitapply 
	T = table(); % the final output table
	T60df.ddmmmyyyy = datenum(T60df.yyyy, T60df.mo, T60df.dd);
	[G,T.ddmmmyyyy] = findgroups(T60df.ddmmmyyyy); 
	T.f = splitapply(@sum,T60df.catVal,G);

	% make up tCol
	[~,ddmmmyyyy] = groupcounts(floor(T60d.datenum));
	T0 = array2table( ddmmmyyyy ,'VariableNames',{'ddmmmyyyy'}); % be careful here
	T = outerjoin(T0, T , 'MergeKeys',true);
	T = fillmissing(T,'constant',0); % 211015 debugged NaN
	T.datetime = datetime(T.ddmmmyyyy,'ConvertFrom','datenum'); % 210927 added
	S60.f.ddmmmyyyy = T; % good
	
% 3 mmmyyyy % monthly 
	% 2 findgroup and splitapply 
	T60df.mmmyyyy = datenum(T60df.yyyy, T60df.mo, 15*ones(length(T60df.mo),1));	% ref to %	D.dateNum{k} = datenum(D.dateYear{k}, D.dateMonth{k}, 15*ones(len,1));
	[G, IDy, IDm]= findgroups(T60df.yyyy, T60df.mo); 

	T = table(); 
	T.mmmyyyy = datenum(IDy, IDm,15*ones(length(IDy),1)); 
	T.f = splitapply(@sum,T60df.catVal,G);
	T = sortrows(T, 'mmmyyyy');

	% 3 make up tCol
	T60d.mmmyyyy = datenum(T60d.yyyy, T60d.mo, 15*ones(length(T60d.mo),1));	
	[~, IDy, IDm]= findgroups(T60d.yyyy, T60d.mo); 
	mmmyyyy = datenum(IDy,IDm,15*ones(length(IDy),1)); 
	T0 = array2table( mmmyyyy ,'VariableNames',{'mmmyyyy'}); % be careful here
	T = outerjoin(T0, T , 'MergeKeys',true);
	T = fillmissing(T,'constant',0); % 211015 debugged NaN
	T.datetime = datetime(T.mmmyyyy,'ConvertFrom','datenum'); % 210927 added
	S60.f.mmmyyyy = T; 

	
%% 3 old a
% 1 cw
	T = table();
	[G, T.cw] = findgroups(T60da.cw); 
	T.a = splitapply(@sum, T60da.catVal, G);

	% make up tCol
	T0 = array2table([1:max(T60d.cw)]' ,'VariableNames',{'cw'});
	T = outerjoin(T0, T , 'MergeKeys',true);
	T = fillmissing(T,'constant',0); % 211015 debugged NaN
	S60.a.cw = T; % good

% 2 ddmmmyyyy
	% findgroup and splitapply 
	T = table(); % the final output table
	T60da.ddmmmyyyy = datenum(T60da.yyyy, T60da.mo, T60da.dd);
	[G,T.ddmmmyyyy] = findgroups(T60da.ddmmmyyyy); 
	T.a = splitapply(@sum,T60da.catVal,G);

	% make up tCol
	[~,ddmmmyyyy] = groupcounts(floor(T60d.datenum)); 
	T0 = array2table( ddmmmyyyy ,'VariableNames',{'ddmmmyyyy'}); % be careful here
	T = outerjoin(T0, T , 'MergeKeys',true);
	T = fillmissing(T,'constant',0); % 211015 debugged NaN
	T.datetime = datetime(T.ddmmmyyyy,'ConvertFrom','datenum'); % 210927 added
	S60.a.ddmmmyyyy = T; % good
	
% 3 mmmyyyy % monthly 
	% 2 findgroup and splitapply 
	T60da.mmmyyyy = datenum(T60da.yyyy, T60da.mo, 15*ones(length(T60da.mo),1));	% ref to %	D.dateNum{k} = datenum(D.dateYear{k}, D.dateMonth{k}, 15*ones(len,1));
	[G, IDy, IDm]= findgroups(T60da.yyyy, T60da.mo); 

	T = table(); 
	T.mmmyyyy = datenum(IDy, IDm,15*ones(length(IDy),1));
	T.a = splitapply(@sum,T60da.catVal,G);
	T = sortrows(T, 'mmmyyyy');

	% 3 make up tCol
	T60d.mmmyyyy = datenum(T60d.yyyy, T60d.mo, 15*ones(length(T60d.mo),1));	
	[~, IDy, IDm]= findgroups(T60d.yyyy, T60d.mo); 
	mmmyyyy = datenum(IDy,IDm,15*ones(length(IDy),1)); 
	T0 = array2table( mmmyyyy ,'VariableNames',{'mmmyyyy'}); % be careful here
	T = outerjoin(T0, T , 'MergeKeys',true);
	T = fillmissing(T,'constant',0); % 211015 debugged NaN
	T.datetime = datetime(T.mmmyyyy,'ConvertFrom','datenum'); % 210927 added
	S60.a.mmmyyyy = T; 














end
