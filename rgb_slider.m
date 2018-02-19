function varargout = rgb_slider(varargin)
% RGB_SLIDER MATLAB code for rgb_slider.fig
%      RGB_SLIDER, by itself, creates a new RGB_SLIDER or raises the existing
%      singleton*.
%
%      H = RGB_SLIDER returns the handle to a new RGB_SLIDER or the handle to
%      the existing singleton*.
%
%      RGB_SLIDER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RGB_SLIDER.M with the given input arguments.
%
%      RGB_SLIDER('Property','Value',...) creates a new RGB_SLIDER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before rgb_slider_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to rgb_slider_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help rgb_slider

% Last Modified by GUIDE v2.5 08-Nov-2017 13:22:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @rgb_slider_OpeningFcn, ...
                   'gui_OutputFcn',  @rgb_slider_OutputFcn, ...
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


% --- Executes just before rgb_slider is made visible.
function rgb_slider_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to rgb_slider (see VARARGIN)

% Choose default command line output for rgb_slider
handles.output = hObject;
%load the image file list
handles.folder = dir('images/image*.jpg');
%load the folder to save the reuslts file
handles.folder = dir('results/');

% configure sliders
set(handles.Rslider,'Min',0);
set(handles.Rslider,'Max',100);
set(handles.Gslider,'Min',0);
set(handles.Gslider,'Max',100);
set(handles.Bslider,'Min',0);
set(handles.Bslider,'Max',100);


% setup images for display
% currentRGB = [0,1,1];
% % currentRGB = ;
% % image(handles.image1,currentRGB);
% set(handles.image1,'Color',currentRGB);
% handles.currentRGB = currentRGB;

% create array of colors to use, 5 colors here 
handles.colorArray = [0,0,0;0,0,1;0.5,0.5,0.5;1,0,1;1,1,1];
% create an idx for random 5.
handles.order = randperm(5)
currentRGB = handles.colorArray(handles.order(1),:);
handles.count = 1;
handles.results = zeros(5,3);
set(handles.image1,'Color',currentRGB);
handles.currentRGB = currentRGB;
% handles.names = 'abc';
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes rgb_slider wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = rgb_slider_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in nextButton.
function nextButton_Callback(hObject, eventdata, handles)
% hObject    handle to nextButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
if handles.count < length(handles.colorArray)
% set(handles.nextButton,'Enable','off');

handles.results(handles.order,1) = get(handles.Rslider,'Value');
handles.results(handles.order,2) = get(handles.Gslider,'Value');
handles.results(handles.order,3) = get(handles.Bslider,'Value');

handles.count = handles.count+1
handles.currentRGB = handles.colorArray(handles.order(handles.count),:);
set(handles.image1,'Color',handles.currentRGB);
else
    
handles.results(handles.order,1) = get(handles.Rslider,'Value');
handles.results(handles.order,2) = get(handles.Gslider,'Value');
handles.results(handles.order,3) = get(handles.Bslider,'Value');
    
      results = handles.results;
%     names = handles.names;
    save(['results/','results.txt'],'-ascii','results');
    disp('done');
end
guidata(hObject, handles);
% Set the button string to "Next"

% Save the current slider values

% while there are colors:
%    choose the next CIELAB color
%    store that color in handles.currentLab
%    convert to RGB
%    make the image that RGB color
%    if we are on the last color, set button strng to "End"

% end
% display "Thank you!"



% --- Executes on slider movement.
function Rslider_Callback(hObject, eventdata, handles)
% hObject    handle to Rslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles = guidata(hObject);
r = get(handles.Rslider,'Value');
set(handles.image1,'Color',[(r/100),handles.currentRGB(2),handles.currentRGB(3)]);
% handles.output = hObject;
% 
% % Update handles structure
guidata(hObject, handles);

 
% --- Executes during object creation, after setting all properties.
function Rslider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Rslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function Gslider_Callback(hObject, eventdata, handles)
% hObject    handle to Gslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles  = guidata(hObject);
g = get(handles.Gslider,'Value');
set(handles.image1,'Color',[handles.currentRGB(1),(g/100),handles.currentRGB(3)]);
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function Gslider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Gslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes during object creation, after setting all properties.
function image1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to image1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate image1


% function newRGB = adjustPatchRGB(currentLab,newLab)
%   a  =rgb2lab(currentRGB)
%   b  = lab2rgb(imageLAB)
%   
%   
%   currentLAB = newLAB;
%   b = lab2rgb(currentLAB);
%   newRGB = c; 
%   
   


% --- Executes on slider movement.
function Bslider_Callback(hObject, eventdata, handles)
% hObject    handle to Bslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles = guidata(hObject);
b = get(handles.Bslider,'Value');
set(handles.image1,'Color',[handles.currentRGB(2),handles.currentRGB(2),(b/100)]);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function Bslider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Bslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
