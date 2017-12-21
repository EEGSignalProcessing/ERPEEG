% Author: Matthew Frehlich, Ye Mei, Luis Garcia Dominguez,Faranak Farzan
% 2016

% tmseeg_settings() - User-adjustable variables for use in TMSEEG toolbox.
% 
% Inputs: 
%     S             - parent GUI information (structure)

% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 2 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% Updated on Nov 2017 by Ben Schwartzmann


function [] = ERP_settings(S)
global backcolor
hfig = figure('menubar','none',...
              'Toolbar','none',...
              'Units','normalized',...
              'name','ERP-EEG settings',...
              'color',backcolor,...
              'numbertitle','off',...
              'resize','off',...
              'Position',[0.3 0.3 0.3 0.3],...
              'DockControls','off');

step1_button = uicontrol('Parent', hfig,'Style','pushbutton',...
                    'Units','normalized',...
                    'Position',[0.2 0.86 0.6 0.12],...
                    'Tag','step1_set',...
                    'String','Initial Processing',...
                    'Callback',{@step1_callback,S});
step3_button = uicontrol('Parent', hfig,'Style','pushbutton',...
                    'Units','normalized',...
                    'Position',[0.2 0.7 0.6 0.12],...
                    'Tag','step2_set',...
                    'String','Remove Bad Trials and Channels',...
                    'Callback',{@step2_callback, S});
step7_button = uicontrol('Parent', hfig,'Style','pushbutton',...
                    'Units','normalized',...
                    'Position',[0.2 0.54 0.6 0.12],...
                    'Tag','step4_set',...
                    'String','ICA ',...
                    'Callback',{@step4_callback, S});
step8_button = uicontrol('Parent', hfig,'Style','pushbutton',...
                    'Units','normalized',...
                    'Position',[0.2 0.38 0.6 0.12],...
                    'Tag','step4_set',...
                    'String','ICA Component Removal',...
                    'Callback',{@step5_callback, S});
step9_button = uicontrol('Parent', hfig,'Style','pushbutton',...
                    'Units','normalized',...
                    'Position',[0.2 0.22 0.6 0.12],...
                    'Tag','step6_set',...
                    'String','Remove Bad Trials and Channels 2',...
                    'Callback',{@step6_callback, S});
show_button = uicontrol('Parent', hfig,'Style','pushbutton',...
                    'Units','normalized',...
                    'Position',[0.2 0.06 0.6 0.12],...
                    'Tag','show_set',...
                    'String','View Data',...
                    'Callback',{@show_callback, S});
end

function step1_callback(varargin)
% Settings call for step 1: Initial Processing
global VARS
S = varargin{3};

%Pop-up display settings
prompt = {'Enter Resampling Frequency:',...
            'Baseline Calculation Range'};
dlg_title = 'Step1 Settings';
num_lines = 1;
defaultans = {num2str(VARS.RESAMPLE_FREQ),...
              num2str(VARS.BASELINE_RNG)};
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);

if isempty(answer) %Cancel Button
    disp('No changes made')
else %OK button
    choice = questdlg('Continuing will reset workflow to step 1, continue?');
    
    switch choice %Change Settings
        case 'Yes'
            VARS.RESAMPLE_FREQ = str2double(answer{1});
            VARS.BASELINE_RNG = str2double(answer{2});
            tmseeg_reset_workflow(S,1,S.num_steps)
    end
           
end
end


function step2_callback(varargin)
% Settings call for step 2: Remove bad trials and channels
global VARS
S = varargin{3};

%Pop-up Display
prompt = {'% bad channels allowed in trial','% bad trials allowed in channel',...
            'Start time for ATTRIBUTE extraction','End time for ATTRIBUTE extraction',...
            'Frequency band min (Hz)','Frequency band max (Hz)',...
            'Channel plot ymin','Channel plot ymax'};
dlg_title = 'Step2 Settings';
num_lines = 1;
defaultans = {num2str(VARS.PCT_BAD_CHANS),...
              num2str(VARS.PCT_BAD_TRIALS),...
              num2str(VARS.TIME_ST),...
              num2str(VARS.TIME_END),...
              num2str(VARS.FREQ_MIN),...
              num2str(VARS.FREQ_MAX),...
              num2str(VARS.PLT_CHN_YMIN),...
              num2str(VARS.PLT_CHN_YMAX)};
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);

if isempty(answer) %Cancel Button
    disp('No changes made')
