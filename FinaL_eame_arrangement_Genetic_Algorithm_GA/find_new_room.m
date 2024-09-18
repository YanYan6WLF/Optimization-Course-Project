% Find a suitable classroom based on exam people size
function new_room = find_new_room(room_capacity, num_students, num_rooms)
    possible_rooms = find(room_capacity >= num_students);
    if isempty(possible_rooms)
        new_room = randi(num_rooms);  % If there is no suitable classroom, choose one at random
    else
        new_room = possible_rooms(randi(length(possible_rooms)));
    end
end