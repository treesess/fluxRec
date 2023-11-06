function [m10k, m60k] = mea_rawData2m_230924(c10, c60, fxRv, rawData)
% convert xlsx read raw data to structured matrix
% this version of rawData2m function is totally not consistent with the
% last version


%% 0 common head - tCols, m10k m60k initiation
	% time cols 10 
	yyyy = year(c10); % 1
	mo = month(c10); % 2
	dd = day(c10); % 3
	w = week(datetime(yyyy, mo, dd)); % 4
	wd = weekday(c10); % 5
	customizedStartDateNum = datenum('1-Oct-2019'); 
	cw = ceil((c10 - ones(size(c10))*customizedStartDateNum + 1)./7); % 6 customized week count 
	hh = hour(c10); % 7
	mm = minute(c10); % 0 10 20 30 40 50 60 % 8

	tCols10 = [c10,yyyy,mo,dd,w,wd,cw,hh,mm]; % integrated. 
	m10k = [];

	% time cols 60 
	yyyy = year(c60); % 1
	mo = month(c60); % 2
	dd = day(c60); % 3
	w = week(datetime(yyyy, mo, dd)); % 4
	wd = weekday(c60); % 5
	customizedStartDateNum = datenum('1-Oct-2019'); 
	cw = ceil((c60 - ones(size(c60))*customizedStartDateNum + 1)./7); % 6 customized week count 
	hh = hour(c60); % 7
	% no minute for tCols60

	tCols60 = [c60,yyyy,mo,dd,w,wd,cw,hh]; % integrated. 
	ones_tCols60 = ones(length(tCols60),1);

	m60k = [];


%% 1 differentials of fxR versions
switch fxRv
case 'v191130' % v3
	paralCount = 2;
	compColStarter = 17;
case 'v200301' % v4
	paralCount = 3;
	compColStarter = 23;
case 'v210401' % v5
	paralCount = 6;
	compColStarter = 41;
end
	

%% 2 m10k - reshape needed. 
% 2 content/catVal - categ applied (two level)
% ch: cat 1-1,... 1-6
for paralk = 1:paralCount % loop for 6 paralleled
	ch = rawData( 1:3:end,  (6*paralk-1):(6*paralk+4)   );
	f = rawData(2:3:end,  (6*paralk-1):(6*paralk+4)   );
	a = rawData(3:3:end,  (6*paralk-1):(6*paralk+4)   );
	chReshaped = reshape(ch',[],1);
	fReshaped = reshape(f',[],1);
	aReshaped = reshape(a',[],1);
	m10k = [m10k;...
		[tCols10,...
		paralk.*ones(size(chReshaped)),...
		chReshaped,...
		fReshaped,...
		aReshaped]];
end

% m10k is done

%% 3 m60k


% 2 content/catVal
% old fa-f: cat 1-1
m60k = [m60k;...
	[tCols60,...
	1.*ones_tCols60,... 
	1.*ones_tCols60,... 
	rawData(2:3:end,2)]]; 

% old fa-a: cat 1-2
m60k = [m60k;...
	[tCols60,...
	1.*ones_tCols60,... 
	2.*ones_tCols60,... 
	rawData(3:3:end,2)]]; 

% eig: cat 2-1, 2-2, 2-3
for cat_2k = 1:3 % loop for rows 1~3
	m60k = [m60k;...
		[tCols60,...
		2.*ones_tCols60,... 
		cat_2k.*ones_tCols60,...
		rawData(cat_2k:3:end,4)]]; % 10 11 12 eig - read column D (4th), every 3 rows. 
end



% cat1==3. cat1 is always 3, and cat2 should be from 1:9
% comp: cat 3-1, ..., 3-9
for cat_2kk = 1:3 % this is loop for rows, so, always equal to 3
	m60k = [m60k;...
		[tCols60,...
		3.*ones_tCols60,...				% cat1==3
		cat_2kk.*ones_tCols60,...		% cat2 loops from 1:3
		rawData(cat_2kk:3:end, compColStarter)]];
	m60k = [m60k;...
		[tCols60,...
		3.*ones_tCols60,...				% cat1==3
		(cat_2kk+3).*ones_tCols60,...	% cat2 loops from 4:6
		rawData(cat_2kk:3:end, compColStarter+1)]];
	
	if strcmp(fxRv,'v210401') % v5 
	m60k = [m60k;...
		[tCols60,...
		3.*ones_tCols60,...				% cat1==3
		(cat_2kk+6).*ones_tCols60,...	% cat2 loops from 7:9
		rawData(cat_2kk:3:end, compColStarter+2)]];
	end
end

% m60k is done

end

