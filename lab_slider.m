function varargout = lab_slider(varargin)
% LAB_SLIDER MATLAB code for lab_slider.fig
%      LAB_SLIDER, by itself, creates a new LAB_SLIDER or raises the existing
%      singleton*.
%
%      H = LAB_SLIDER returns the handle to a new LAB_SLIDER or the handle to
%      the existing singleton*.
%
%      LAB_SLIDER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LAB_SLIDER.M with the given input arguments.
%
%      LAB_SLIDER('Property','Value',...) creates a new LAB_SLIDER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before lab_slider_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to lab_slider_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help lab_slider

% Last Modified by GUIDE v2.5 20-Nov-2017 18:43:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @lab_slider_OpeningFcn, ...
    'gui_OutputFcn',  @lab_slider_OutputFcn, ...
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
end

% --- Executes just before lab_slider is made visible.
function lab_slider_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to lab_slider (see VARARGIN)

% Choose default command line output for lab_slider

handles.output = hObject;
%load the image file list
%load the folder to save the reuslts file
handles.folder = dir('results/');
handles.text= 'grass';
% create array of colors to use, 5 colors here

handles.hAx1 = findobj(hObject, 'Tag','image1');

handles.colorArray = [
    0,0.3608,0.0392;...  grass
    0.1176, 0.5647,1;...  sky
    0.9608,0.8627,0.7098;... beach
    0.8784,0.6745,0.4118;...asian skin
    1,0.8627,0.6980; ... caucasian skin
    0.6275,0.3216,0.1765;...wood
    0.2235,0.4902,0.0078;...greenpepper
    0.6980,0.1333,0.1333]; ...brick
    
currentRGB = handles.colorArray(1,:);
handles.count = 1;
handles.results = zeros(8,3);
set(handles.image1,'Color',currentRGB,'box','off','XColor', [0.5,0.5,0.5], 'YColor', [0.5,0.5,0.5]);

set(handles.hAx1,'xtick',[])
set(handles.hAx1,'ytick',[])
imgLAB = rgb2lab(currentRGB);

set(handles.Lslider,'Value',imgLAB(1))
set(handles.RGslider,'Value',imgLAB(2))
set(handles.YBslider,'Value',imgLAB(3))

guidata(hObject, handles);
edit1_Callback(hObject, eventdata, handles);

set(handles.Lslider,'Min',0);
set(handles.Lslider,'Max',100);
set(handles.Lslider, 'SliderStep', [1/100 , 10/100 ]);
addlistener(handles.Lslider,'Value','PostSet',@(~,~)Lslider_Callback(hObject,eventdata,handles));

set(handles.RGslider,'Min',-128);
set(handles.RGslider,'Max',127);
set(handles.RGslider, 'SliderStep', [1/256 , 10/256 ]);
addlistener(handles.RGslider,'Value','PostSet',@(~,~)RGslider_Callback(hObject,eventdata,handles));

set(handles.YBslider,'Min',-128);
set(handles.YBslider,'Max',127);
set(handles.YBslider, 'SliderStep', [1/256 , 10/256 ]);
addlistener(handles.YBslider,'Value','PostSet',@(~,~)YBslider_Callback(hObject,eventdata,handles));

guidata(hObject, handles);
end

% UIWAIT makes lab_slider wait for user response (see UIRESUME)
% uiwait(handles.lab_figure);


% --- Outputs from this function are returned to the command line.
function varargout = lab_slider_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end


% --- Executes on button press in nextButton.
function nextButton_Callback(hObject, eventdata, handles)
% hObject    handle to nextButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);

if handles.count < length(handles.colorArray)
    
    handles.results(handles.count,1) = get(handles.Lslider,'Value');
    handles.results(handles.count,2) = get(handles.RGslider,'Value');
    handles.results(handles.count,3) = get(handles.YBslider,'Value');
    handles.count = handles.count+1;

    currentRGB = handles.colorArray(handles.count,:);
    set(handles.image1,'Color', currentRGB);
    
    guidata(hObject, handles);
    imgLAB = rgb2lab(currentRGB)
    
    set(handles.Lslider,'Value',imgLAB(1));
    set(handles.RGslider,'Value',imgLAB(2));
    set(handles.YBslider,'Value',imgLAB(3));
    
    disp("L value " + imgLAB(1) + " A value " + imgLAB(2) ...
        + " B value " + imgLAB(3));
    
