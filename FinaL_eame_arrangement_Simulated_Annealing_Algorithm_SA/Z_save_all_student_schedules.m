function Z_save_all_student_schedules(final_schedule, exam_names, student_courses, filename)
    num_students = size(student_courses, 1);
    all_exams_info = {}; % Initialize cell array to hold all exams info

    for student = 1:num_students
        exams_taken = find(student_courses(student, :) == 1);
        student_schedule = final_schedule(exams_taken, :);
        
        for i = 1:length(exams_taken)
            exam_name = exam_names{exams_taken(i)};
            exam_time = student_schedule(i, 1);
            exam_room = student_schedule(i, 2);
            all_exams_info = [all_exams_info; {student, exam_name, exam_time, exam_room}];
        end
    end

    % Create table for all students
    T = cell2table(all_exams_info, 'VariableNames', {'Student', 'Exam', 'TimeSlot', 'Room'});
    
    % Save table to file
    writetable(T, filename);
end