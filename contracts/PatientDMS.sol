// SPDX-License-Identifier: MIT
// solium-disable linebreak-style
pragma solidity >= 0.4.22 < 0.9.0;

contract PatientDMS {

    address contractOwner;

    // a template for a patient
    struct patient {
        string name;
        string dob;
        uint weight;
        uint height;
        string tests;
        uint bmi;
        address account;
    }

    // this array contain patients
    patient [] patients; 

    // a tempate for a reseachers
    struct researcher {
        string name;
        string bio;
        address account;
        uint8 status ;
    }

    // this array contains reseachers
    researcher[] researchers;

    constructor() {
        contractOwner = msg.sender;
    }

    modifier isOwner() {
        require(contractOwner == msg.sender, "you don't have priviliges to access this resource.");
        _;
    }

    modifier isResearcher() {
        require( isResearcherVerified(msg.sender) == 1, "you don't have priviliges to access this resource.");
        _;
    }

    function addPatient(string calldata _name, string calldata _dob, uint _w, uint _h, string calldata _tests, address _account) public {
        patient memory tempPatient;
        tempPatient.name = _name;
        tempPatient.dob = _dob;
        tempPatient.weight = _w;
        tempPatient.height = _h;
        tempPatient.tests = _tests;
        tempPatient.account = _account;
        patients.push(tempPatient);
    }

    function addReseacher(string calldata _name, string calldata _bio, address _account) public {
        researcher memory tempReseacher;
        tempReseacher.name = _name;
        tempReseacher.bio = _bio;
        tempReseacher.account = _account;
        tempReseacher.status = 0;
        researchers.push(tempReseacher);
    }

    function getNonVerifiedResearchers() public view returns(researcher[] memory) {
        researcher [] memory nonResearcher = new researcher[](researchers.length);
        for(uint8 i=0; i<researchers.length; i++) {
            if( researchers[i].status == 0) {
                nonResearcher[i] = researchers[i];
            }
        }
        return nonResearcher;
    }  

    function getVerifiedResearchers() public view returns(researcher[] memory) {
        researcher [] memory vResearcher = new researcher[](researchers.length);
        for(uint8 i=0; i<researchers.length; i++) {
            if( researchers[i].status == 1) {
                vResearcher[i] = researchers[i];
            }
        }
        return vResearcher;
    }   

    // can only access by the contract owner
    function verifyReseacher(address _account) public isOwner {
        for(uint8 i=0; i<researchers.length; i++) {
            if( researchers[i].account == _account) {
                researchers[i].status = 1;
            }
        }
    }

    function isResearcherVerified(address _account) public view returns(uint8 stuts) {
        for(uint8 i=0; i<researchers.length; i++) {
            if( researchers[i].account == _account) {
                return researchers[i].status;
            }
        }
    }

    // only owner and verified researcher can accesss
    function getPatientData() public isResearcher view returns(patient [] memory)   {
        return patients;
    }
}