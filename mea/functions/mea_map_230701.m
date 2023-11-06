function M = mea_map_230701()
% only part of the map was shown in this function. 
% please define your own dictionary and mapping

%% ============= ini =============
M = struct();
selectedCh = [];

%% ============= map definitions ================ 
%% utility 
selectedCh{1} = 1:9999; 

%% sleep collection 
	% 101s deep sleep
	selectedCh{101} = [10, 101, 1010:1019]; 
	% 102s shallow sleep
	selectedCh{102} = [11, 102, 1020:1029];
	selectedCh{103} = [103, 1031:1039];
	selectedCh{104} = [104, 1041:1049];
	% 100s unsleep
	selectedCh{100} = [100, 1000:1009];

%% lc
	selectedCh{11} = [ 11:19,  110:199, 1100:1999  ];% 1k
	selectedCh{12} = [ 20:29, 200:299,  2000:2999  ];% 2k cSys
	selectedCh{13} = [ [30:39], [300:399],  [3000:3999]  ];% 3k
	selectedCh{14} = [ [40:49], [400:499],  [4000:4999]  ];% 4k
	selectedCh{15} = [ [50:59], [500:599],  [5000:5999]  ];% 5k 
	selectedCh{16} = [ [60:69], [600:699],  [6000:6999]  ];% 6k 
	selectedCh{17} = [ [70:79], [700:799],  [7000:7999]  ];% 7k 
	selectedCh{18} = [ [80:89], [800:899],  [8000:8999]  ];% 8k 
	selectedCh{19} = [ [90:99], [900:999],  [9000:9999]  ];% 9k 


%% ============== something about the selectedCh - i don't remember what i wrote =============== 
definedChGp = ~cellfun(@isempty,selectedCh) ;
definedChGpCount = nnz(	definedChGp   );
definedChGpIndex = find(definedChGp==1); 

%% ============== summon up container.Map ==============
tic
for mk = 1:length(selectedCh)
	M.gp{mk} = chMapForge_210927(selectedCh{mk}); 
end
toc


M.selectedCh = selectedCh;
M.definedChGpCount = definedChGpCount;
M.definedChGpIndex = definedChGpIndex;

% you may want to save the maps
