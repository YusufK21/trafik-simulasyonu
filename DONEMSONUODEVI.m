function varargout = DONEMSONUODEVI(varargin)
% DONEMSONUODEVI MATLAB code for DONEMSONUODEVI.fig
%      DONEMSONUODEVI, by itself, creates a new DONEMSONUODEVI or raises the existing
%      singleton*.
%
%      H = DONEMSONUODEVI returns the handle to a new DONEMSONUODEVI or the handle to
%      the existing singleton*.
%
%      DONEMSONUODEVI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DONEMSONUODEVI.M with the given input arguments.
%
%      DONEMSONUODEVI('Property','Value',...) creates a new DONEMSONUODEVI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DONEMSONUODEVI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DONEMSONUODEVI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DONEMSONUODEVI

% Last Modified by GUIDE v2.5 09-Jun-2022 20:54:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DONEMSONUODEVI_OpeningFcn, ...
                   'gui_OutputFcn',  @DONEMSONUODEVI_OutputFcn, ...
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


% --- Executes just before DONEMSONUODEVI is made visible.
function DONEMSONUODEVI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DONEMSONUODEVI (see VARARGIN)
axes(handles.axes3)
imshow('dortyol.jpg')
axes(handles.axes1)
imshow('inonu.jpg')

axes(handles.axes2)
imshow('yusuf212121.jpeg')



% Choose default command line output for DONEMSONUODEVI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DONEMSONUODEVI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DONEMSONUODEVI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image1
[filename1]=uigetfile('.jpg');
if filename1==2
    msgbox(sprintf('Lütfen 1.Görüntüyü seçiniz'),'HATA','ERROR');
end
axes(handles.axes4)
image1=imread(filename1);
imshow(image1);
image1=imresize(image1,[500 NaN]); % resmi yeniden boyutlandýrdýk
%grileþtirme iþlemi
g=rgb2gray(image1);
g=medfilt2(g,[5 5]);
% morfolojik iþlem 
conc=strel('disk',5);
gi=imdilate(g,conc);
conc1=strel('disk',5);
ge=imerode(gi,conc1); % morfolojik þekil iþleme 
gdiff=imsubtract(gi,ge);
gdiff1=mat2gray(gdiff);
gdiff2=conv2(gdiff1,[1 1;1 1]);
gdiff3=imadjust(gdiff2,[0.4 0.9],[0 1],1);
B=logical(gdiff3);
[a1, b1]=size(B);
er=imerode(B,strel('line',60,8));
out1=imsubtract(B,er);
F=imfill(out1,'holes'); %filling the object
H=bwmorph(F,'thin',0.5);
H=imerode(H,strel('line',8,55));
%Nesnenin alanýný belirleme 18*18lýk denk geldi 
I=bwareaopen(H,floor((a1/18)*(b1/18)));
I(1:floor(.9*a1),1:2)=1;
I(a1:-1:(a1-20),b1:1:(b1-2))=1;
%araba sayýsýný belirleyelim
[B,L] = bwboundaries(I,'noholes');
sayi1=num2str(length(B)-1);
set(handles.text18,'string',sayi1)
%Kýrmýzý iþik süresi hesaplatma%sayi1string yapmýþtým araba sayýsýna onu
%tekrar sayý yaptýk sonra burakta kullandým
sayi11=str2double(sayi1);
yusuf=num2str(40-(sayi11-1)*1.5);
set(handles.text3,'string',yusuf)
%resimlerin kenarýndaki kýrmýzý iþik yancak kaç saniye ise 
%o kadar saycak yeþil yanacak Þuan hepsine birden baþlatcam
% yarýnda t sürelerini ekleyerek 
axes(handles.axes9)
imshow('red.png')
axes(handles.axes8)
 imshow('black.png')
%isil1 k1 kýrmýzýdan yeþile saydýrma süresi ali tam alt degere yuvarladým
isil1=str2double(yusuf);
ali1=floor(isil1);
save ali1.mat;

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image2
[filename2]=uigetfile('.jpg');
if filename2==0
    msgbox(sprintf('Lütfen 2.Görüntüyü seçiniz'),'HATA','ERROR');
