isc.defineClass("invoicePrice", isc.VLayout).addProperties({
    autoFit: false,
    autoDraw: false,
    align: "center",
    width: "500",
    height: "100",
    material: null,
    form: null,
    initWidget: function () {

        var This = this;
        this.Super("initWidget", arguments);

        var lmeCriteria =  {
            _constructor: 'AdvancedCriteria',
            operator: "and",
            criteria: [{fieldName: "lmeDate", operator: "equals", value: "30-MAY-08 12.00.00.000000000 PM"}]};


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
                    // title: "<spring:message code='LME.cuUsdMt'/>",
                },
                {
                    name: "lmeDate",
                    // title: "<spring:message code='LME.LMEDate'/>",
                },
                {
                    name: "goldUsdOunce",
                    // title: "<spring:message code='LME.goldUsdOunce'/>",
                },
                {
                    name: "silverUsdOunce",
                    // title: "<spring:message code='LME.silverUsdOunce'/>",
                },
                {
                    name: "seleniumUsdLb",
                    // title: "<spring:message code='LME.seleniumUsdLb'/>",
                },
                {
                    name: "platinumUsdOunce",
                    // title: "<spring:message code='LME.platinumUsdOunce'/>",
                },
                {
                    name: "palladiumUsdOunce",
                    // title: "<spring:message code='LME.palladiumUsdOunce'/>",
                },
                {
                    name: "molybdenumUsdLb",
                    // title: "<spring:message code='LME.molybdenumUsdLb'/>",
                }],
            fetchDataURL: "${contextPath}/api/LME/spec-list"
        });

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
                        name: "copper",
                        title: '<spring:message code="component.invoice.price.copper"/>',
                        type: "float",
                        required: true,
                        dataSource: LME_DataSource,
                        criteria : lmeCriteria,
                        defaultValue: 11
                    }
                ]
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
                        name: "copper",
                        title: '<spring:message code="component.invoice.price.copper"/>',
                        type: "float",
                        required: true,
                        dataSource: LME_DataSource,
                        value: LME_DataSource.getValue()
                    },
                    {
                        name: "silver",
                        title: '<spring:message code="component.invoice.price.silver"/>',
                        type: "float",
                        required: true,
                        dataSource: LME_DataSource,
                        value: LME_DataSource.getValue()
                    },
                    {
                        name: "gold",
                        title: '<spring:message code="component.invoice.price.gold"/>',
                        type: "float",
                        required: true,
                        dataSource: LME_DataSource,
                        value: LME_DataSource.getValue()
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
                console.log(This.getValues());
            }
        });
        this.addMember(submit);

    },
    getValues: function () {
        return  form.getValues();
    },
    setValues: function (values) {
        return  form.setValues(values);
    },
});

isc.invoicePrice.create({
    material: materialCode["Copper Cathode"]
});
