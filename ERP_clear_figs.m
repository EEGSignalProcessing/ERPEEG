function ERP_clear_figs()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

main_fig = findobj('type','figure','name','erpeeg');
set(main_fig,'HandleVisibility','off');
close all;
set(main_fig,'HandleVisibility','on');

end

