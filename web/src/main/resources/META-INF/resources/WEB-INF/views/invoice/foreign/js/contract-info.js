let __contract = {};

__contract.nameOfNumberProperty = "no";
__contract.url = "${contextPath}" + "/api/g-contract/";
__contract.getBuyer = function (contract) {

    // contract.contractContacts.filter(q => q.buyer).first()
    return {name: "ali", address: "aaa", phone: "123", fax: "2222"};
}
