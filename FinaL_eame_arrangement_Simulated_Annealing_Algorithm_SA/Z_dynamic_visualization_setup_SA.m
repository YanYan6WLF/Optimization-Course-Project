
function Z_dynamic_visualization_setup_SA()
    figure;
    hold on;
    xlabel('Exam Slot');
    ylabel('Room Number');
    title('Dynamic Visualization of Simulated annealing');
    grid on;

    xlim([1 8]); % num_slot
    ylim([1 5]); % num_room
end