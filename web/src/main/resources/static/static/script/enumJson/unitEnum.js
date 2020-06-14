function getKeyValuesAsMap(json) {
    let map = {};
    for (let i = 0; i < json.length; i++) {
        let key = json [i];
        map[key['id']] = key['name'];
    }
    return map;
}

const unitEnum = {
    types: [
        {id: "1", name: "Unit"},
        {id: "2", name: "Time"},
        {id: "3", name: "Financial"}
    ]
};

const unitEnumSingel = {
    Unit: 1,
    Time: 2,
    Financial: 3
};

Object.freeze(unitEnum);