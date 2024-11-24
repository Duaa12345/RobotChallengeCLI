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

## Running the Application

To start the CLI, use: bin/robot_challenge

### Command Examples

* PLACE 0,0,NORTH
* MOVE
* REPORT
* LEFT
* MOVE
* REPORT
* EXIT

### Output

* 0,1,NORTH
* 0,1,WEST
* Goodbye!

You can also write your commands in a file (e.g., test_commands.txt) and execute them in one go:
To run the file you can do: ruby bin/robot_challenge test_commands.txt

## Running Tests

Run all the tests using: rails test

## Technical Details

### Application Design

#### Robot Model:
* Represents the robot's position and state.
* Handles movements, rotations, and state validation.
 
#### Table Model:
* Represents the tabletop dimensions.
* Ensures all movements stay within boundaries.

#### Command Processor:
* Parses and executes user commands.
* Routes valid commands to the appropriate methods.
