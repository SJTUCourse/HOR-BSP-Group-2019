  
function varargout = Oscilloscope_Project1(varargin)
% OSCILLOSCOPE_PROJECT1 MATLAB code for Oscilloscope_Project1.fig
%      OSCILLOSCOPE_PROJECT1, by itself, creates a new OSCILLOSCOPE_PROJECT1 or raises the existing
%      singleton*.
%
%      H = OSCILLOSCOPE_PROJECT1 returns the handle to a new OSCILLOSCOPE_PROJECT1 or the handle to
%      the existing singleton*.
%
%      OSCILLOSCOPE_PROJECT1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OSCILLOSCOPE_PROJECT1.M with the given input arguments.
%
%      OSCILLOSCOPE_PROJECT1('Property','Value',...) creates a new OSCILLOSCOPE_PROJECT1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Oscilloscope_Project1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Oscilloscope_Project1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Oscilloscope_Project1

% Last Modified by GUIDE v2.5 17-Oct-2019 15:46:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Oscilloscope_Project1_OpeningFcn, ...
                   'gui_OutputFcn',  @Oscilloscope_Project1_OutputFcn, ...
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

% --- Executes just before Oscilloscope_Project1 is made visible.
function Oscilloscope_Project1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Oscilloscope_Project1 (see VARARGIN)

% Choose default command line output for Oscilloscope_Project1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

set(handles.radiobutton_fft,'value',0);
set(handles.radiobutton_filter,'value',0);
set(handles.radiobutton_highpass,'value',0);
set(handles.radiobutton_lowpass,'value',0);
set(handles.radiobutton_channel0,'value',0);
set(handles.radiobutton_channel1,'value',0);
set(handles.radiobutton_channel2,'value',0);
set(handles.radiobutton_channel3,'value',0);
y_high=1.5;
y_low=-1.5;
handles.y_high=y_high;
handles.y_low=y_low;
guidata(hObject,handles);

% Edittor: Ran 2019/10/14
dataAI = zeros(1024,4); 
dataNum=1;
% Pre-assigned memeroy, Attention this might be insufficient.
% Simultaneously change the value in "BEGIN" callback function when change happens here.
% LineHandles = zeros(4,1);
% Pre-assigned memeroy, Attention this might be insufficient.
% Simultaneously change the value in "BEGIN" callback function when change happens here.
LineActivity = zeros(4,1);
handles.LineActivity = LineActivity;
handles.dataAI = dataAI;
handles.dataNum = dataNum;
guidata(hObject,handles);

val = zeros(4,1);  %��������ֵ
handles.val = val;
guidata(hObject,handles);
end

% UIWAIT makes Oscilloscope_Project1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Oscilloscope_Project1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end


