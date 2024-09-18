# Optimization-Course-Project
I used annealing algorithm and genetic algorithm to solve the university final exam arrangement problem.   
The key point of this project is to set appropriate constraints as follows:    

1. Hard Constraints:
- No exams are scheduled in the same time and same room.
- The number of students in a given exam should not exceed the room capacity.
- A student should not have multiple exams scheduled at the same time.
2. Soft Constraints:
- It would be better if a student does not have to take two exams in a row [not compulsory]—we don't change the arrangement, but a penalty will be added because this arrangement is not preferred.
                            
When the algorithm provides a solution, it must be checked against the constraints. If the solution violates any constraints, a penalty function is applied to reduce the likelihood of selecting that solution in the next generation.
