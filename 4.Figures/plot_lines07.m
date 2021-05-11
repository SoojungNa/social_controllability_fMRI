function F = plot_lines07(data, ...
    x_tick_labels, x_tick, xlim, ...
    y_title, ylim, ...
    design)

    % 07: plot the individual line first and then mean line, sem patch
    % Two conditions
    % data = [data1 data2 data3 ...] --> indiv(row) * conditions(col)
    % s1 = Mean trend lines  (design.s1.color, s1.linewidth)
    % s2 = SEM patch         (design.s2.color, design.s2.fa)
    % s3 = Indiv trend lines - color map
    % (design.s3.color.up/down/stay desgin.s3.fa)
    % design: 
    % s1.color, s1.linewidth   
    % s2.color, s2.fa
    % s3.colormap / s3.color / s3.color1 s3.color2 
    % v05. color matches values (not the exact match but the interval)
    
    nonan1 = find(~isnan(data(:,1)));
    nonan2 = find(~isnan(data(:,2)));
    data = data(intersect(nonan1, nonan2), :);

    nP = size(data,1);

    
    %% Size & Position
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
        % left TOP width height

%% Individual lines
    
    s3x = x_tick;
    s3y = data;    
    
    slope = data(:,2) - data(:,1);    
    cm = nan(length(data), 3);    
    
    % 1 color
    if ~isempty(design.s3.color) 
        cm = repmat(design.s3.color, length(data), 1);
        
    % 3 colors (up/down/stay)        
    elseif ~isempty(design.s3.color_up)   
        up = find(slope>0);
        down = find(slope<0);
        stay = find(slope==0);
        cm(up, :) = repmat(design.s3.color_up, length(up), 1);
        cm(down, :) = repmat(design.s3.color_down, length(down), 1);
        cm(stay, :) = repmat(design.s3.color_stay, length(stay), 1);
    
    % colormap by slope (value, not order)
    elseif ~isempty(design.s3.colormap)
        
        % Total # of the available colors
        nTC = 500;       
        
        % Generate a colormap with nTC
        ff = str2func(design.s3.colormap);        
        CM = colormap(ff(nTC)).*0.8; % entire colormap        
        
        % Set up a value table in parallel with the colormap
        %[sorted,~,ranking] = unique(slope);                
        interval = (max(slope) - min(slope))/(nTC-1);
        value_table = min(slope):interval:max(slope);
        
        for i = 1:length(slope)
            distance = abs(value_table - slope(i));                        
            x = find(distance == min(distance));
            cm(i,:) = CM(x(1), :); % x(1) in case there are 2 numbers in x.
        end
        
    end
    
       

    %% Indiv lines
    for i = 1:nP
        x = s3x;
        y = s3y(i, :);
        %c = cm(ranking(i),:);
        s3 = plot(x, y, 'Color', cm(i,:));
        s3.Color(4) = design.s3.fa;  % transparency        
        hold on

    end
        
        
    %% Mean line
    s1x = x_tick;
    s1y = mean(data);
    s1 = plot(s1x, s1y, 'Color', design.s1.color, 'Linewidth', design.s1.linewidth);
    hold on


    %% SEM patch
    a = [x_tick flip(x_tick)];
    s2x = [a(end) a(1:end-1)];  % [1 1 2 2]    
    sem = std(data)./sqrt(nP);
    
    b = [s1y+sem flip(s1y-sem)];
    s2y = [b(end) b(1:end-1)];    
    
    s2 = patch(s2x, s2y, design.s2.color, 'FaceAlpha', design.s2.fa);
    set(s2, 'edgecolor', 'none');
    hold on
    
    
    


    ylabel(y_title);
    ytickformat('%3.0f');
    set(gca, 'box', 'off', 'FontName', 'Arial', 'FontSize', 8, ...
        'xLim', xlim, 'yLim', ylim, 'TickLength', [0 0], ...
        'xtick', x_tick, 'xticklabel', x_tick_labels);

end