else    
    handles.results(handles.count,1) = get(handles.Lslider,'Value');
    handles.results(handles.count,2) = get(handles.RGslider,'Value');
    handles.results(handles.count,3) = get(handles.YBslider,'Value');
    
    results = handles.results
    save(['results/','result.mat'],'results');
    imshow('thanks.jpg');
    set(handles.Lslider,'visible','off');
    set(handles.RGslider,'visible','off');
    set(handles.YBslider,'visible','off');
    set(handles.nextButton,'visible','off');
    set(handles.edit1,'visible','off');
    
    for i=4:1:9
        set(handles.(strcat('text',num2str(i))),'visible','off');
    end
end

switch handles.count
    case 2
        handles.text = 'sky';
    case 3
        handles.text = 'beach sand';
    case 4
        handles.text = 'asian skin';
    case 5
        handles.text = 'caucasian skin';
    case 6
        handles.text = 'ply wood';
    case 7
        handles.text = 'skin of green pepper';
    otherwise
        handles.text = 'brick';
end

guidata(hObject, handles);
edit1_Callback(hObject, eventdata, handles);
guidata(hObject, handles);
end


% --- Executes during object creation, after setting all properties.
function image1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to image1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate image1
end

% --- Executes on slider movement.
function Lslider_Callback(hObject, eventdata, handles)
% hObject    handle to Lslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles = guidata(hObject);

l = get(handles.Lslider,'Value');
a = get(handles.RGslider,'Value');
b = get(handles.YBslider,'Value');

disp("L value " + l + " A value " + a + " B value " + b);
imgRGB = lab2rgb([l, a, b],'OutputType','double');

imgRGB(1) = max(imgRGB(1),0);
imgRGB(1) = min(imgRGB(1),1);
imgRGB(2) = max(imgRGB(2),0);
imgRGB(2) = min(imgRGB(2),1);
imgRGB(3) = max(imgRGB(3),0);
imgRGB(3) = min(imgRGB(3),1);

disp(imgRGB * 255)
guidata(hObject, handles);
set(handles.image1,'Color',imgRGB);

% % Update handles structure
guidata(hObject, handles);

end

% --- Executes during object creation, after setting all properties.
function Lslider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Lslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
end


% --- Executes on slider movement.
function RGslider_Callback(hObject, eventdata, handles)
% hObject    handle to RGslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

handles = guidata(hObject);

l = get(handles.Lslider,'Value');
a = get(handles.RGslider,'Value');
b = get(handles.YBslider,'Value');

disp("L value " + l + " A value " + a + " B value " + b);
imgRGB = lab2rgb([l, a, b],'OutputType','double');

imgRGB(1) = max(imgRGB(1),0);
imgRGB(1) = min(imgRGB(1),1);
imgRGB(2) = max(imgRGB(2),0);
imgRGB(2) = min(imgRGB(2),1);
imgRGB(3) = max(imgRGB(3),0);
imgRGB(3) = min(imgRGB(3),1);

disp(imgRGB * 255)
guidata(hObject, handles);
set(handles.image1,'Color',imgRGB);

% % Update handles structure
guidata(hObject, handles);
end



% --- Executes during object creation, after setting all properties.
function RGslider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RGslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
end


% --- Executes on slider movement.
function YBslider_Callback(hObject, eventdata, handles)
% hObject    handle to YBslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles = guidata(hObject);

l = get(handles.Lslider,'Value');
a = get(handles.RGslider,'Value');
b = get(handles.YBslider,'Value');

disp("L value " + l + " A value " + a + " B value " + b);
imgRGB = lab2rgb([l, a, b],'OutputType','double');

imgRGB(1) = max(imgRGB(1),0);
imgRGB(1) = min(imgRGB(1),1);
imgRGB(2) = max(imgRGB(2),0);
imgRGB(2) = min(imgRGB(2),1);
imgRGB(3) = max(imgRGB(3),0);
imgRGB(3) = min(imgRGB(3),1);

disp(imgRGB * 255)
guidata(hObject, handles);
set(handles.image1,'Color',imgRGB);

% % Update handles structure
guidata(hObject, handles);
end



% --- Executes during object creation, after setting all properties.
function YBslider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to YBslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
end


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles = guidata(hObject);
% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double
set(handles.edit1,'string',['Adjust the patch according to your color memory of ',handles.text]);

guidata(hObject, handles);
end

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

% --- Executes when lab_figure is resized.
function lab_figure_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to lab_figure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end