function edit_y_high_Callback(hObject, eventdata, handles)
% hObject    handle to edit_y_high (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
y_high = str2double(get(handles.edit_y_high,'string'));  %Ϊʲôֻ����str2double����������str2num��
handles.y_high=y_high;
guidata(hObject,handles);
axes(handles.axes1);
%set(handles.axes1,'XLim',[0,10],'YLim',[y_low,y_high]);
y_low=handles.y_low;
set(handles.axes1,'YLim',[y_low,y_high]);

% Hints: get(hObject,'String') returns contents of edit_y_high as text
%        str2double(get(hObject,'String')) returns contents of edit_y_high as a double
end

% --- Executes during object creation, after setting all properties.
function edit_y_high_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

function edit_y_low_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

function edit_y_low_Callback(hObject, eventdata, handles)
y_low = str2double(get(handles.edit_y_low,'string'));  
handles.y_low=y_low;
guidata(hObject,handles);
axes(handles.axes1);
%set(handles.axes1,'XLim',[0,10],'YLim',[y_low,y_high]);
y_high=handles.y_high;
set(handles.axes1,'YLim',[y_low,y_high]);
end


% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% --- Executes on button press in pushbutton_begin.
% Edittor:YCRan 2019/10/17
% Button: Start Sampling
% This function initilize the sampling process by reseting axes areas and
% calling InstantAI_Project1.
% 
% InstantAI_Project1 calls a timer function that get data from AI Channel 0 ~
% Channel 3 of Device USB-4704,BID#0, the outputs are dataAI, dataNum, and
% Realtime Plots. dataAI and dataNum are stored in GUIDATA.
function pushbutton_begin_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_begin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Initilization.
AxesHandles = handles.AxesHandles;
for i = 1:4
    cla(AxesHandles(i)); % clear exsisted data in graphs.
    line = animatedline(AxesHandles(i)); % build/re-build animatedline.
    handles.LineHandles(i) = line;
end

guidata(hObject,handles);

InstantAI_Project1(hObject,handles);% Start sampling in all axes areas.
    
% test code:
% LineHandles = handles.LineHandles;
%       for i = 1:4
%             Realtimeplot_Project1(1:100,1:100,LineHandles(i));
%       end
% end

guidata(hObject,handles);
% submit new input signal to database.

end
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %



% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
AxesHandles = gca;
handles.AxesHandles(1) = AxesHandles;
guidata(hObject,handles);
% Hint: place code in OpeningFcn to populate axes1
end
% --- Executes during object creation, after setting all properties.

function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double
end

% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

% --- Executes on button press in pushbutton_getcoordinate.
function pushbutton_getcoordinate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_getcoordinate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1)
datacursormode on;
% dcm_obj=datacursormode(gcf);
% set(dcm_obj,'DisplayStyle','datatip','Enable','on')
% for i=1:10
%     disp('click')
%     pause
%     c_info=getCursorInfo(dcm_obj);
%     pos=c_info.Position;
%     set(handles.edit4,'string',pos(1));
%     set(handles.edit5,'string',pos(2));
% end
end

function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double
end

% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
v1 = get(handles.slider1,'value');      %v1�ǻ�������ֵ��һ��ʼ��dataNum������������ֵ��v1+50
handles.val(1)=v1;
guidata(hObject,handles);
if v1>=150
    set(handles.axes1,'XLim',[v1-150,v1+50]);
else set(handles.axes1,'XLim',[0,200]);
end

end

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
end

% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
v4 = get(handles.slider4,'value');
handles.val(4)=v4;
guidata(hObject,handles);
if v4>=150
    set(handles.axes1,'XLim',[v4-150,v4+50]);
else set(handles.axes1,'XLim',[0,200]);
end
end

% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
end

% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
v2 = get(handles.slider2,'value');
handles.val(2)=v2;
guidata(hObject,handles);
if v2>=150
    set(handles.axes1,'XLim',[v2-150,v2+50]);
else set(handles.axes1,'XLim',[0,200]);
end
end

% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
end

function slider3_Callback(hObject, eventdata, handles)
v3 = get(handles.slider3,'value');
handles.val(3)=v3;
guidata(hObject,handles);
if v3>=150
    set(handles.axes1,'XLim',[v3-150,v3+50]);
else set(handles.axes1,'XLim',[0,200]);
end
end

% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
end

function slider5_Callback(hObject, eventdata, handles)
v1=handles.val(1);
set(handles.slider5,'max',200);
set(handles.slider5,'min',0);
if v1>=150
    xmin=v1-150;xmax=v1+50;
else xmin=0;xmax=200;
end
gainvalue=get(handles.slider5,'value');
xmax=xmax+50-gainvalue;
xmin=xmin-50+gainvalue;
N=handles.dataNum(1);
if xmax>N+50
    xmax=N+50;end
if xmin<0
    xmin=0;end
set(handles.axes1,'XLim',[xmin,xmax]);
end

% --- Executes during object creation, after setting all properties.
function slider5_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
end


