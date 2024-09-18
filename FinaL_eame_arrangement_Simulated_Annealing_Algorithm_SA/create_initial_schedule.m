% create_initial_schedule
function initial_schedule = create_initial_schedule(num_exams, num_rooms, num_slots, exam_students, room_capacity)
    initial_schedule = zeros(num_exams, 2);
    for i = 1:num_exams
        room_found = false;
        while ~room_found
            time_slot = randi(num_slots);
            room = randi(num_rooms);
            if room_capacity(room) >= exam_students(i)
                initial_schedule(i, :) = [time_slot, room];
                room_found = true;
            end
        end
    end
end
