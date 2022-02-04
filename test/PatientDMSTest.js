const patient = artifacts.require('PatientDMS')
contract('patient dms contract', async(accounts) => {
    let patientObj = ""
    beforeEach('initilize constructor', async () => {
        patientObj = await patient.deployed({from:accounts[0]})
    }),

    it('adding patient', async () => {
        const name = "mashood"
        const dob = "15-5-97"
        const w = 70
        const h = 6
        const test = "positive"
        const account = "0x54c78347202247b7ec5a20b1fedf5ae0a9c3b64e"
        let data = await patientObj.addPatient(name, dob, w, h, test, account)
    }),

    it('adding reseacher', async () => {
        const name = "ahmad"
        const bio = "phd scholar"
        const account = "0x971b0fd896313440cfb1fe2d31d62601850afb7f"
        let data = await patientObj.addReseacher(name, bio, account)
    }),

    it('getting non verified reseachers', async () => {
        let data = await patientObj.getNonVerifiedResearchers.call()
        const name = data[0][0]
        const bio = data[0][1]
        const account = data[0][2]
        assert.equal(name,'ahmad', 'this name should be ahmad')
        assert.equal(bio,'phd scholar', 'this bio should be phd scholar')
        assert.equal(account, '0x971B0fd896313440cfB1FE2d31d62601850aFB7F', 'this address is not correct')
    }),

    it('verifying a researher', async () => {
        const account = "0x971B0fd896313440cfB1FE2d31d62601850aFB7F"
        let data = await patientObj.verifyReseacher(account)
    }),

    it('getting verified researchers', async () => {
        let data = await patientObj.getVerifiedResearchers.call()
        const name = data[0][0]
        const bio = data[0][1]
        const account = data[0][2]
        assert.equal(name,'ahmad','this name should be ahmad')
        assert.equal(bio,'phd scholar', 'this bio should be phd scholar')
        assert.equal(account, '0x971B0fd896313440cfB1FE2d31d62601850aFB7F', 'this address is not correct')
    }),

    it('getting patient data', async () => {
        let status = true
        try {
            let data = await patientObj.getPatientData.call()
        } catch(err) {
            status = false
            assert.equal(status, true, 'you don\'t have rights to acces this function ')
        }
        
    })


})