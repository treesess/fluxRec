function S = S_genOneLay_211016(T10d, T60d, M)

mk = M.mk;

%% initiation
S = struct();
Tcw = table();
Td = table();
Tm = table();

S10 = T10dSelectedChCountSum_210928(	T10d,	M.gp{mk}); %  S for struct
S60 = T60dSelectedChStats_211014(		T60d,	M.gp{mk}); % 

%% Tcw
Tcw.cw = S60.comp.cw.cw; % key
Tcw.paral = S10.cw.Ch_count;
Tcw.f10 = S10.cw.f_sum;
Tcw.a10 = S10.cw.a_sum;
Tcw.comp = S60.comp.cw.Ch_count;
Tcw.f60 = S60.f.cw.f; 
Tcw.a60 = S60.a.cw.a; 
Tcw.duration = ones(length(Tcw.cw),1).*days(7);


%% Td
Td.dt = S60.comp.ddmmmyyyy.datetime; % key, datetime
Td.dn = S60.comp.ddmmmyyyy.ddmmmyyyy; % key, datenum
Td.paral = S10.ddmmmyyyy.Ch_count;
Td.f10 = S10.ddmmmyyyy.f_sum;
Td.a10 = S10.ddmmmyyyy.a_sum;
Td.comp = S60.comp.ddmmmyyyy.Ch_count;
Td.f60 = S60.f.ddmmmyyyy.f;
Td.a60 = S60.a.ddmmmyyyy.a; 
Td.duration = ones(length(Td.dt),1)*days(1);

%% Tm
Tm.dt = S60.comp.mmmyyyy.datetime; % key, datetime
Tm.dn = S60.comp.mmmyyyy.mmmyyyy; % key, datenum
Tm.paral = S10.mmmyyyy.Ch_count;
Tm.f10 = S10.mmmyyyy.f_sum;
Tm.a10 = S10.mmmyyyy.a_sum;
Tm.comp = S60.comp.mmmyyyy.Ch_count;
Tm.f60 = S60.f.mmmyyyy.f; 
Tm.a60 = S60.a.mmmyyyy.a; 
	mo = Tm.dt;
	mo = [mo; mo(end) + calmonths(1)]; % get an extra month
Tm.duration = caldiff(mo,'days');

%% round up
S.cw = Tcw;
S.d = Td;
S.m = Tm;
S.mk = mk;

	
	
