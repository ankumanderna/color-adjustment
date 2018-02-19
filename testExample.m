function varargout = testExample(varargin)
% TESTEXAMPLE MATLAB code for testExample.fig
%      TESTEXAMPLE, by itself, creates a new TESTEXAMPLE or raises the existing
%      singleton*.
%
%      H = TESTEXAMPLE returns the handle to a new TESTEXAMPLE or the handle to
%      the existing singleton*.
%
%      TESTEXAMPLE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TESTEXAMPLE.M with the given input arguments.
%
%      TESTEXAMPLE('Property','Value',...) creates a new TESTEXAMPLE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before testExample_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to testExample_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help testExample

% Last Modified by GUIDE v2.5 10-Oct-2017 12:21:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @testExample_OpeningFcn, ...
                   'gui_OutputFcn',  @testExample_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before testExample is made visible.
function testExample_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to testExample (see VARARGIN)

% Choose default command line output for testExample
handles.output = hObject;
load('Img.mat');
handles.Img = Img;
handles.Mask = Mask;
handles.chosenSet = randperm(size(Img,4),24);
monitorPos = get(0,'monitorposition');
set(handles.figure1,'position',[1 1 1920 1080],'color',[0.5 0.5 0.5]);
set(handles.figure1,'WindowKeyPressFcn',@figureKeyPress);
% set the axes properties, positions and the colors
for row = 1:4
    for col = 1:6
        num = col+(row-1)*6;
        axname = ['axes' num2str(num)];
        set(handles.(axname),'visible','off');
    end
end
drawnow;
for row = 1:4
    for col = 1:6
        num = col+(row-1)*6;
        axname = ['axes' num2str(num)];
        pos = [1/6*(col-1) + 1/6*1/4,((4-row)*(1/4) + 1/4*3/4), 0.125, 0.1875].*[0.95 0.85 1 1];
        pos = pos - [0 0.1 0 0];
        set(handles.(axname),'Position',pos,'Units','normalized', 'color',[1 1 1]*0.75,...
            'XColor',[1 1 1], 'YColor', [1 1 1],'xtick',[],'ytick',[],'visible','on');
        showHandle = ['imgHandle' num2str(num)];
        handles.(showHandle) = imshow(handles.Img(:,:,:,handles.chosenSet(num)),...
            'Parent',handles.(axname));
        set(handles.(showHandle),'Tag',num2str(num),'ButtonDownFcn',@ImageClickCallback);
    end
end
chosenOne = randperm(24,1);
axname = ['axes' num2str(chosenOne)];
%%%
imgT = handles.Img(:,:,:,handles.chosenSet(chosenOne));
mask = logical(handles.Mask(:,:,handles.chosenSet(chosenOne)));
imgT(mask) = rand(1);
%%%
showHandle = ['imgHandle' num2str(chosenOne)];
handles.(showHandle) = imshow(imgT,'Parent',handles.(axname));
set(handles.(showHandle),'Tag',num2str(chosenOne),'ButtonDownFcn',@ImageClickCallback);
% the trial tracking
handles.currentTrial = 1;
% chosen Data
handles.chosenData = [];
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes testExample wait for user response (see UIRESUME)
% uiwait(handles.figure1);
function ImageClickCallback(hObject,eventdata)
fprintf('the current axis clicked is %s. \n', get(hObject,'Tag'));
goNextTrial(hObject);

function figureKeyPress(hObject,eventdata)

goNextTrial(hObject);

function goNextTrial(hObject)
handles = guidata(hObject);
handles.currentTrial = handles.currentTrial + 1;
%%% set the visible off
 for ii  = 1:24
    set(handles.(['imgHandle' num2str(ii)]),'visible','off')
 end
drawnow;
pause(rand(1)+1);
%%% show images
handles.chosenSet = randperm(size(handles.Img,4),24);
for row = 1:4
    for col = 1:6
        num = col+(row-1)*6;
        axname = ['axes' num2str(num)];
        set(handles.(axname),'visible','on');
        showHandle = ['imgHandle' num2str(num)];
        handles.(showHandle) = imshow(handles.Img(:,:,:,handles.chosenSet(num)),...
            'Parent',handles.(axname));
        set(handles.(showHandle),'visible','on','Tag',num2str(num),'ButtonDownFcn',@ImageClickCallback);
    end
end
chosenOne = randperm(24,1);
axname = ['axes' num2str(chosenOne)];
%%%
imgT = handles.Img(:,:,:,handles.chosenSet(chosenOne));
mask = logical(handles.Mask(:,:,handles.chosenSet(chosenOne)));
imgT(mask) = rand(1);
%%%
showHandle = ['imgHandle' num2str(chosenOne)];
handles.(showHandle) = imshow(imgT,'Parent',handles.(axname));
set(handles.(showHandle),'visible','on','Tag',num2str(chosenOne),'ButtonDownFcn',@ImageClickCallback);
pause(rand(1));
drawnow;
guidata(handles.figure1,handles);



% --- Outputs from this function are returned to the command line.
function varargout = testExample_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
close(handles.figure1);


% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
