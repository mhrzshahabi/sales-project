isc.defineClass("invoicePrice", isc.VLayout).addProperties({
    autoFit: false,
    autoDraw: false,
    align: "center",
    width: "100%",
    height: "20%",
    backgroundColor: "#f0c85a",
    material: null,
    form: null,
    contractMonth: null,
    initWidget: function () {

        var This = this;
        this.Super("initWidget", arguments);

        /*var lmeCriteria =  {
            _constructor: 'AdvancedCriteria',
            operator: "and",
            criteria: [{fieldName: "lmeDate", operator: "equals", value: this.contractMonth}]};

        var LME_DataSource = isc.MyRestDataSource.create({
            fields: [
                {
                    name: "id",
                    title: "id",
                    primaryKey: true,
                    canEdit: false,
                    hidden: true
                },
                {
                    name: "cuUsdMt",
                },
                {
                    name: "lmeDate",
                },
                {
                    name: "goldUsdOunce",
                },
                {
                    name: "silverUsdOunce",
                },
                {
                    name: "seleniumUsdLb",
                },
                {
                    name: "platinumUsdOunce",
                },
                {
                    name: "palladiumUsdOunce",
                },
                {
                    name: "molybdenumUsdLb",
                }],
            fetchDataURL: "${contextPath}/api/LME/spec-list"
        });

        LME_DataSource.fetchData(lmeCriteria, function (dsResponse, data, dsRequest) {
            form.getItem("copper").setValue(data[0].cuUsdMt);
            form.getItem("silver").setValue(data[0].silverUsdOunce);
            form.getItem("gold").setValue(data[0].goldUsdOunce);
            form.getItem("platinum").setValue(data[0].platinumUsdOunce);
            form.getItem("palladium").setValue(data[0].palladiumUsdOunce);
            form.getItem("selenium").setValue(data[0].seleniumUsdLb);
        });*/

        switch (this.material) {

            case 0:
                form = isc.DynamicForm.create({
                margin: 10,
                width: "100%",
                canSubmit: true,
                align: "center",
                titleAlign: "right",
                numCols: 2,
                fields: [
                    {
                        name: "contractMonth",
                        title: "contractMonth",
                        showTitle: false,
                        type: "staticText",
                        width: "100%",
                        colSpan: 2,
                        defaultValue: this.contractMonth
                    },
                    {
                        name: "copper",
                        title: '<spring:message code="component.invoice.price.copper"/>',
                        type: "float",
                        required: true,
                    }
                ],
                // setValuesAsCriteria(lmeCriteria){}
                });
                // console.log(form.getItem("copper"));
                this.addMember(form);
                break;

            case 1:
                form = isc.DynamicForm.create({
                margin: 10,
                width: "100%",
                canSubmit: true,
                align: "center",
                titleAlign: "right",
                numCols: 2,
                fields: [
                    {
                        name: "contractMonth",
                        title: "contractMonth",
                        showTitle: false,
                        type: "staticText",
                        defaultValue: this.contractMonth
                    },
                    {
                        name: "copper",
                        title: '<spring:message code="component.invoice.price.copper"/>',
                        type: "float",
                        required: true,
                    },
                    {
                        name: "silver",
                        title: '<spring:message code="component.invoice.price.silver"/>',
                        type: "float",
                        required: true,
                    },
                    {
                        name: "gold",
                        title: '<spring:message code="component.invoice.price.gold"/>',
                        type: "float",
                        required: true,
                    },
                ]
                });
                this.addMember(form);
                break;

            case 4:
                form = isc.DynamicForm.create({
                margin: 10,
                width: "100%",
                canSubmit: true,
                align: "center",
                titleAlign: "right",
                numCols: 2,
                fields: [
                    {
                        name: "contractMonth",
                        title: "contractMonth",
                        showTitle: false,
                        type: "staticText",
                        defaultValue: this.contractMonth
                    },
                    {
                        name: "copper",
                        title: '<spring:message code="component.invoice.price.copper"/>',
                        type: "float",
                        required: true,
                    },
                    {
                        name: "silver",
                        title: '<spring:message code="component.invoice.price.silver"/>',
                        type: "float",
                        required: true,
                    },
                    {
                        name: "gold",
                        title: '<spring:message code="component.invoice.price.gold"/>',
                        type: "float",
                        required: true,
                    },
                    {
                        name: "platinum",
                        title: '<spring:message code="component.invoice.price.platinum"/>',
                        type: "float",
                        required: true,
                    },
                    {
                        name: "palladium",
                        title: '<spring:message code="component.invoice.price.palladium"/>',
                        type: "float",
                        required: true,
                    },
                    {
                        name: "selenium",
                        title: '<spring:message code="component.invoice.price.selenium"/>',
                        type: "float",
                        required: true,
                    },
                ]
                });
                this.addMember(form);
                break;
        }

        var submit = isc.Button.create({
            title: "submit",
            click: function () {
                console.log(This.getPriceValues());
            }
        });
        this.addMember(submit);

    },
    getPriceValues: function () {
        return  form.getValues();
    },
    setPriceValues: function (values) {
        return  form.setValues(values);
    },
});

isc.invoicePrice.create({
    material: materialCode["Copper Concentrate"],
    // contractMonth: Number(+ new Date(2008,5,30))
});
