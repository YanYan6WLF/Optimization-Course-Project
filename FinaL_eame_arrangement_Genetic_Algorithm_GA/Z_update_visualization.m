function Z_update_visualization(schedule, exam_names)
    cla;  % Clear the contents of the current axis
    hold on;
    colors = lines(numel(exam_names));  % Generate colors for each exam

    for i = 1:size(schedule, 1)
        exam_slot = schedule(i, 1);
        room_number = schedule(i, 2);
        scatter(exam_slot, room_number, 100, 'filled', 'MarkerFaceColor', colors(i, :));
        text(exam_slot, room_number, exam_names{i}, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
    end
    drawnow;  % Force graphics update
end