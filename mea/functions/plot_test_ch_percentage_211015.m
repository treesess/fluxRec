function plot_test_ch_percentage_211015(S)
% 210928 test plots
% single lay plot
% 210929 adding details for plots
% 211014 no differentials for comp or not - more of compatible 
% 211014 use new S struct data. 
% 211015 percentage cal

mk = S.mk;

%% 1 daily - nonsense - try moving mean then
% % figure
% % D = [S10.ddmmmyyyy.Ch_count./6,...
% % 	S60.comp.ddmmmyyyy.Ch_count];
% % % % area(D)
% % bar(D,'stacked')

		%% 2 cw
		figure
		paralgp = S.cw.paral./6;
		comp9 = S.cw.comp;
		x = 1:length(paralgp);
		D = [paralgp, comp9];
% 		D = D./time2num(S.cw.duration, "hours").*100; % percentage cal
		D = D./(datenum(S.cw.duration).*24).*100; 
		
		barHandle = bar(x, D,'stacked');
			colorMap = copper(5);
			barHandle(1).FaceColor = colorMap(3,:);
			barHandle(2).FaceColor = colorMap(5,:);
		xlabel('Week');
		ylabel('Percentage');ytickformat('percentage');
		titleText = ['single lay channel(s) activity in week - ',num2str(mk)];
		title(titleText);
		grid on
		
	legend({'paral','comp'})
	legend('Location','northeastoutside')
		
		
		% mean median std max min range
		paralgp(isnan(paralgp))=0;
		comp9(isnan(comp9))=0; 
% 		fullDuration = (paralgp+comp9)./time2num(S.cw.duration, "hours").*100;
		fullDuration = (paralgp+comp9)./(datenum(S.cw.duration).*24).*100;
		display(['cw mean = ', num2str(mean(fullDuration))])
		display(['cw median = ', num2str(median(fullDuration))])
		display(['cw std = ', num2str(std(fullDuration))])
		display(['cw max = ', num2str(max(fullDuration))])
		display(['cw min = ', num2str(min(fullDuration))])
		display(['cw range = ', num2str(range(fullDuration))])
		
		
		%% 3 mo
		figure
		x = S.m.dt; % datetime
		paralgp = S.m.paral./6;
		comp9 = S.m.comp;
		D = [paralgp, comp9];
		
		D = D./(split(S.m.duration,'Days').*24).*100; % percentage cal

		
		barHandle = bar(x,D,'stacked');
			colorMap = copper(5);
			barHandle(1).FaceColor = colorMap(3,:);
			barHandle(2).FaceColor = colorMap(5,:);

	xtickformat('yyMM')
	ax = gca;
	ax.XTick = S.m.dt';
	ax.XTickLabelRotation = 45;

		xlabel('Month');
	ylabel('Percentage');ytickformat('percentage');
		titleText = ['single lay channel(s) activity in month - ',num2str(mk)];
		title(titleText);
		grid on
		legend({'paral','comp'})
		legend('Location','northeastoutside')
		
		% mean median std max min range
		paralgp(isnan(paralgp))=0; 
		comp9(isnan(comp9))=0;
		fullDuration = (paralgp+comp9)./(split(S.m.duration,'Days').*24).*100;;
		
		display(['m mean = ', num2str(mean(fullDuration))])
		display(['m median = ', num2str(median(fullDuration))])
		display(['m std = ', num2str(std(fullDuration))])
		display(['m max = ', num2str(max(fullDuration))])
		display(['m min = ', num2str(min(fullDuration))])
		display(['m range = ', num2str(range(fullDuration))])


		
		%% 4 daily 
		figure
		x = S.d.dt;
		paralgp = S.d.paral./6;
		comp9 = S.d.comp;
		D = [paralgp, comp9];
		
		D = D./24.*100; % cal percentage
		
		
		barHandle = bar(x,D,'stacked');
			colorMap = copper(5);
			barHandle(1).FaceColor = colorMap(3,:);
			barHandle(2).FaceColor = colorMap(5,:);

	xtickformat('yyMM')
	ax = gca;
	ax.XTick = S.m.dt';
	ax.XTickLabelRotation = 45;

		xlabel('Month');
	ylabel('Percentage');ytickformat('percentage');
		titleText = ['single lay channel(s) activity in day - ',num2str(mk)];
		title(titleText);
		grid on
		legend({'paral','comp'})
		legend('Location','northeastoutside')
		
		% mean median std max min range
		paralgp(isnan(paralgp))=0; 
		comp9(isnan(comp9))=0; 
		fullDuration = (paralgp + comp9)./24.*100;
		
		display(['d mean = ', num2str(mean(fullDuration))])
		display(['d median = ', num2str(median(fullDuration))])
		display(['d std = ', num2str(std(fullDuration))])
		display(['d max = ', num2str(max(fullDuration))])
		display(['d min = ', num2str(min(fullDuration))])
		display(['d range = ', num2str(range(fullDuration))])


		
		




end





