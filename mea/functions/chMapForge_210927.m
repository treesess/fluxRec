function M = chMapForge_210927(selectedCh)

selectedCh = selectedCh     +1     ; %  make up keySet 0 
valueSet = zeros(1e4,1);valueSet(selectedCh) = 1; 
M = containers.Map( 0:1e4-1, valueSet  ); % make of map


