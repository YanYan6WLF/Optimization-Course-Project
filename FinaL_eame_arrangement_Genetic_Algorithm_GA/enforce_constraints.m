function constrained_solution = enforce_constraints(solution, num_exams, num_rooms, num_slots, room_capacity, exam_students, student_courses)
    % Resolve time and room conflicts
    for i = 1:num_exams
        for j = i+1:num_exams
            while solution(i, 1) == solution(j, 1) && solution(i, 2) == solution(j, 2)
                [solution(j, 1), solution(j, 2)] = find_new_slot_and_room(solution, num_slots, num_rooms, j);
            end
        end
    end

    % Solving classroom capacity issues
    for slot = 1:num_slots
        for room = 1:num_rooms
            students_in_room = sum(exam_students(solution(:, 1) == slot & solution(:, 2) == room));
            while students_in_room > room_capacity(room)
                idx = find(solution(:, 1) == slot & solution(:, 2) == room, 1);
                solution(idx, 2) = find_new_room(room_capacity, exam_students(idx), num_rooms);
                students_in_room = sum(exam_students(solution(:, 1) == slot & solution(:, 2) == room));
            end
            
        end
    end

   
    constrained_solution = solution;
end



%===========================================================================