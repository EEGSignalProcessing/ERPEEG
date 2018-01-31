% Author: Matthew Frehlich, Ye Mei, Luis Garcia Dominguez,Faranak Farzan
%         2016
%         Ben Schwartzmann 
%         2017

% ERP_main: Main GUI for ERPeeg toolkit, a GUI-based signal
% processing software for ERP-EEG Data.  This program creates the parent
% structures/figures.  Steps in the processing workflow are denoted by
% buttons, which call specific functions encapsulating the processing
% workflow for each step.
% 
% Input Data: ERP-EEG dataset using EEGLABs .set file format 
% 
% Output Data: .set format datasets at each 

% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 2 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.


function []= erpeeg_main()

close all
clc

global basepath basefile backcolor
backcolor   = [0.8 0.9 1];
basefile    = 'None Selected';

% Main object, GUI Parent figure
S      = []; 
S.hfig = figure('Menubar','none',...
            'Toolbar','none',...
            'Units','normalized',...
            'name','erpeeg',...
            'numbertitle','off',...
            'resize','on',...
            'Color',backcolor,...
            'Position',[0.1 0.1 0.6 0.4],...
            'DockControls','off');

%% MAIN GUI BUTTONS/TEST         
global existcolor notexistcolor
existcolor    = [0.7 1 0.7];
notexistcolor = [1 0.7 0.7];

% GUI Button Positioning
v=1/6;
col_1 = 0;
col_2 = 0.4;
col_3 = 0.5;
col_4 = 0.9;
st = 4/6;
stepb_w = 0.4;
sw = 0.1;

% ------------------Main Buttons for processing steps----------------------
S.button1 = uicontrol('Parent', S.hfig,'Style','pushbutton',...
                   'Units','normalized',...
                   'Position',[col_1 st stepb_w v],...
                   'String','1.INITIAL PROCESSING',...
                   'BackgroundColor',notexistcolor,... %[1 1 0.7]
                   'Callback',{@button_callback1,S});
S.button2 = uicontrol('Parent', S.hfig,'Style','pushbutton',...
                   'Units','normalized',...
                   'Position',[col_1 st-v stepb_w v],...
                   'String','2.REMOVE BAD TRLs AND CHNs 1',...
                   'BackgroundColor',notexistcolor,...
                   'Callback',{@button_callback2,S});
S.button3 = uicontrol('Parent', S.hfig,'Style','pushbutton',...
                   'Units','normalized',...
                   'Position',[col_1 st-2*v stepb_w v],...
                   'String','3.FILTERING',...
                   'BackgroundColor',notexistcolor,...
                   'Callback',{@button_callback3,S});
S.button4 = uicontrol('Parent', S.hfig,'Style','pushbutton',...
                   'Units','normalized',...
                   'Position',[col_1 st-3*v stepb_w v],...
                   'String','4.ICA',...
                   'BackgroundColor',notexistcolor,...
                   'Callback',{@button_callback4,S});
S.button5 = uicontrol('Parent', S.hfig,'Style','pushbutton',...
                   'Units','normalized',...
                   'Position',[col_3 st stepb_w v],...
                   'String','5.REMOVE ICA COMPONENTS',...
                   'BackgroundColor',notexistcolor,...
                   'Callback',{@button_callback5,S});
S.button6 = uicontrol('Parent', S.hfig,'Style','pushbutton',...
                   'Units','normalized',...
                   'Position',[col_3 st-v stepb_w v],...
                   'String','6.REMOVE BAD TRLs AND CHNs 2',...
                   'BackgroundColor',notexistcolor,...
                   'Callback',{@button_callback6,S});
S.button7 = uicontrol('Parent', S.hfig,'Style','pushbutton',...
                   'Units','normalized',...
                   'Position',[col_3 st-2*v stepb_w v],...
                   'String','7.FINAL PROCESSING',...
                   'BackgroundColor',notexistcolor,...
                   'Callback',{@button_callback7,S}); 
S.button8 = uicontrol('Parent', S.hfig,'Style','pushbutton',...
                   'Units','normalized',...
                   'Position',[col_1 st-4*v 0.5 v],...
                   'String','EEGLAB',...
                   'Callback',{@button_callback8,S}); 
               
% --------------------- Small Buttons for Data Display --------------------
S.button1s = uicontrol('Parent', S.hfig,'Style','pushbutton',...
                   'Units','normalized',...
                   'Position',[col_2 st sw v],...
                   'BackgroundColor',notexistcolor,...
                   'String','View 1',...
                   'Callback',{@button_callback1s,S});
S.button2s = uicontrol('Parent', S.hfig,'Style','pushbutton',...
                   'Units','normalized',...
                   'Position',[col_2 st-v sw v],...
                   'BackgroundColor',notexistcolor,...
                   'String','View 2',...
                   'Callback',{@button_callback2s,S});
S.button3s = uicontrol('Parent', S.hfig,'Style','pushbutton',...
                   'Units','normalized',...
                   'Position',[col_2 st-2*v sw v],...
                   'BackgroundColor',notexistcolor,...
                   'String','View 3',...
                   'Callback',{@button_callback3s,S});
S.button4s = uicontrol('Parent', S.hfig,'Style','pushbutton',...
                   'Units','normalized',...
                   'Position',[col_2 st-3*v sw v],...
                   'BackgroundColor',notexistcolor,...
                   'String','View 4',...
                   'Callback',{@button_callback4s,S});
