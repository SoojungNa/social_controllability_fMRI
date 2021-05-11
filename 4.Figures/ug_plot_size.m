% UG paper plot size/position

w = 120;    % chart width 120
h = 125;    % chart height
blank = 20;
xlabelspace = 15;
ylabelspace = 30;
Fw = w + 2*blank + ylabelspace;
Fh = h + 2*blank + xlabelspace;

F = figure('Position', [500 300 Fw Fh]); % left BOTTOM width height

subplot('Position', ...
[(blank+ylabelspace)/Fw (blank+xlabelspace)/Fh w/Fw h/Fh]) 