end
axes(handles.axes5)
image2=imread(filename2);
imshow(image2);
%araba sayan program
image2=imresize(image2,[500 NaN]); % resmi yeniden boyutlandýrdýk
%grileþtirme iþlemi
g=rgb2gray(image2);
g=medfilt2(g,[5 5]);
% morfolojik iþlem 
conc=strel('disk',5);
gi=imdilate(g,conc);
conc1=strel('disk',5);
ge=imerode(gi,conc1); % morfolojik þekil iþleme 
gdiff=imsubtract(gi,ge);
gdiff1=mat2gray(gdiff);
gdiff2=conv2(gdiff1,[1 1;1 1]);
gdiff3=imadjust(gdiff2,[0.4 0.9],[0 1],1);
B=logical(gdiff3);
[a1, b1]=size(B);
er=imerode(B,strel('line',60,8));
out1=imsubtract(B,er);
F=imfill(out1,'holes'); %filling the object
H=bwmorph(F,'thin',0.5);
H=imerode(H,strel('line',8,55));
%Nesnenin alanýný belirleme 18*18lýk denk geldi 
I=bwareaopen(H,floor((a1/18)*(b1/18)));
I(1:floor(.9*a1),1:2)=1;
I(a1:-1:(a1-20),b1:1:(b1-2))=1;
%araba sayýsýný belirleyelim
[B,L] = bwboundaries(I,'noholes');
sayi2=num2str(length(B)+1);
set(handles.text19,'string',sayi2)
%Kýrmýzý iþik süresi hesaplatma%sayi1string yapmýþtým araba sayýsýna onu
%tekrar sayý yaptýk sonra burakta kullandým
sayi22=str2double(sayi2);
burak2=num2str(40-(sayi22-1)*1.5);
set(handles.text4,'string',burak2)
%resimlerin kenarýndaki kýrmýzý iþik yancak kaç saniye ise 
%o kadar saycak yeþil yanacak
axes(handles.axes11)
imshow('red.png')
axes(handles.axes10)
 imshow('black.png')
%isil1 k2 kýrmýzýdan yeþile saydýrma süresi ali tam alt degere yuvarladým
isil2=str2double(burak2);
ali2=floor(isil2);
save ali2.mat;





% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image3
[filename3]=uigetfile('.jpg');
if filename3==0
    msgbox(sprintf('Lütfen 3.Görüntüyü seçiniz'),'HATA','ERROR');
end
axes(handles.axes6)
image3=imread(filename3);
imshow(image3);
%araba sayan program
image3=imresize(image3,[500 NaN]); % resmi yeniden boyutlandýrdýk
%grileþtirme iþlemi
g=rgb2gray(image3);
g=medfilt2(g,[5 5]);
% morfolojik iþlem 
conc=strel('disk',5);
gi=imdilate(g,conc);
conc1=strel('disk',5);
ge=imerode(gi,conc1); % morfolojik þekil iþleme 
gdiff=imsubtract(gi,ge);
gdiff1=mat2gray(gdiff);
gdiff2=conv2(gdiff1,[1 1;1 1]);
gdiff3=imadjust(gdiff2,[0.4 0.9],[0 1],1);
B=logical(gdiff3);
[a1, b1]=size(B);
er=imerode(B,strel('line',60,8));
out1=imsubtract(B,er);
F=imfill(out1,'holes'); %filling the object
H=bwmorph(F,'thin',0.5);
H=imerode(H,strel('line',8,55));
%Nesnenin alanýný belirleme 18*18lýk denk geldi 
I=bwareaopen(H,floor((a1/18)*(b1/18)));
I(1:floor(.9*a1),1:2)=1;
I(a1:-1:(a1-20),b1:1:(b1-2))=1;
%araba sayýsýný belirleyelim
[B,L] = bwboundaries(I,'noholes');
sayi3=num2str(length(B)+1);
set(handles.text20,'string',sayi3)%Kýrmýzý iþik süresi hesaplatma%sayi1string yapmýþtým araba sayýsýna onu
%tekrar sayý yaptýk sonra burakta kullandým
sayi33=str2double(sayi3);
yusuf3=num2str(40-(sayi33-1)*1.5);
set(handles.text5,'string',yusuf3)
%resimlerin kenarýndaki kýrmýzý iþik yancak kaç saniye ise 
%o kadar saycak yeþil yanacak
axes(handles.axes12)
imshow('red.png')
axes(handles.axes13)
 imshow('black.png')
%isil1 k1 kýrmýzýdan yeþile saydýrma süresi ali tam alt degere yuvarladým
kkaya=str2double(yusuf3);
ali3=floor(kkaya);
save ali3.mat;

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global image4
[filename4]=uigetfile('.jpg');
if filename4==0
    msgbox(sprintf('Lütfen 4.Görüntüyü seçiniz'),'HATA','ERROR');