S.button5s = uicontrol('Parent', S.hfig,'Style','pushbutton',...
                   'Units','normalized',...
                   'Position',[col_4 st sw v],...
                   'BackgroundColor',notexistcolor,...
                   'String','View 5',...
                   'Callback',{@button_callback5s,S});
S.button6s = uicontrol('Parent', S.hfig,'Style','pushbutton',...
                   'Units','normalized',...
                   'Position',[col_4 st-v sw v],...
                   'BackgroundColor',notexistcolor,...
                   'String','View 6',...
                   'Callback',{@button_callback6s,S});
S.button7s = uicontrol('Parent', S.hfig,'Style','pushbutton',...
                   'Units','normalized',...
                   'Position',[col_4 st-2*v sw v],...
                   'BackgroundColor',notexistcolor,...
                   'String','View 7',...
                   'Callback',{@button_callback7s,S}); 
S.button8s = uicontrol('Parent', S.hfig,'Style','pushbutton',...
                   'Units','normalized',...
                   'Position',[col_3 st-4*v 0.5 v],...
                   'String','Settings',...
                   'Callback',{@button_callback8s,S});
S.hbutton1  = uicontrol('Style','pushbutton',...
                    'unit','normalized',...
                    'HorizontalAlignment','left',...
                    'position',[0.0 1-v/2 0.2 v/2],...
                    'fontsize',14,...
                    'Tag','main_text_b',...
                    'string','Working Folder:',...
                    'Callback',{@wkdirbutton_callback,S});
S.hbutton2  = uicontrol('Style','pushbutton',...
                    'unit','normalized',...
                    'HorizontalAlignment','left',...
                    'position',[0.0 1-v 0.2 v/2],...
                    'fontsize',14,...
                    'Tag','file_text_b',...
                    'string','Dataset:',...
                    'Callback',{@datasetbutton_callback,S});

% ----------------------------- Headers -----------------------------------
S.htext1 = uicontrol('Style','text',...
                    'unit','normalized',...
                    'HorizontalAlignment','left',...
                    'position',[0.2 1-v/2 0.8 v/2],...
                    'fontsize',14,...
                    'BackgroundColor',[0.7 0.8 1],...
                    'Tag','main_text',...
                    'string','  Please select data path,first!');
S.htext2 = uicontrol('Style','text',...
                    'unit','normalized',...
                    'position',[0.2 1-v 0.8 v/2],...
                    'HorizontalAlignment','left',...
                    'fontsize',14,...
                    'BackgroundColor',[0.7 0.8 1],...
                    'Tag','file_text',...
                    'string',['  ' basefile]);

% -------------------------------Initial Loading---------------------------
global VARS
VARS = erpeeg_init();

%Must specify number of steps in processing workflow
S.num_steps = 7; 


%% Callback Functions

%Working Directory Callback
function wkdirbutton_callback(varargin)
    %Calls user input for working folder
    basepath = uigetdir(pwd,'Select Data Folder');
    h = findobj('Tag','main_text');
    set(h,'String',['  ' basepath ])
    
    %close all open ERPEEG windows
    set(S.hfig,'HandleVisibility','off')
    close all;
    set(S.hfig,'HandleVisibility','on')
    
    %Re-initialize GUI, variables
    VARS = erpeeg_init();
    basefile    = 'None Selected';
    h = findobj('Tag','file_text');
    set(h,'String',['  ' basefile ])
    guidata(S.hfig,S);
    tmseeg_upd_stp_disp(S, '.set', S.num_steps)   
end

function datasetbutton_callback(varargin)
    %Load Selected dataset, update display
    [filename] = ...
    uigetfile(fullfile(basepath,'*.set'),'Select Original File');
    [~,basefile,ext]         = fileparts(filename);
    tmseeg_upd_stp_disp(S, ext, S.num_steps)
    
    %Update Parent GUI
    h = findobj('Tag','file_text');
    set(h,'String',['  ' basefile ])
    guidata(S.hfig,S);   
end

%Step 1 - Data Loading and Preprocessing
function button_callback1(varargin)
    tmseeg_init_proc(S,1);
end

%Step 2 - Remove Bad Channels and Trials
function button_callback2(varargin)
    erpeeg_rm_ch_tr_1(S,2);
end

%Step 3 - Remove Power line noise, highpass/lowpass filter
function button_callback3(varargin)
    tmseeg_filt(S,3);
end

%Step 4 - Run ICA
function button_callback4(varargin)
    tmseeg_ica2(S,4)
end

%Step 5 - Remove ICA2 Components
function button_callback5(varargin)
     erpeeg_ica2_remove(S,5);
end

% Step 6 - Remove Bad Channels and Trials
function button_callback6(varargin)
    erpeeg_rm_ch_tr_1(S,6);
end

% Step 7 - Interpolation and Final Processing
function button_callback7(varargin)
     erpeeg_interpolation(S,7);
end

% Call to EEGLAB
function button_callback8(varargin)
    eeglab;
end

% View Data buttons
function button_callback1s(varargin)
    erpeeg_show(1);
end

function button_callback2s(varargin)
    erpeeg_show(2);
end

function button_callback3s(varargin)
    erpeeg_show(3);
end

function button_callback4s(varargin)
    erpeeg_show(4);
end

function button_callback5s(varargin)
    erpeeg_show(5);
end

function button_callback6s(varargin)
    erpeeg_show(6);
end

function button_callback7s(varargin)
    erpeeg_show(7);
end

%Call to settings window
function button_callback8s(varargin)
    erpeeg_settings(S);
end

end









