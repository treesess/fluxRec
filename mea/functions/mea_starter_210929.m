function mea = mea_starter_210929()


%% 0 workplace/path set up
	[~,workplace] = system('systeminfo'); % computer name extraction
	workplace = workplace(29:32); % 
	switch workplace
	case 'TREE' % yard/heya Y5070
		mea.path = 'D:\OneDrive\2232.mea210927';
	case 'FLIP' % flip
		mea.path ='C:\OneDrive\2232.mea210927';
	case 'MINI' % heya mini pc 1
		mea.path ='D:\OneDrive\2232.mea210927';
	end
	
	cd(mea.path);
	addpath(genpath(fullfile(mea.path,'m')));
