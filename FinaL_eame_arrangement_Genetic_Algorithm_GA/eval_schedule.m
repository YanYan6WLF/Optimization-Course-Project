function fitness = eval_schedule(schedule, num_exams, num_rooms, num_slots, room_capacity, exam_students, student_courses)
    fitness = 0;
    %I use fitness function to evaluate the performance of GA/SA.
    % If the schedule breaks the constraint condition, the penalty will be added to the fitness function. 
    % So the smaller the fitness value is, the better the performance is. Depending on different constraint condition, the penalties are different.

    penalty_time_conflict = 10;
    penalty_capacity_exceeded = 5;
    penalty_student_conflict = 15;
    penalty_min_interval = 8;
    min_interval = 2;

    % Check exam time and room conflicts
    for i = 1:num_exams
        for j = i+1:num_exams
            if schedule(i, 1) == schedule(j, 1) && schedule(i, 2) == schedule(j, 2)
                fitness = fitness + penalty_time_conflict;
            end
        end
    end

    % Check exam room capacity limits
    for i = 1:num_rooms
        for j = 1:num_slots
            students_in_room = sum((schedule(:, 1) == j) & (schedule(:, 2) == i) .* exam_students');
            if students_in_room > room_capacity(i)
                fitness = fitness + penalty_capacity_exceeded * (students_in_room - room_capacity(i));
            end
        end
    end

    % Check student exam conflicts and time intervals
    num_students = size(student_courses, 1);
    for student = 1:num_students
        exams_taken = find(student_courses(student, :) == 1);
        for i = 1:length(exams_taken)
            for j = i+1:length(exams_taken)
                % Students have two exams in the same time period
                if schedule(exams_taken(i), 1) == schedule(exams_taken(j), 1)
                    fitness = fitness + penalty_student_conflict;
                end
                % Students have two exams in a short period of time
                if abs(schedule(exams_taken(i), 1) - schedule(exams_taken(j), 1)) < min_interval
                    fitness = fitness + penalty_min_interval;
                end
            end
        end
    end

    % Returns the fitness value, the smaller the value, the better the timing.
end
