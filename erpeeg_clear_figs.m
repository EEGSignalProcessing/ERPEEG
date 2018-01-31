function erpeeg_clear_figs()

main_fig = findobj('type','figure','name','erpeeg');
set(main_fig,'HandleVisibility','off');
close all;
set(main_fig,'HandleVisibility','on');

end