end
axes(handles.axes7)
image4=imread(filename4);
imshow(image4);
%araba sayan program
image4=imresize(image4,[500 NaN]); % resmi yeniden boyutlandýrdýk
%grileþtirme iþlemi
g=rgb2gray(image4);
g=medfilt2(g,[5 5]);
% morfolojik iþlem 
conc=strel('disk',5);
gi=imdilate(g,conc);
conc1=strel('disk',5);
ge=imerode(gi,conc1); % morfolojik þekil iþleme 
gdiff=imsubtract(gi,ge);
gdiff1=mat2gray(gdiff);
gdiff2=conv2(gdiff1,[1 1;1 1]);
gdiff3=imadjust(gdiff2,[0.4 0.9],[0 1],1);
B=logical(gdiff3);
[a1, b1]=size(B);
er=imerode(B,strel('line',60,8));
out1=imsubtract(B,er);
F=imfill(out1,'holes'); %filling the object
H=bwmorph(F,'thin',0.5);
H=imerode(H,strel('line',8,55));
%Nesnenin alanýný belirleme 18*18lýk denk geldi 
I=bwareaopen(H,floor((a1/18)*(b1/18)));
I(1:floor(.9*a1),1:2)=1;
I(a1:-1:(a1-20),b1:1:(b1-2))=1;
%araba sayýsýný belirleyelim
[B,L] = bwboundaries(I,'noholes');
sayi4=num2str(length(B)-1);
set(handles.text21,'string',sayi4)
%Kýrmýzý iþik süresi hesaplatma%sayi1string yapmýþtým araba sayýsýna onu
%tekrar sayý yaptýk sonra burakta kullandým
sayi44=str2double(sayi4);
burak4=num2str(40-(sayi44-1)*1.5);
set(handles.text6,'string',burak4)
%resimlerin kenarýndaki kýrmýzý iþik yancak kaç saniye ise 
%o kadar saycak yeþil yanacak
axes(handles.axes15)
imshow('red.png')
axes(handles.axes14)
 imshow('black.png')
%isil1 k4 kýrmýzýdan yeþile saydýrma süresi ali tam alt degere yuvarladým
isil4=str2double(burak4);
ali4=floor(isil4);
save ali4.mat;




% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%k3kýrmýzý lamba sim


load('ali3.mat')
t3=1:1:ali3;

axes(handles.axes13)
for i=t3
   if (i==ali3)
      
          imshow('green.png')
       disp('k3yeþilyandý');
   end
    pause(1)
   %disp('.');her saniye göstermesi için 
end
axes(handles.axes12)
imshow('black.png')


%k3yesil yanma süresi
load('yesil.mat');
t2=1:1:yesil;
axes(handles.axes12)
for i=t2
   if (i==yesil)
      
          imshow('red.png')
      % disp('k3kýrmýzý yandý');
   end
    pause(1)
   %disp('.');her saniye göstermesi için 
end
axes(handles.axes13)
imshow('black.png')

%k1 lamba sim
load('ali1.mat')


t1=1:1:ali1;

axes(handles.axes8)
for i=t1
   if (i==ali1)
      
          imshow('green.png')
       disp('k1yeþilyandý');
   end
    pause(1)
   %disp('.');her saniye göstermesi için 
end
axes(handles.axes9)
imshow('black.png')
%k1yesil yanma süresi12
load('yesil.mat');
t2=1:1:yesil;
axes(handles.axes9)
for i=t2
   if (i==yesil)
      
          imshow('red.png')
      % disp('k1kýrmýzý yandý');
   end
    pause(1)
   %disp('.');her saniye göstermesi için 
end
axes(handles.axes8)
imshow('black.png')



%k2kýrmýzý
load('ali2.mat')
t5=1:1:ali2;

axes(handles.axes10)
for i=t5
   if (i==ali2)
      
          imshow('green.png')
       disp('k2yeþilyandý');
   end
    pause(1)
   %disp('.');her saniye göstermesi için 
end
axes(handles.axes11)
imshow('black.png')
%k2yesil yanma süresi
load('yesil.mat');
t2=1:1:yesil;
axes(handles.axes11)
for i=t2
   if (i==yesil)
      
          imshow('red.png')
      %disp('k2kýrmýzý yandý');
   end
    pause(1)
   %disp('.');her saniye göstermesi için 
end
axes(handles.axes10)
imshow('black.png')


%k4 kýrmýzý 
load('ali4.mat')
t4=1:1:ali4;

axes(handles.axes14)
for i=t4
   if (i==ali4)
      
          imshow('green.png')
       disp('k4yeþilyandý');
   end
    pause(1)
   %disp('.');her saniye göstermesi için 
end
axes(handles.axes15)
imshow('black.png')
%k4yesil yanma süresi
load('yesil.mat');
t2=1:1:yesil;
axes(handles.axes15)
for i=t2
   if (i==yesil)
      
          imshow('red.png')
      % disp('k4kýrmýzý yandý');
   end
    pause(1)
   %disp('.');her saniye göstermesi için 
end
axes(handles.axes14)
imshow('black.png')

 msgbox(sprintf('ÝZLEDÝGÝNÝZ  ÝÇÝN TEÞEKKÜR EDERÝM'),'BÝTTÝ')


% --- Executes when figure1 is resized.
function figure1_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