else
    choice = questdlg('Changing these settings will reset workflow to step 2, continue?');

    switch choice
        case 'Yes' %Change settings
            VARS.PCT_BAD_CHANS = str2double(answer{1});
            VARS.PCT_BAD_TRIALS = str2double(answer{2});
            VARS.TIME_ST = str2double(answer{3});
            VARS.TIME_END = str2double(answer{4});
%             VARS.PULSE_ST = str2double(answer{5});
%             VARS.PULSE_END = str2double(answer{6});
            VARS.FREQ_MIN = str2double(answer{5});
            VARS.FREQ_MAX = str2double(answer{6});
            VARS.PLT_CHN_YMIN = str2double(answer{7});
            VARS.PLT_CHN_YMAX = str2double(answer{8});
            tmseeg_reset_workflow(S,2,S.num_steps)
    end
end
end



function step4_callback(varargin)
% Settings call for ICA step 4
global VARS
S = varargin{3};

% Pop-up display settings
prompt = {'Percent of maximum ICA Components'};
dlg_title = 'Step4 Settings';
num_lines = 1;
defaultans = {num2str(VARS.ICA_COMP_PCT)};
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);

if isempty(answer) %Cancel Button
    disp('No changes made')
else
    choice = questdlg('Changing these settings will reset workflow to step 4, continue?');

    switch choice
        case 'Yes' %Update Settings
            VARS.ICA_COMP_PCT    = str2double(answer{1});
            tmseeg_reset_workflow(S,4, S.num_steps)
    end
end

end
function step5_callback(varargin)
% Settings call for ICA 2 step 5
global VARS
S = varargin{3};

% Pop-up display settings
prompt = {'Update window start time (ms)',...
          'Update window end time (ms)',...
          'Update window ymin',...
          'Update window ymax',...
          '(Advanced) Kurtosis Threshold for electrode tagging'};
dlg_title = 'Step5 Settings';
num_lines = 1;
defaultans = {num2str(VARS.UPD_WDW_STRT),...
              num2str(VARS.UPD_WDW_END),...
              num2str(VARS.UPD_WDW_YMIN),...
              num2str(VARS.UPD_WDW_YMAX),...
              num2str(VARS.KURTOSIS_THRESH)};
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);

if isempty(answer) %Cancel Button
    disp('No changes made')
else
    choice = questdlg('Changing these settings will reset workflow to step 5, continue?');

    switch choice
        case 'Yes' %Change Settings
            VARS.UPD_WDW_STRT    = str2double(answer{1});
            VARS.UPD_WDW_END     = str2double(answer{2});
            VARS.UPD_WDW_YMIN    = str2double(answer{3});
            VARS.UPD_WDW_YMAX    = str2double(answer{4});
            VARS.KURTOSIS_THRESH = str2double(answer{5});
            tmseeg_reset_workflow(S,5,S.num_steps)
    end
end

end

function step6_callback(varargin)
% Settings call for step 6: Remove bad channels and trials 2
global VARS
S = varargin{3};

% Set up pop-up display
prompt = {'% bad channels allowed','% bad trials allowed',...
            'Channel plot ymin','Channel plot ymax'};
dlg_title = 'Step6 Settings';
num_lines = 1;
defaultans = {num2str(VARS.PCT_BAD_CHANS_2),...
              num2str(VARS.PCT_BAD_TRIALS_2),...
              num2str(VARS.PLT_CHN_YMIN_2),...
              num2str(VARS.PLT_CHN_YMAX_2)};
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);

if isempty(answer) %Cancel Button
    disp('No changes made')
else
    choice = questdlg('Changing these settings will reset workflow to step 6, continue?');

    switch choice
        case 'Yes' %Change Settings
            VARS.PCT_BAD_CHANS_2 = str2double(answer{1});
            VARS.PCT_BAD_TRIALS_2 = str2double(answer{2});
            VARS.PLT_CHN_YMIN_2 = str2double(answer{3});
            VARS.PLT_CHN_YMAX_2 = str2double(answer{4});
            tmseeg_reset_workflow(S,6,S.num_steps)
    end
end
end

function show_callback(varargin)
% Settings call for View Data button
global VARS
S = varargin{3};

% Set up pop-up display
prompt = {'View Data y limit'};
dlg_title = 'View Data Settings';
num_lines = 1;
defaultans = {num2str(VARS.YSHOWLIMIT)};
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);

if isempty(answer) %Cancel Button
disp('No changes made')
else
    VARS.YSHOWLIMIT = str2double(answer{1});

end
end