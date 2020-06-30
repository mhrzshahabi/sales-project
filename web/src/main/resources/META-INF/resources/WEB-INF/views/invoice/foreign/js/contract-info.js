let __contract = {};

__contract.nameOfNumberProperty = "no";
__contract.url = "${contextPath}" + "/api/g-contract/";

__contract.getBuyer = function (contract) {

    // contract.contractContacts.filter(q => q.buyer).first()
    return {nameEN: "ali", address: "aaa", phone: "123", fax: "2222"};
};
__contract.getMaterial = function (contract) {

    return {descl: "CATHOD KHOSHGELE"};
};
__contract.getDeliveryTerm = function (contract) {

    return {rule: "FOB", version: "2010"};
};
__contract.getContractYear = function (contract) {

    return 2020;
};
__contract.getContractMonth = function (contract) {

    return 2;
};
__contract.getFinalPriceBaseText = function (contract) {

    return 'AVERAGE MAY 2017 (MOAS+2)';
};
