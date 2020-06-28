let __contract = {};

__contract.nameOfNumberProperty = "no";
__contract.url = "${contextPath}" + "/api/g-contract/";
__contract.getBuyer = function (contract) {

    // contract.contractContacts.filter(q => q.buyer).first()
    return {nameEN: "ali", address: "aaa", phone: "123", fax: "2222"};
};
__contract.getMaterial = function (contract) {

    return contract.material;
};
__contract.getDeliveryTerm = function (contract) {

    // contract.contractContacts.filter(q => q.buyer).first()
    return {rule: "FOB", version: "2010"};
};
__contract.getContractYear = function (contract) {

    // contract.contractContacts.filter(q => q.buyer).first()
    return 2020;
};
__contract.getContractMonth = function (contract) {

    // contract.contractContacts.filter(q => q.buyer).first()
    return 2;
};
