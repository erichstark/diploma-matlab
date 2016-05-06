function [] = Sikmy_vrh_par(v0, alfa_deg, userFromWeb)
    % Parametre pre model so sikmym vrhom
    %v0 - [m/s] pociatocna rychlost v smere hodu
    %alfa_deg - [deg] uhol vrhu v stupnoch
    
    % [m/s^2] gravitacne zrychlenie
    g = 9.81;
    if alfa_deg > 90; alfa_deg=90; end;
    if alfa_deg < 0;  alfa_deg=0;  end;    
    
    % [rad] uhol vrhu v radianoch
    alfa_rad = alfa_deg*2*pi/360;   

    % [s] cas dopadu
    td = 2*v0*sin(alfa_rad)/g;
    
    % [m] dolet
    d  = v0^2*sin(2*alfa_rad)/g;
    
    % [m] maximalna vyska
    h  = v0^2*(sin(alfa_rad))^2/g/2; 

    % copy all function variable to master scope for projectile_sim
    A = who;
    for i = 1:length(A)
        assignin('base', A{i}, eval(A{i}));
    end
end



