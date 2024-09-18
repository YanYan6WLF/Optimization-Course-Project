% Annealing Algorithm
function [final_schedule, fitness_history, solutions_history] = B_simulated_annealing(schedule, num_exams, num_rooms, num_slots, room_capacity, exam_students, student_courses,exam_names)
    T = 1.0;
    T_min = 0.0001;
    alpha = 0.9;
    current_solution = schedule;
    current_cost = eval_schedule(current_solution, num_exams, num_rooms, num_slots, room_capacity, exam_students, student_courses);
    
    Z_dynamic_visualization_setup_SA()

    fitness_history = [];
    solutions_history = {};

    % outer loop: temperature
    while T > T_min
        % inner loop: Mk iteration at each temperature
        i = 1;
        while i <= 100
            new_solution = mutate_solution(current_solution, num_slots, num_rooms);
            new_solution = enforce_constraints(new_solution, num_exams, num_rooms, num_slots, room_capacity, exam_students, student_courses);
            new_cost = eval_schedule(new_solution, num_exams, num_rooms, num_slots, room_capacity, exam_students, student_courses);
            ap = acceptance_probability(current_cost, new_cost, T);
            if ap > rand
                current_solution = new_solution;
                current_cost = new_cost;
            end
            fitness_history = [fitness_history, current_cost];
            i = i + 1;
        end
        T = T * alpha;

        if T < 0.01
            solutions_history{end+1} = current_solution;
        
        end
        Z_update_visualization(current_solution, exam_names)
    end
    
    final_schedule = current_solution;
end
%=======================================================================
function new_solution = mutate_solution(solution, num_slots, num_rooms)
    new_solution = solution;
    idx = randi(size(solution, 1));
    new_solution(idx, 1) = randi(num_slots); 
    new_solution(idx, 2) = randi(num_rooms); 
end
%===========================================================================

% Reception probability function
function ap = acceptance_probability(old_cost, new_cost, T)
    if new_cost < old_cost
        ap = 1.0;
    else
        ap = exp((old_cost - new_cost) / T);
    end
end
%==========================================================================






