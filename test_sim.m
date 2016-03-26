
%a = sim('Sikmy_vrh_2','ReturnWorkspaceOutputs', 'on');
%b = a.get('ScopeDataY')
%assignin('base','b',b);

A = [1.12, 2, 3, 4.12];
B = [1.12, 2, 3, 4, 5, 6, 7, 8];
C = setdiff(B, A)

%ScopeDataVY(2,2);

ScopeDataX(:,1)=[]