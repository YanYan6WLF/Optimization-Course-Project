
% The last function to be visualized
function Z_visualize_final_schedule(final_schedule, exam_names, num_slots, num_rooms, room_capacity, exam_students)
    figure;
    hold on;
    colors = lines(num_rooms); 
    for i = 1:size(final_schedule, 1)
        exam_time = final_schedule(i, 1);
        exam_room = final_schedule(i, 2);
        scatter(exam_time, exam_room, 100, 'MarkerEdgeColor', colors(mod(exam_room - 1, num_rooms) + 1, :), ...
                'MarkerFaceColor', colors(mod(exam_room - 1, num_rooms) + 1, :), 'DisplayName', exam_names{i});
        text(exam_time, exam_room, exam_names{i}, 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
    end
    xlabel('Time Slot');
    ylabel('Room');
    title('Final Exam Schedule');
    xlim([0.5, num_slots + 0.5]);
    ylim([0.5, num_rooms + 0.5]);
    legend('show'); 
    grid on;
    hold off;
    
    % Showing the capacity of each paper
    figure;
    hold on;
    for room = 1:num_rooms
        room_schedule = final_schedule(final_schedule(:, 2) == room, :);
        for slot = 1:num_slots
            exams_in_slot = room_schedule(room_schedule(:, 1) == slot, :);
            num_students_in_slot = sum(exam_students(ismember(final_schedule, exams_in_slot, 'rows')));
            bar(slot + (room - 1) * (num_slots + 1), num_students_in_slot, 'FaceColor', colors(room, :));
            text(slot + (room - 1) * (num_slots + 1), num_students_in_slot, num2str(num_students_in_slot), ...
                'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'center');
        end
    end
    xlabel('Room and Time Slot');
    ylabel('Number of Students');
    title('Number of Students per Room and Time Slot');
    xticks(1:num_rooms * (num_slots + 1));
    xticklabels(repmat(1:num_slots, 1, num_rooms));
    grid on;
    hold off;
end




