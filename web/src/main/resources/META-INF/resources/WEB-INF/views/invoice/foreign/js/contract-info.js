let __contract = {};

__contract.nameOfNumberProperty = "no";
__contract.url = "${contextPath}" + "/api/g-contract/";

__contract.getBuyer = function (contract) {

    // contract.contractContacts.filter(q => q.buyer).first()
    return {nameEN: "ali", address: "aaa", phone: "123", fax: "2222"};
};
__contract.getMaterial = function (contract) {

    return {descl: "CATHOD KHOSHGELE", id: 2};
};
__contract.getDeliveryTerm = function (contract) {

    return {rule: "FOB", version: "2010"};
};
__contract.getContractYear = function (contract) {

    // Year of MOAS+x
    return 2020;
};
__contract.getContractMOASValue = function (contract) {

    // Month of actual shipment plus
    return 2;
};
__contract.getShipmentMonthNo = function (shipment) {

    // Month of actual shipment plus
    return DateUtil.getMonthNames().indexOf(shipment.month) + 1;
};
