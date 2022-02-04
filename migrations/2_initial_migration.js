const PatientDMS = artifacts.require("PatientDMS");

module.exports = function (deployer) {
  deployer.deploy(PatientDMS);
};
