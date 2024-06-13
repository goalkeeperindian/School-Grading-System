// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract school_Grading_System { //Defines a new smart contract.
    struct Student {
        string name; //A string representing the student's name.
        uint grade; // An unsigned integer (uint) representing the student's grade.
    }

    mapping(address => Student) public students; //A mapping that links an address to a Student.
    address public principle;  //The public keyword makes it accessible from outside the contract.

    constructor() {// Created a constructor that will only run when contract is deployed.
        principle = msg.sender; // This sets the principle to the address that can only deploy the contract. 
    }

    modifier onlyPrinciple() { // It is a custom modifier named onlyPrinciple.
        require(msg.sender == principle, "Only principle can add students"); //Check validation and return that only principle can add.
        _; // A general placeholder for the function where modifier is used.
    }

    function addStudent(address _studentAddress, string memory _name, uint _grade) public onlyPrinciple { //onlyPrinciple will accpet that it is added by principle only. memory will store the address and its grade.
        require(_grade <= 100, "Grade must be in between 0 - 100"); //Checks grade don't exeeced 100.
        students[_studentAddress] = Student(_name, _grade); // A public function that add a new student with parameters name and grades by using its address.
    }

    function updateGrade(address _studentAddress, uint _newGrade) public onlyPrinciple { //onlyPrinciple will accpet that it is updated by principle only.
        require(_newGrade <= 100, "Grade must be in between 0 - 100"); //Checks grade don't exeeced 100.
        students[_studentAddress].grade = _newGrade; //A public function that update student marks by using address.
    }

    function getGrade(address _studentAddress) public view returns (uint) { //A function that retrieves a student's grade. It uses student address parameter.
        Student memory student = students[_studentAddress]; //It will retrive grade from student struct via its address and memory allocated above.
        assert(bytes(student.name).length > 0); // Ensure that student exists. If not, It will revert the transaction.
        return student.grade; //Grade will return.
    }

    function removeStudent(address _studentAddress) public onlyPrinciple {//Only principle can remove student.
        Student memory student = students[_studentAddress]; // Memory of that address will be checked. 
        if (bytes(student.name).length == 0) {// Check if student exist or not.
            revert("Student does not exist");
        }
        delete students[_studentAddress];//Delete or remove the student permanently.
    }
}
