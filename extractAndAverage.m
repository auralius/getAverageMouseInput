function output = extractAndAverage(data)
% This function lets the user selects a range of plotted data and the 
% average of the selected data is calculated as the output
%
% Data is a NxR matrix where N is the length of the data and R is the
% dimension of the data.
% For eaxmple, 3D clouds: [x1, y1, z1], [x2 y2 z2], ..., [xN, yN, zN]

figure;
hold on;

[N, R] = size(data);

% Initial plot and legend
legendArray = repmat(' ',R,1);
for i = 1 : R
    plot(data(:,i));
    legendArray(i) = num2str(i);       
end
legend(legendArray);

% Handlers for the markers
for i = 1 : R
    hnd_start_marker(i) = plot(0,0, 'db');
    hnd_end_marker(i) = plot(0,0, 'dr');
end

% Storage for created indexes
start_index = [];
end_index = [];

%--------------------------------------------------------------------------
% By using the mouse pointer, user will select a start index and then 
% followed by an end index. After that, user will be asked if the process
% needs to be repeated.
%--------------------------------------------------------------------------

more = 1;
k = 1;
while (more == 1)
    % We only care the x value
    [x_start, y_start] = ginput(1);
    [x_end, y_end] = ginput(1);
        
    if (x_end > x_start) % Simple sanity check
        start_index = [start_index; ceil(x_start)];
        end_index = [end_index; ceil(x_end)];

        % Put markers on each dimension of the data 
        for i = 1:R
            set(hnd_start_marker(i), 'XData', start_index, ...
                'YData', data(start_index, i));
            set(hnd_end_marker(i), 'XData', end_index, ...
                'YData', data(end_index, i));
        end

        % Calculate and store the average
        output(k, :) = mean(data(start_index(k):end_index(k), :))

        % Ask and handle response
        choice = questdlg('Select more?', '', 'Yes', 'No', 'No');    
        switch choice
            case 'Yes'
                more = 1;
                k = k + 1;
            case 'No'
                more = 0;
        end
    else
        errordlg('The end index must be greater than the start index', ...
            'Error', 'modal');
    end
end
