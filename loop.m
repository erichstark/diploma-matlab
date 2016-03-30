% clear command window matlab and workspace
clc
clear

% add required libraries
addpath('libs/jsonlab-1.2');

model = 'Sikmy_vrh_2';

Sikmy_vrh_par;

fprintf('%s%s.\n', 'Load model ', model);
load_system(model);

fprintf('%s%s.\n', 'Start simulation of model ', model);
set_param(model,'SimulationCommand','Start');

api = 'http://localhost:3000/';
url = [api 'test'];

% TODO preskumat moznosti options
options = weboptions('MediaType','application/json');

TimeDataSent = [];
TimeDataBefore = [];
vyDataSent = [];
vyDataBefore = [];
xDataSent = [];
xDataBefore = [];
yDataSent = [];
yDataBefore = [];

while 1
   fprintf('%s %s%s\n', 'Reading data from', model, '...');
   
   % nasilu vlozit data do workspace
   set_param(bdroot,'SimulationCommand','WriteDataLogs');
   
   
   % C = setdiff(A,B) returns the data in A that is not in B.
   
   % delete first column - time duplicity
   ScopeDataTime(:,1)=[];
   TimeDataSent = setdiff(ScopeDataTime, TimeDataBefore, 'stable');
   TimeDataBefore = ScopeDataTime;
   
   n = length(TimeDataSent) ; % known final size of array
   A = zeros(1,n) ; % pre-allocation
   for i=1:n,
       A(i) = round(TimeDataSent(i), 2); % a scalar
   end
   
   
   % delete first column - time duplicity
   ScopeDataVY(:,1)=[];
   
   vyDataSent = setdiff(ScopeDataVY, vyDataBefore, 'stable');
   vyDataBefore = ScopeDataVY;
   
   m = length(vyDataSent); % known final size of array
   B = zeros(1,m) ; % pre-allocation
   for i=1:m,
       B(i) = round(vyDataSent(i), 2); % a scalar
   end
   
   % delete first column - time duplicity
   ScopeDataY(:,1)=[];
   
   % stable is key for difference without sorting! http://www.mathworks.com/help/matlab/ref/setdiff.html#btcnv2b-13
   yDataSent = setdiff(ScopeDataY, yDataBefore, 'stable');
   yDataBefore = ScopeDataY;
   
   
   k = length(yDataSent); % known final size of array
   C = zeros(1,k); % pre-allocation
   for i=1:k,
       C(i) = round(yDataSent(i), 2); % a scalar 
   end
   
   % delete first column - time duplicity
   ScopeDataX(:,1)=[];
   
   xDataSent = setdiff(ScopeDataX, xDataBefore, 'stable');
   xDataBefore = ScopeDataX;
   
   j = length(xDataSent); % known final size of array
   D = zeros(1,j); % pre-allocation
   for i=1:j,
       D(i) = round(xDataSent(i), 2); % a scalar
   end
   
   json = savejson('result', struct('status', 'running', 'sessionId', 'xxx72', 'data', struct('time', A, 'vy', B, 'y', C, 'x',D)));
   response = webwrite(url,json,options);
   
   % Ked sa ukonci simulacia, ukoncit while
   if strcmp(get_param(model,'SimulationStatus'), 'running') == 0
       fprintf('%s\n', 'End of simulation.');
       json = savejson('result', struct('status', 'stopped', 'sessionId', 'xxx72', 'data', []));
       response = webwrite(url,json,options);
       break
   end

   pause(0.5);
end