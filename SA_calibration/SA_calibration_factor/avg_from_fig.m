function avg_from_fig(x, y)

% Average Y values between two user-selected X positions.
%
% Inputs:
%   x : x-data vector (datetime, duration, or numeric)
%   y : y-data vector
%
% Controls:
%   0 = continue current calibration block
%   1 = save current block and stop
%   2 = save current block and continue with a new block
%
% Saves:
%   y_avg_cal_1, y_avg_cal_2, ... in workspace

if numel(x) ~= numel(y)
    error('x and y must have the same length.');
end

ax = gca;

x = x(:);
y = y(:);

x_num = ruler2num(x, ax.XAxis);

cal_idx = 1;
current_block = [];

while true
    disp('Click two points to define the averaging interval...');
    pts = ginput(2);

    x1 = min(pts(:,1));
    x2 = max(pts(:,1));

    idx = (x_num >= x1) & (x_num <= x2);

    if any(idx)
        y_avg = mean(y(idx), 'omitnan');
    else
        y_avg = NaN;
        warning('No data points found in selected x-interval.');
    end

    current_block(end+1,1) = y_avg;

    fprintf('Average for this interval: %.10g\n', y_avg);

    action = input('0 = continue, 1 = save and stop, 2 = save and continue: ');

    if isempty(action)
        action = 0;
    end

    switch action
        case 0

        case 1
            varName = sprintf('y_avg_cal_%d', cal_idx);
            assignin('base', varName, current_block);
            fprintf('Saved %s in base workspace.\n', varName);
            break

        case 2
            varName = sprintf('y_avg_cal_%d', cal_idx);
            assignin('base', varName, current_block);
            fprintf('Saved %s in base workspace.\n', varName);

            cal_idx = cal_idx + 1;
            current_block = [];

        otherwise
            disp('Invalid input. Use 0, 1, or 2.');
    end
end
end
