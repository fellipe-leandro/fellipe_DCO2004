function varargout = piano(varargin)
% PIANO MATLAB code for piano.fig
%      PIANO, by itself, creates a new PIANO or raises the existing
%      singleton*.
%
%      H = PIANO returns the handle to a new PIANO or the handle to
%      the existing singleton*.
%
%      PIANO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PIANO.M with the given input arguments.
%
%      PIANO('Property','Value',...) creates a new PIANO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before piano_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to piano_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help piano

% Last Modified by GUIDE v2.5 17-Mar-2019 16:04:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @piano_OpeningFcn, ...
                   'gui_OutputFcn',  @piano_OutputFcn, ...
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


% --- Executes just before piano is made visible.
function piano_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to piano (see VARARGIN)

% Choose default command line output for piano
handles.output = hObject;

% Update handles structure
handles.tf = 0.6;                   % Tempo de duração da nota
handles.fc = 512;                 % Frequência da nota Dó
handles.fs = 100*handles.fc;              % Frequência de amostragem da nota. 
handles.tempo = 0:1/handles.fs:handles.tf;  % Vetor tempo. Para cada elemento do vetor t, haverá um elemento em y correspondente.
guidata(hObject, handles);

% UIWAIT makes piano wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = piano_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in nota_Do.
function nota_Do_Callback(hObject, eventdata, handles)
% hObject    handle to nota_Do (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    axes(handles.Plot_Nota);
    y=6*cos(2*pi*handles.fc*handles.tempo);
    p = audioplayer(y, handles.fs);   % Reproduzir o sinal gerado
    play(p);
    pause(handles.tf);
    plot(handles.tempo,y);
    axis([0 0.02 -10 10 ]);     % Zoom para melhor visualizaçã
    


% --- Executes on button press in Nota_Re.
function Nota_Re_Callback(hObject, eventdata, handles)
% hObject    handle to Nota_Re (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.Plot_Nota);
    y=6*cos(2*(9/8)*pi*handles.fc*handles.tempo);
    p = audioplayer(y, handles.fs);   % Reproduzir o sinal gerado
    play(p);
    pause(handles.tf);
    plot(handles.tempo,y);
    axis([0 0.02 -10 10 ]);     % Zoom para melhor visualizaçã


% --- Executes on button press in Nota_Mi.
function Nota_Mi_Callback(hObject, eventdata, handles)
% hObject    handle to Nota_Mi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
y=6*cos(2*(5/4)*pi*handles.fc*handles.tempo);
    p = audioplayer(y, handles.fs);   % Reproduzir o sinal gerado
    play(p);
    pause(handles.tf);
    plot(handles.tempo,y);
    axis([0 0.02 -10 10 ]);     % Zoom para melhor visualizaçã


% --- Executes on button press in Nota_Fa.
function Nota_Fa_Callback(hObject, eventdata, handles)
% hObject    handle to Nota_Fa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Nota_Sol.
function Nota_Sol_Callback(hObject, eventdata, handles)
% hObject    handle to Nota_Sol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Nota_La.
function Nota_La_Callback(hObject, eventdata, handles)
% hObject    handle to Nota_La (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Nota_Si.
function Nota_Si_Callback(hObject, eventdata, handles)
% hObject    handle to Nota_Si (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
