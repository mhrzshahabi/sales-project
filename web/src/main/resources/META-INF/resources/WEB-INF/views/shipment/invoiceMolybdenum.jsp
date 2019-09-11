<%@ page import="com.nicico.copper.common.dto.grid.GridResponse" %>
<%@ page import="com.nicico.copper.common.util.date.DateUtil" %>
<%@ page import="com.nicico.sales.dto.InvoiceMolybdenumDTO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>

    <% DateUtil dateUtil = new DateUtil();
		String shipmentId= request.getSession().getAttribute("shipmentId").toString();
		String invoiceId=request.getSession().getAttribute("invoiceId").toString();
		GridResponse<InvoiceMolybdenumDTO.Info> gridResponse= (GridResponse<InvoiceMolybdenumDTO.Info> )request.getSession().getAttribute("gridResponse");
		List<InvoiceMolybdenumDTO.Info> list=gridResponse.getData();
    %>

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

     var DynamicForm_Invoice_Molybdenum ;
	function hasValue(fld){
	 valueTmp=DynamicForm_Invoice_Molybdenum.getValue(fld);
	 return !(valueTmp==null || typeof (valueTmp)=='undefined' || valueTmp=="" );
	}
    function multiplyMolybdenumMolybdenum (fld1,value) {
		if (value==null || typeof (value)=='undefined' || fld1==null || typeof (fld1) =='undefined')
		   return 0;
		return fld1 * value;
	}
	function multiplyMolybdenumMolybdenumAndSet (name1,name2,setName0) {
	  val1=DynamicForm_Invoice_Molybdenum.getValue(name1);
	  val2=DynamicForm_Invoice_Molybdenum.getValue(name2);
	  m=multiplyMolybdenumMolybdenum(val1,val2)/((name1=="paidPercent" || name2=="paidPercent") ? 100 : 1);
	  // console.log('name1= '+name1+' name2= '+name2+ ' setname= '+setName0+' mult='+m);
	  DynamicForm_Invoice_Molybdenum_setValue(setName0,m);
	}
	function multiplyMolybdenumMolybdenumAndSet3 (name1,name2,setName0,number1) {
	  val1=DynamicForm_Invoice_Molybdenum.getValue(name1);
	  val2=DynamicForm_Invoice_Molybdenum.getValue(name2);
	  m=multiplyMolybdenumMolybdenum(val1,val2)*number1;
	  // console.log('name1= '+name1+' name2= '+name2+ ' setname= '+setName0+' mult='+m);
	  DynamicForm_Invoice_Molybdenum_setValue(setName0,m);
	}
	function DynamicForm_Invoice_Molybdenum_getValue(fld){
	 valueTmp=DynamicForm_Invoice_Molybdenum.getValue(fld);
	 return (valueTmp==null || typeof (valueTmp)=='undefined' || valueTmp=="" ) ? 0 : valueTmp;
	}
	function DynamicForm_Invoice_Molybdenum_setValue(fld,value){
		DynamicForm_Invoice_Molybdenum.setValue(fld,value);
		if ( fld=="copperCal" || fld=='goldCal' || fld=='silverCal' )
		   DynamicForm_Invoice_Molybdenum_setValue("subTotal", DynamicForm_Invoice_Molybdenum_getValue("copperCal") +
		                                                        DynamicForm_Invoice_Molybdenum_getValue('goldCal') +
		                                                        DynamicForm_Invoice_Molybdenum_getValue('silverCal'));
        if (fld=="copper")
        	DynamicForm_Invoice_Molybdenum_setValue("RCCUPer",DynamicForm_Invoice_Molybdenum.getValue(fld));
        if (fld=="silverOun")
        	DynamicForm_Invoice_Molybdenum_setValue("RCAGPer",DynamicForm_Invoice_Molybdenum.getValue(fld));
        if (fld=="goldOun")
        	DynamicForm_Invoice_Molybdenum_setValue("RCAUPer",DynamicForm_Invoice_Molybdenum.getValue(fld));
        if (fld=="RCCUPer")
        	multiplyMolybdenumAndSet3("RCCUPer","RCCU","RCCUTot",DynamicForm_Invoice_Molybdenum.getValue("RCCUCal"));
        if (fld=="RCAGPer")
        	multiplyMolybdenumAndSet("RCAGPer","RCAG","RCAGTot");
        if (fld=="RCAUPer")
        	multiplyMolybdenumAndSet("RCAUPer","RCAU","RCAUTot");
		if (fld=="TC" || fld=="RCCUTot" || fld=='RCAGTot' || fld=='RCAUTot' )
		   DynamicForm_Invoice_Molybdenum_setValue("subTotalDeduction", DynamicForm_Invoice_Molybdenum_getValue("RCCUTot") +
		                                                        DynamicForm_Invoice_Molybdenum_getValue('TC') +
		                                                        DynamicForm_Invoice_Molybdenum_getValue('RCAGTot') +
		                                                        DynamicForm_Invoice_Molybdenum_getValue('RCAUTot'));
		if ((fld=="subTotal" || fld=='subTotalDeduction' ) )
		   DynamicForm_Invoice_Molybdenum_setValue("unitPrice", DynamicForm_Invoice_Molybdenum_getValue("subTotal") -
		                                                        DynamicForm_Invoice_Molybdenum_getValue('subTotalDeduction')) ;

// commercialInvoceValue=net*unitPrice
		if ((fld=="net" || fld=='unitPrice' ) && (hasValue("net") && hasValue('unitPrice') ))
			multiplyMolybdenumAndSet("net",'unitPrice',"commercialInvoceValue");
// commercialInvoceValueNet=paidPercent*commercialInvoceValue
		if ((fld=="paidPercent" || fld=='commercialInvoceValue' ) && (hasValue("paidPercent") && hasValue('commercialInvoceValue') ))
			multiplyMolybdenumAndSet("paidPercent",'commercialInvoceValue',"commercialInvoceValueNet");
// invoiceValueD=commercialInvoceValueNet- (beforePaid+otherCost+Depreciation)
		if ((fld=="commercialInvoceValueNet" || fld=='beforePaid'|| fld=='otherCost'|| fld=='Depreciation' ) )
		   DynamicForm_Invoice_Molybdenum_setValue("invoiceValueD", DynamicForm_Invoice_Molybdenum_getValue("commercialInvoceValueNet") -
		                                                        (DynamicForm_Invoice_Molybdenum_getValue('beforePaid') +
		                                                        DynamicForm_Invoice_Molybdenum_getValue('otherCost') +
		                                                        DynamicForm_Invoice_Molybdenum_getValue('Depreciation')));
// invoiceValue=rate2dollar*invoiceValueD
		if ((fld=="rate2dollar" || fld=='invoiceValueD' ) && (hasValue("rate2dollar") && hasValue('invoiceValueD') ))
			multiplyMolybdenumAndSet("rate2dollar",'invoiceValueD',"invoiceValue");
	}
     var DynamicForm_Invoice_Molybdenum = isc.DynamicForm.create({
        width: "100%",
        height: "100%",
        setMethod: 'POST',
        align: "center",
        canSubmit: true,
        showInlineErrors: true,
        showErrorText: true,
        showErrorStyle: true,
        errorOrientation: "right",
        titleWidth: "100", margin: '1px', wrapTitle: false,
        titleAlign: "right",
        requiredMessage: "<spring:message code='validator.field.is.required'/>",
        numCols: 12, backgroundImage: "backgrounds/leaves.jpg",
        fields:
            [
                {name: "id", hidden: true},
                {name: "shipmentId", hidden: true},
                {
                    type: "Header",
                    defaultValue: " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
                },
                {
                    name: "paidStatus",
                    title: "<spring:message code='invoice.paidStatus'/>",
                    type: 'text',
                    width: "100%",
                    defaultValue: "UNPAID",
                    valueMap: {"PAID": "PAID", "UNPAID": "UNPAID"}
                },
                {
                    name: "invoiceType",
                    title: "<spring:message code='invoice.invoiceType'/>",
                    type: 'text',
                    width: "100%",
                    required: true,
                    valueMap: {"PROVISIONAL": "PROVISIONAL", "FINAL": "FINAL", "PREPAID": "PREPAID"}
                },
                {
                    name: "invoiceNo", title: "<spring:message code='invoice.invoiceNo'/>",
                    required: true,
                    width: "100%",
                    colSpan: 1,
                    titleColSpan: 1,
                    wrapTitle: false,colSpan:2,titleColSpan:2
                },
                {
                    name: "invoiceDateDumy",
                    title: "<spring:message code='invoice.invoiceDate'/>",
                    defaultValue: "<%=dateUtil.todayDate()%>",
                    type: 'date',
                    format: 'DD-MM-YYYY',
                    required: true,
                    width: "100%",colSpan:3,titleColSpan:1
                },
                {
                    type: "Header",
                    defaultValue: " - - - -lotNo - - - - - - - - - grass- - - - - - - - - - - -net - - - - - - -  - MO%- - - - - - - CU%- molybdenumContent- discount%- - -  fee- - -price"
                },
<%		for (int i=0;i<list.size()+4;i++){ %>
                {name: "id<%=i %>", hidden: true},
                {name: "invoiceId<%=i %>", hidden: true},
                {name: "lotNo<%=i %>", showTitle: false,type: 'text', required: false, width: "100%"},
                {name: "grass<%=i %>", showTitle: false,type: 'float', required: false, width: "100%",keyPressFilter: "[0-9.]",colSpan:2,
                    validators: [{type: "isFloat",validateOnExit: true,stopOnError: true,errorMessage: "<spring:message code='global.form.correctType'/>" }] },
                {name: "net<%=i %>", showTitle: false,type: 'float', required: false, width: "100%",keyPressFilter: "[0-9.]",colSpan:2,
                    validators: [{type: "isFloat",validateOnExit: true,stopOnError: true,errorMessage: "<spring:message code='global.form.correctType'/>" }] },
                {name: "molybdenumPercent<%=i %>", showTitle: false,type: 'float', required: false, width: "100%",keyPressFilter: "[0-9.]",
                    validators: [{type: "isFloat",validateOnExit: true,stopOnError: true,errorMessage: "<spring:message code='global.form.correctType'/>" }] },
                {name: "copperPercent<%=i %>", showTitle: false,type: 'float', required: false, width: "100%",keyPressFilter: "[0-9.]",
                    validators: [{type: "isFloat",validateOnExit: true,stopOnError: true,errorMessage: "<spring:message code='global.form.correctType'/>" }] },
                {name: "molybdenumContent<%=i %>", showTitle: false,type: 'float', required: false, width: "100%",keyPressFilter: "[0-9.]",
                    validators: [{type: "isFloat",validateOnExit: true,stopOnError: true,errorMessage: "<spring:message code='global.form.correctType'/>" }] },
                {name: "discountPercent<%=i %>", showTitle: false,type: 'float', required: false, width: "100%",keyPressFilter: "[0-9.]",
                    validators: [{type: "isFloat",validateOnExit: true,stopOnError: true,errorMessage: "<spring:message code='global.form.correctType'/>" }] },
                {name: "priceFee<%=i %>", showTitle: false,type: 'float', required: false, width: "100%",keyPressFilter: "[0-9.]",
                    validators: [{type: "isFloat",validateOnExit: true,stopOnError: true,errorMessage: "<spring:message code='global.form.correctType'/>" }] },
                {name: "price<%=i %>", showTitle: false,type: 'float', required: false, width: "100%",keyPressFilter: "[0-9.]",colSpan:2,
                    validators: [{type: "isFloat",validateOnExit: true,stopOnError: true,errorMessage: "<spring:message code='global.form.correctType'/>" }] },
 <% } %>
                {
                    type: "Header",
                    defaultValue: " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
                },
               {
                    name: "molybdJenumUnitPrice", title: "<spring:message code='invoice.molybdJenumUnitPrice'/>",
                    type: 'float', required: false, width: "100%",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "molybdenum",
                    title: "<spring:message code='invoice.molybdenum'/>",
                    type: 'float',
                    required: false,
                    width: "100%",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "unitPrice",
                    title: "<spring:message code='invoice.unitPrice'/>",
                    type: 'float',
                    required: true,canEdit:false,
                    width: "100%",colSpan:2,titleColSpan:10,titleAlign:"right",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                 {
                    name: "grass",
                    title: "<spring:message code='global.grass'/>",
                    type: 'float',
                    required: true,
                    width: "100%",
                    keyPressFilter: "[0-9.]",colSpan:1,titleColSpan:2,titleAlign:"left",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "net",
                    title: "<spring:message code='global.net'/>",
                    type: 'float',
                    required: true,
                    width: "100%",
                    keyPressFilter: "[0-9.]",colSpan:1,titleColSpan:2,titleAlign:"center",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }],
                    changed	: function(form, item, value){
		   			  	multiplyMolybdenumAndSet("net","unitPrice","commercialInvoceValue");
		   			}

                },
                {
                    name: "commercialInvoceValue",
                    title: "<spring:message code='invoice.commercialInvoceValue'/>",
                    type: 'float',
                    required: true,canedit:false,
                    width: "100%",colSpan:2,titleColSpan:4,titleAlign:"right",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "paidPercent", title: "<spring:message code='invoice.paidPercent'/>",
                    type: 'float', required: true, width: "100%",colSpan:1,titleColSpan:5,titleAlign:"right",
                    validators: [
                        {
                            type: "isFloat",
                            validateOnExit: true,
                            stopOnError: true,
                            errorMessage: "<spring:message code='global.form.correctType'/>"
                        },
                        {
                            type: "integerRange",
                            min: 10,
                            max: 120,
                            errorMessage: "<spring:message code='invoice.form.paidPercent.prompt'/>"
                        }
                    ],
                    changed	: function(form, item, value){
		   			  	multiplyMolybdenumAndSet("paidPercent","commercialInvoceValue","commercialInvoceValueNet");
		   			}

                },
                {
                    name: "commercialInvoceValueNet",
                    title: "<spring:message code='invoice.commercialInvoceValueNet'/>",
                    type: 'float',
                    required: true,canEdit:false,
                    width: "100%",colSpan:2,titleColSpan:4,titleAlign:"right",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "Depreciation",
                    title: "<spring:message code='invoice.Depreciation'/>",
                    type: 'float',
                    required: false,
                    width: "100%",
                    wrapTitle: false,
                    titleColSpan: 1,colSpan: 1,
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }],
                    changed	: function(form, item, value){
		   			  	DynamicForm_Invoice_Molybdenum_setValue("Depreciation",value);
		   			}
               },
                {
                    name: "otherCost",
                    title: "<spring:message code='invoice.otherCost'/>",
                    type: 'float',
                    required: false,
                    width: "100%",colSpan:2,titleColSpan: 1,
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }],
                    changed	: function(form, item, value){
		   			  	DynamicForm_Invoice_Molybdenum_setValue("otherCost",value);
		   			}

                },
                {
                    name: "beforePaid",
                    title: "<spring:message code='invoice.beforePaid'/>",
                    type: 'float',
                    required: false,colSpan:2, titleColSpan: 1, wrapTitle: false,
                    width: "100%",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }],
                    changed	: function(form, item, value){
		   			  	DynamicForm_Invoice_Molybdenum_setValue("beforePaid",value);
		   			}
                },
                {
                    name: "invoiceValueD", title: "<spring:message code='invoice.invoiceValueD'/>",
                    type: 'float', required: true, width: "100%",colSpan:2,titleColSpan:2,titleAlign:"right",canEdit:false,
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
               {
                    type: "Header",
                    defaultValue: " - - - - - - - - - - - - - - - - - - - - - - - - - - Currency - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
                },
               {
                    name: "rateBase",
                    title: "<spring:message code='invoice.rateBase'/>",
                    type: 'float',
                    required: true,
                    width: "100%",colSpan:4,titleColSpan:1,
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                 {
                    name: "rate2dollar", title: "<spring:message code='invoice.rate2dollar'/>",
                    type: 'float', required: true, width: "100%",colSpan:1,titleColSpan:1,titleAlign:"right",
                    validators: [
                        {
                            type: "isFloat",
                            validateOnExit: true,
                            stopOnError: true,
                            errorMessage: "<spring:message code='global.form.correctType'/>"
                        },
                    ],
                    changed	: function(form, item, value){
		   			  	multiplyMolybdenumAndSet("rate2dollar","invoiceValueD","invoiceValue");
		   			}

                },
                {
                    name: "invoiceValueCurrency",
                    title: "<spring:message code='invoice.invoiceValueCur'/>",
                    type: 'text',
                    width: "100%",colSpan:1,titleColSpan:1,titleAlign:"center",
                    defaultValue: "DOLLAR",
                    valueMap: dollar
                },
                {
                    name: "invoiceValue",
                    title: "<spring:message code='invoice.invoiceValue'/>",
                    type: 'float',canEdit:false,
                    required: true,
                    width: "100%",colSpan:2,titleColSpan:1,titleAlign:"right",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
            ],
    });

   var record = ListGrid_Invoice.getSelectedRecord();
    DynamicForm_Invoice_Molybdenum.editRecord(record);

    if (!(record == null || record.id == null))
       DynamicForm_Invoice_Molybdenum.setValue("invoiceDateDumy", new Date(record.invoiceDate));

    var record = ListGrid_Shipment_InvoiceHeader.getSelectedRecord();
   DynamicForm_Invoice_Molybdenum.setValue("shipmentId", record.id);


     var IButton_Invoice_Molybdenum_Save = isc.IButton.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
            /*ValuesManager_GoodsUnit.validate();*/
            DynamicForm_Invoice_Molybdenum.validate();
            if (DynamicForm_Invoice_Molybdenum.hasErrors())
                return;
            var drs = DynamicForm_Invoice_Molybdenum.getValue("invoiceDateDumy");
            var datestringRs = (drs.getFullYear() + "/" + ("0" + (drs.getMonth() + 1)).slice(-2) + "/" + ("0" + drs.getDate()).slice(-2));
            DynamicForm_Invoice_Molybdenum.setValue("invoiceDate", datestringRs);
            DynamicForm_Invoice_Molybdenum.setValue("shipmentId", ListGrid_Shipment_InvoiceHeader.getSelectedRecord().id);

            var data = DynamicForm_Invoice_Molybdenum.getValues();
            var method = "PUT";
            if (data.id == null)
                method = "POST";
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest,{
                actionURL: "${contextPath}/api/invoice/",
                httpMethod: method,
                data: JSON.stringify(data),
                callback: function (resp) {
                    if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                        isc.say("<spring:message code='global.form.request.successful'/>.");
                        ListGrid_Invoice_refresh();
                        Window_Molybdenum.close();
                    } else
                        isc.say(RpcResponse_o.data);
                }
            }));
        }
    });
    var VLayout_Invoice_Molybdenum_Body = isc.VLayout.create({
        width: "100%",
        height: "100%",
        members: [
                DynamicForm_Invoice_Molybdenum,
                isc.HLayout.create({
                    width: "100%", align: "center", height: "20",
                    members:
                        [
                            IButton_Invoice_Molybdenum_Save,
                            isc.Label.create({
                                width: 5,
                            }),
                            isc.IButton.create({
                                title: "<spring:message code='global.cancel'/>",
                                width: 100,
                                icon: "pieces/16/icon_delete.png",
                                orientation: "vertical",
                                click: function () {
                                    Window_Molybdenum.close();
                                }
                            })
                        ]
                })
       ]
    });

