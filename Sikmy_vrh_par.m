% Parametre pre model so sikmym vrhom
v0      = 50;    % [m/s] pociatocna rychlost v smere hodu
alfa_deg= 60;    % [deg] uhol vrhu v stupnoch

g = 9.81;        % [m/s^2] gravitacne zrychlenie  
if alfa_deg > 90; alfa_deg=90; end;
if alfa_deg < 0;  alfa_deg=0;  end;    
alfa_rad = alfa_deg*2*pi/360;   % [rad] uhol vrhu v radianoch

td = 2*v0*sin(alfa_rad)/g       % [s] cas dopadu
d  = v0^2*sin(2*alfa_rad)/g     % [m] dolet
h  = v0^2*(sin(alfa_rad))^2/g/2 % [m] maximalna vyska

%sim('Sikmy_vrh_2');

%figure(1);
%plot(tout,vY,'b-','LineWidth',2); 
%title('Vertikalna rychlost');
%grid; xlabel('t [s]'); ylabel('v_y [m/s]');
%yL = ylim; axis([0 td yL]);

%figure(2);
%plot(tout,Y,'b-','LineWidth',2); 
%title('Vyska');
%grid; xlabel('t [s]'); ylabel('y [m]');
%yL = ylim; axis([0 td yL]);

%figure(3);
%plot(X,Y,'b-','LineWidth',2); 
%title('Vyska vs Vzdialenost');
%grid; xlabel('x [m]'); ylabel('y [m]');
%yL = ylim; axis([0 d yL]);