% --- Executes on button press in pushbutton_stop.
function pushbutton_stop_Callback(hObject, eventdata, handles)
uiresume(handles.figure1);
Max=handles.dataNum;
set(handles.slider1,'min',0)
set(handles.slider1,'max',Max);
set(handles.slider1,'value',Max);
dataAI=handles.dataAI;
axes(handles.axes1);
set(handles.axes1,'XLim',[Max-150,Max+50]);
plot(dataAI(:,1));
axes(handles.axes2);
set(handles.axes2,'XLim',[Max-150,Max+50]);
plot(dataAI(:,2));
axes(handles.axes3);
set(handles.axes4,'XLim',[Max-150,Max+50]);
plot(dataAI(:,3));
axes(handles.axes4);
set(handles.axes4,'XLim',[Max-150,Max+50]);
plot(dataAI(:,4));
end


function edit_sample_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sample (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Fs=str2double(get(handles.edit_sample,'string'));
handles.Fs=Fs;
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of edit_sample as text
%        str2double(get(hObject,'String')) returns contents of edit_sample as a double
end

% --- Executes during object creation, after setting all properties.
function edit_sample_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sample (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject,'string','1');
handles.Fs = 1;
guidata(hObject,handles);
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

% --- Executes on button press in pushbutton_process.
function pushbutton_process_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_process (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dataAI=handles.dataAI;
Fs=handles.Fs;
fc=handles.fc;
choose_channel=handles.choose_channel;
process=handles.process;
x=dataAI(:,choose_channel);
N=length(x);
switch process
    case 1
       [n,y]=filter_highpass(Fs,x,fc);
        axes(handles.axes5);plot(n/Fs,y);
       xlabel('ʱ��/s');ylabel('��ѹ/V');grid on;
       [f,yy]=signal_fft(y,Fs);
       axes(handles.axes8);
       % %������ʾ��ʽ
       plot(f(1:N/2),yy(1:N/2)*2/N);
       xlabel('Ƶ��/Hz');ylabel('���');grid on;   
    case 2
        [n,y]=filter_lowpass(Fs,x,fc);
        axes(handles.axes5);plot(n/Fs,y);
        xlabel('ʱ��/s');ylabel('��ѹ/V');grid on;
       [f,yy]=signal_fft(y,Fs);
       axes(handles.axes8);
       % %������ʾ��ʽ
       plot(f(1:N/2),yy(1:N/2)*2/N);
       xlabel('Ƶ��/Hz');ylabel('���');grid on;  
    case 3
        [f,y]=signal_fft(x,Fs);
        axes(handles.axes5);
       %˫����ʾ��ʽ
       plot(f,y/N);
       xlabel('Ƶ��/Hz');ylabel('���');grid on;
       %������ʾ��ʽ
       axes(handles.axes8);
       plot(f(1:N/2),y(1:N/2)*2/N);
       xlabel('Ƶ��/Hz');ylabel('���');grid on;     
end        
end


function edit_fc_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fc as text
%        str2double(get(hObject,'String')) returns contents of edit_fc as a double
fc = str2num(get(handles.edit_fc,'string'));
handles.fc=fc;
guidata(hObject,handles);
end

% --- Executes during object creation, after setting all properties.
function edit_fc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

% --- Executes on button press in pushbutton_import.
function pushbutton_import_Callback(hObject, eventdata, handles)
file = [pathname,filename];

if ischar(filename)
    dataAI = Signalread(file); 
    handles.dataAI = dataAI;
    guidata(hObject,handles);
end


% display data read on axes areas.
if ischar(filename)
    AxesHandles = handles.AxesHandles;
    for i = 1:4
        cla(AxesHandles(i)); % clear exsisted data in graphs.
        plot(AxesHandles(i),dataAI(:,i));
    end
end

y_high=handles.y_high;
y_low=handles.y_low;
set(handles.axes1,'YLim',[y_low,y_high]);

guidata(hObject,handles);
end

% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
datasave = handles.dataAI;
[filename, pathname, filterindex] = uiputfile( ...
{'*.mat','MATLAB Data (*.m)';
 '*.csv','CSV(���ŷָ�)(*.csv)';...
 '*.txt','Unicode�ı�(*.txt)';...
 '*.xls','Excel ������(*.xls)'});
% call windows explorer to save the file.
% if the explorer is closed without confirming save, filename will be 0.


file = [pathname,filename];

filesave = Signalwrite;
% filesave = [filewrite,suffix(filterindex)];
if ischar(filename)
%     if explorer is closed without confirming save, filename will be 0.
    switch filterindex
        case 1 %.mat
            filesave.mat(datasave,file);
        case 2 %.csv
            filesave.csv(datasave,file);
        case 3 %.txt
            filesave.txt(datasave,file);
        case 4 %.xls
            filesave.xls(datasave,file);
        otherwise
            fprintf('Save Failled! Unexpected erro occurred!');
    end
    
    fprintf('Save Succeeded!');
    
end
end

% --- Executes on button press in radiobutton_filter.
function radiobutton_filter_Callback(hObject, eventdata, handles)
filt=1;
handles.filt=filt;
guidata(hObject,handles);
end

% --- Executes on button press in radiobutton_highpass.
function radiobutton_highpass_Callback(hObject, eventdata, handles)
filt=handles.filt;
process=1;
handles.process=process;
guidata(hObject,handles);
if filt==0
    errordlg('δѡ���˲���������ʽ');
end
end

% --- Executes on button press in radiobutton_lowpass.
function radiobutton_lowpass_Callback(hObject, eventdata, handles)
filt=handles.filt;
process=2;
handles.process=process;
guidata(hObject,handles);
if filt==0
    errordlg('δѡ���˲���������ʽ');
end
end

% --- Executes on button press in radiobutton_fft.
function radiobutton_fft_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_fft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
process=3;
handles.process=process;
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle state of radiobutton_fft
end

% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
AxesHandles = gca;
handles.AxesHandles(2) = AxesHandles;
guidata(hObject,handles);
% Hint: place code in OpeningFcn to populate axes2
end


% --- Executes during object creation, after setting all properties.
function axes3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
AxesHandles = gca;
handles.AxesHandles(3) = AxesHandles;
guidata(hObject,handles);
% Hint: place code in OpeningFcn to populate axes3
end

% --- Executes during object creation, after setting all properties.
function axes4_CreateFcn(hObject, eventdata, handles)
AxesHandles = gca;
handles.AxesHandles(4) = AxesHandles;
guidata(hObject,handles);
end

% 
% % --- Executes on button press in checkbox4.
% function checkbox4_Callback(hObject, eventdata, handles)
% % hObject    handle to checkbox4 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% LineActivity =  get(hObject,'Value'); 
% handles.LineActivity(1) = LineActivity;
% guidata(hObject,handles);
% end
% % Hint: get(hObject,'Value') returns toggle state of checkbox4
% 


% --- Executes during object creation, after setting all properties.
function radiobutton_channel0_CreateFcn(hObject, eventdata, handles)
end
% --- Executes on button press in radiobutton_channel0.
function radiobutton_channel0_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_channel0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
choose_channel=1;
handles.choose_channel=choose_channel;
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle state of radiobutton_channel0
end

% --- Executes during object creation, after setting all properties.
function radiobutton_channel1_CreateFcn(hObject, eventdata, handles)
end
% --- Executes on button press in radiobutton_channel1.
function radiobutton_channel1_Callback(hObject, eventdata, handles)
choose_channel=2;
handles.choose_channel=choose_channel;
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle state of radiobutton_channel1
end
% --- Executes during object creation, after setting all properties.
function radiobutton_channel2_CreateFcn(hObject, eventdata, handles)
end
% --- Executes on button press in radiobutton_channel2.
function radiobutton_channel2_Callback(hObject, eventdata, handles)
choose_channel=3;
handles.choose_channel=choose_channel;
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle state of radiobutton_channel2
end
% --- Executes during object creation, after setting all properties.
function radiobutton_channel3_CreateFcn(hObject, eventdata, handles)
end
% --- Executes on button press in radiobutton_channel3.
function radiobutton_channel3_Callback(hObject, eventdata, handles)
choose_channel=4;
handles.choose_channel=choose_channel;
guidata(hObject,handles);
end

% --- Executes during object deletion, before destroying properties.
function pushbutton_stop_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear global 
end