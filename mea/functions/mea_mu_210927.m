function [T10, T10d, T60, T60d] = mea_mu_210927(mea)
% monthly update of reading all the xlsx. 
% actually you can do this no matter when



%% 0 set path
xlsxPath = fullfile(mea.path,'xlsx'); % download your fxR spreadsheets as .xlsx and save them to this folder every month

%% 1 fxR xlsx read in. turn all data into double matrix 
% prep for constants
tenMin = datenum(0,0,0,0,10,0); % 10 minutes in datenum
oneHr = datenum(0,0,0,1,0,0); % 1 hour in datenum

m10 = []; % matrix for 10 mins
m60 = []; % matrix for hourly

fxRvSum = {'v191130';
	'v200301'
	'v210401'}; % pls give me sometime to document the previous versions. 


%% 2 loop for all fxR versions
tic
for fxRvk = 1:3
	fxRv = fxRvSum{fxRvk}; S = dir( fullfile(xlsxPath, fxRv, '*.xlsx'));
for k = 1:length(S) % loop all .xlsx
	YYMMstr = S(k).name(18:21); % ssName
	YY = str2num(YYMMstr(1:2))+2000;
	MM = str2num(YYMMstr(3:4)); % KISS
	startDateNum = datenum(YY,MM,1,0,0,0);
	endDateNum = datenum(YY,MM+1,1,0,0,0) - tenMin; % datestr(startDateNum, 'dd-mmm-yyyy HH:MM:SS'); % proving code
	
	c10 = [startDateNum:tenMin:endDateNum]'; % 
	c60 = [startDateNum:oneHr:endDateNum]'; % 
	
	xlsxFileName = fullfile(xlsxPath,fxRv,S(k).name);% read raw xlsx: ~1 sec per file
	rawData = readmatrix(xlsxFileName, 'Range' ,[1 1]   ); % 230924 debugged.
% 	rawData = readmatrix(xlsxFileName,delimitedTextImportOptions('DataLines',[0,Inf]));
% 	rawData = readmatrix(xlsxFileName); % 210923 good. 
		if mod(length(rawData),3)~=0 % weirdm, some version needs to cut off the header, but others don't
			rawData = rawData(2:end,:);
		end
	[m10k, m60k] = mea_rawData2m_230924(c10, c60, fxRv, rawData); 
	m10 = [m10; m10k]; % integrate it into the whole, 
	m60 = [m60; m60k]; % integrate it into the whole, 
end
end

toc


%% 3 table head - 210923 good
head10 = {'datenum'
	'yyyy'
	'mo'
	'dd'
	'w'
	'wd'
	'cw'
	'hh'
	'mm'
	'paral'
	'ch'
	'f'
	'a'}; % 210925 no cat but group. paral from 1 to 6
head60 = {'datenum'
	'yyyy'
	'mo'
	'dd'
	'w'
	'wd'
	'cw'
	'hh'
	'cat1'
	'cat2'
	'catVal'};
% cat 11 means f
% cat 12 means a
% cat 21 22 23 means eig
% cat 3x means comp

T10 = array2table(m10,'VariableNames',head10);
T60 = array2table(m60,'VariableNames',head60);

% all digit, no NaN 
m10d = m10; m10d(isnan(m10d))=0;
m60d = m60; m60d(isnan(m60d))=0;
T10d = array2table(m10d,'VariableNames',head10);
T60d = array2table(m60d,'VariableNames',head60);









end
