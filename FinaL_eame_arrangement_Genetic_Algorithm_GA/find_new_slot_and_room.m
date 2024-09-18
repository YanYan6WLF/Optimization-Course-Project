% Find a new time and classroom without conflict
function [new_time, new_room] = find_new_slot_and_room(solution, num_slots, num_rooms, exam_index)
    valid = false;
    while ~valid
        new_time = randi(num_slots);
        new_room = randi(num_rooms);
        % Check for conflicts
        valid = all(solution(:, 1) ~= new_time | solution(:, 2) ~= new_room | (1:size(solution, 1))' == exam_index);
    end
end