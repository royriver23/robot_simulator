# RobotSimulator

**Robot Simulator** is an gem that will allow you to play around with robot via your terminal (your robot will actually move while being in another secret place in the planet).

## Demo

![RobotDemo](http://g.recordit.co/IXyBi11mnh.gif)

## Setup and testing

### Prerequisites
* Ruby 2.0.0 or latest


### Installation

First of all, clone this repository in your local machine:

```bash
git clone git@github.com:royriver23/robot_simulator.git
cd robot_simulator
```

Then, make sure you have installed Ruby in your machine. The following command should return something like: `ruby 2.x.xpXX (YYY-MM-DD revision XXXX) [x86_64-darwin17]`

```bash
ruby -v
```

As a reminder you can manage multiple Ruby versions using [Rbenv](https://github.com/rbenv/rbenv) or [RVM](https://rvm.io/).

Verify that you have bundler installed. It would output something like `Bundler version x.xx.x`

```bash
bundler -v
```

If not, install it using `gem install bundler`

Finally, install your development dependencies:

```
bundle install
```

### Running Tests

This gem has 100% of its implementation code covered by tests based on SimpleCov gem results:

<img src="https://github.com/royriver23/robot_simulator/blob/master/images/Coverage.png?raw=true" alt="drawing" width="350"/>

Run the tests with the following command:

```bash
./bin/rspec_robot
```

This will ask you whether you want to see detail coverage with a Y/N question:

```bash
Do you want to see detailed coverage? (Y/n)
```

If **Y**, it will open your default browser with coverage HTML file shown above in the screenshot.

### Test Data

The test data can be found in `./spec/test_data` folder.

## Let's play with the robot

There is a bash script that will start the robot simulator application, run the following command to load CLI interface to manage it:

```
./bin/robot_simulator
```

### Configuration

You will be able to do the following configurations:
* **Output options**: Plain Text (default), JSON and/or ASCCI.
* **Report on every command**: This is a yes or no question, to whether you would like to see robot status every time it performs an action.
* **Surface**: Width and Height.

### Instructions

- PLACE X,Y,{DIRECTION} - e.g. PLACE 1,2,NORTH  - will put the toy robot on the table in position X,Y and facing NORTH, SOUTH, EAST or WEST.
- MOVE - will move the toy robot one unit forward in the direction it is currently facing.
- LEFT and RIGHT will rotate the robot 90 degrees in the specified direction without changing the position of the robot.
- REPORT will announce the X,Y and orientation of the robot.
- EXIT

## Technologies/Patterns

* **Programmming Language**: Ruby
* **Testing**: [Rspec](http://rspec.info/)
* **Design Principles**: [SOLID](https://scotch.io/bar-talk/s-o-l-i-d-the-first-five-principles-of-object-oriented-design)
* **Design Patterns**: some design patterns were used, such as: template and factory
* **Test Patterns**: mainly [Arrange Act Assert](http://wiki.c2.com/?ArrangeActAssert), Result Test and State Test patterns.
* **Other Gems**:
  * [tty-prompt](https://github.com/piotrmurach/tty-prompt): to build CLI interface
  * [simplecov](https://github.com/colszowka/simplecov): to measure code coverage
  * [pry](https://github.com/pry/pry): extremely handy to debug bugs or just inspect and navigate throught your project.
