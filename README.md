# README

# Robot Challenge CLI
## Description
The Robot Challenge CLI is a Ruby on Rails command-line application simulating a toy robot moving on a square tabletop. The robot can receive and execute various commands while adhering to constraints to prevent falling off the table.

## Features
* PLACE Command: Puts the robot on the table at the specified position and facing a direction.
* MOVE Command: Moves the robot one unit forward in the direction it is currently facing.
* LEFT Command: Rotates the robot 90 degrees counterclockwise.
* RIGHT Command: Rotates the robot 90 degrees clockwise.
* REPORT Command: Outputs the robot's current position and direction.
* Boundary Constraints: Prevents the robot from falling off the table.
* Error Handling:
* Ignores commands issued before a valid PLACE command.
* Displays helpful error messages for invalid commands.

