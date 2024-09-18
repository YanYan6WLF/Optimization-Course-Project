function [optimized_schedule, fitness_history, solutions_history] = B_genetic_algorithm(initial_schedule, num_exams, num_rooms, num_slots, room_capacity, exam_students, student_courses, exam_names)
    num_vars = num_exams * 2; % each course exam has its own time and room

    max_generations = 100;
    pop_size = 100;
    population = zeros(pop_size, num_vars); % every generation

    % First generation
    population(1, :) = initial_schedule(:)';
    for i = 2:pop_size
        new_schedule = create_initial_schedule(num_exams, num_rooms, num_slots, exam_students, room_capacity);
        population(i, :) = new_schedule(:)';
    end

    % Changable variables
    elitism_count = 5;  % Number of elites to preserve
    tournament_size = 2;  % Size of tournament for selection
    
    initial_mutation_rate = 0.1; 
    final_mutation_rate = 0.01; 
    
    initial_crossover_rate = 0.9; 
    final_crossover_rate = 0.6; 

    solutions_history = cell(1, max_generations);
    fitness_history = zeros(1, max_generations); 

    Z_dynamic_visualization_setup_GA()
   
    for gen = 1:max_generations
        fitness_values = arrayfun(@(idx) eval_schedule(reshape(population(idx, :), [], 2), num_exams, num_rooms, num_slots, room_capacity, exam_students, student_courses), 1:pop_size);
        fitness_history(gen) = min(fitness_values);
        [~, best_idx] = min(fitness_values);
        solutions_history{gen} = reshape(population(best_idx, :), num_exams, 2);

        % Check if overcrowding
        fitness_std = std(fitness_values);
        fprintf('Generation: %d, Fitness Standard Deviation: %f\n', gen, fitness_std);
        if fitness_std < 1
            % Increase mutation rate if diversity is low
            mutation_rate = initial_mutation_rate;
        else
            %  decrease mutation rate
            mutation_rate = initial_mutation_rate - ((initial_mutation_rate - final_mutation_rate) / max_generations) * gen;
        end

        % Elitism: carry forward the best solutions
        [~, elite_idx] = mink(fitness_values, elitism_count);
        new_population = population(elite_idx, :);

        % Tournament Selection
        for i = elitism_count+1:pop_size
            tournament = randi(pop_size, tournament_size, 1);
            [~, winner] = min(fitness_values(tournament));
            new_population(i, :) = population(tournament(winner), :);
        end

        Z_update_visualization(solutions_history{gen}, exam_names)

        %------------------------------------------------------------------

        % Crossover
        crossover_rate = initial_crossover_rate - ((initial_crossover_rate - final_crossover_rate) / max_generations) * gen;
        for i = elitism_count+1:2:pop_size-1
            if rand < crossover_rate
                crossover_point = randi(num_vars);
                new_population(i, crossover_point:end) = population(i+1, crossover_point:end);
                new_population(i+1, crossover_point:end) = population(i, crossover_point:end);
            end
        end

        % Mutation
        for i = elitism_count+1:pop_size
            if rand < mutation_rate
                mutation_point = randi(num_vars);
                if mod(mutation_point, 2) == 1
                    new_population(i, mutation_point) = randi(num_slots);
                else
                    new_population(i, mutation_point) = randi(num_rooms);
                end
            end
        end

        % Enforce constraints and update population
        for i = 1:pop_size
            new_solution = reshape(new_population(i, :), [], 2);
            new_solution = enforce_constraints(new_solution, num_exams, num_rooms, num_slots, room_capacity, exam_students, student_courses);
            new_population(i, :) = new_solution(:)';
        end
        population = new_population;
    end

    fitness_values = arrayfun(@(idx) eval_schedule(reshape(population(idx, :), [], 2), num_exams, num_rooms, num_slots, room_capacity, exam_students, student_courses), 1:pop_size);
    [~, best_idx] = min(fitness_values);
    last_schedule = reshape(population(best_idx, :), [], 2);

    [~, optimal_idx] = min(fitness_history);
    optimized_schedule = solutions_history{optimal_idx};
    fprintf('Optimized schedule: Generation: %d, Fitness value of the generation: %f\n', optimal_idx, fitness_history(optimal_idx));
end
