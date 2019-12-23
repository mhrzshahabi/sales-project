<%@ page import="com.nicico.copper.common.dto.grid.GridResponse" %>
<%@ page import="com.nicico.copper.common.util.date.DateUtil" %>
<%@ page import="com.nicico.sales.dto.InvoiceItemDTO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>

    <% DateUtil dateUtil = new DateUtil();
    	Float premium= new Float(request.getSession().getAttribute("premium").toString());

		String shipmentId= request.getSession().getAttribute("shipmentId").toString();
		String invoiceId=request.getSession().getAttribute("invoiceId").toString();

		GridResponse<InvoiceItemDTO.Info> gridResponseItem= (GridResponse<InvoiceItemDTO.Info> )request.getSession().getAttribute("gridResponseItem");
		List<InvoiceItemDTO.Info> listItem=gridResponseItem.getData();
		int loopUp=0;
		int loopDown=0;
		for(InvoiceItemDTO.Info info : listItem)
		    if (info.getUpDown().equalsIgnoreCase("up"))
		        loopUp++;
		    else
		        loopDown++;
    %>

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />


     var DynamicForm_Invoice_Cathodes ;
    function sumUpCathodesAndSet(){
       sumUp=0;
       for (i=0;i< <%= (loopUp==0 ? 3 : loopUp+2 ) %>;i++) {
          nt=0;
          if (DynamicForm_Invoice_Cathodes_getValue("up"+i+".lessPlus")=="PLUS") nt=1;
          else if (DynamicForm_Invoice_Cathodes_getValue("up"+i+".lessPlus")=="MINUS") nt=-1;
            DynamicForm_Invoice_Cathodes.setValue("up"+i+".targetValue",
                    DynamicForm_Invoice_Cathodes_getValue("up"+i+".conversionRate")*DynamicForm_Invoice_Cathodes_getValue("up"+i+".originValue")*nt);
            sumUp+=  DynamicForm_Invoice_Cathodes_getValue("up"+i+".targetValue");
       }
        DynamicForm_Invoice_Cathodes_setValue('invoiceValueD',DynamicForm_Invoice_Cathodes_getValue("commercialInvoceValueNet")+sumUp)	; // calling to compute invoice
	}
    function sumdownCathodesAndSet(){
       sumUp=0;
       for (i=0;i< <%= (loopDown==0 ? 3 : loopDown+2 ) %>;i++) {
          nt=0;
          if (DynamicForm_Invoice_Cathodes_getValue("down"+i+".lessPlus")=="PLUS") nt=1;
          else if (DynamicForm_Invoice_Cathodes_getValue("down"+i+".lessPlus")=="MINUS") nt=-1;
            DynamicForm_Invoice_Cathodes.setValue("down"+i+".targetValue",
                    DynamicForm_Invoice_Cathodes_getValue("down"+i+".conversionRate")*DynamicForm_Invoice_Cathodes_getValue("down"+i+".originValue")*nt);
            sumUp+=  DynamicForm_Invoice_Cathodes_getValue("down"+i+".targetValue");
       }
        DynamicForm_Invoice_Cathodes_setValue('invoiceValue',DynamicForm_Invoice_Cathodes_getValue("invoiceValueUp")+sumUp)	; // calling to compute invoice
	}

	function hasValue(fld){
	 valueTmp=DynamicForm_Invoice_Cathodes.getValue(fld);
	 return !(valueTmp==null || typeof (valueTmp)=='undefined' || valueTmp=="" );
	}
    function multiply (fld1,value) {
		if (value==null || typeof (value)=='undefined' || fld1==null || typeof (fld1) =='undefined')
		   return 0;
		return fld1 * value;
	}
	function multiplyAndSet (name1,name2,setName0) {
	  val1=DynamicForm_Invoice_Cathodes.getValue(name1);
	  val2=DynamicForm_Invoice_Cathodes.getValue(name2);
	  m=multiply(val1,val2)/((name1=="paidPercent" || name2=="paidPercent" || name1=="copper" || name2=="copper") ? 100 : 1);
	  // console.log('name1= '+name1+' name2= '+name2+ ' setname= '+setName0+' mult='+m);
	  DynamicForm_Invoice_Cathodes_setValue(setName0,m);
	}
	function multiplyAndSet3 (name1,name2,setName0,number1) {
	  val1=DynamicForm_Invoice_Cathodes.getValue(name1);
	  val2=DynamicForm_Invoice_Cathodes.getValue(name2);
	  m=multiply(val1,val2)*number1;
	  // console.log('name1= '+name1+' name2= '+name2+ ' setname= '+setName0+' mult='+m);
	  DynamicForm_Invoice_Cathodes_setValue(setName0,m);
	}
	function DynamicForm_Invoice_Cathodes_getValue(fld){
	 valueTmp=DynamicForm_Invoice_Cathodes.getValue(fld);
	 return (valueTmp==null || typeof (valueTmp)=='undefined' || valueTmp=="" ) ? 0 : valueTmp;
	}
	function DynamicForm_Invoice_Cathodes_setValue(fld,value){
		DynamicForm_Invoice_Cathodes.setValue(fld,value);
// commercialInvoceValue=net*unitPrice
		if ((fld=="net" || fld=='unitPrice' ) && (hasValue("net") && hasValue('unitPrice') ))
			multiplyAndSet("net",'unitPrice',"commercialInvoceValue");
// commercialInvoceValueNet=paidPercent*commercialInvoceValue
		if ((fld=="paidPercent" || fld=='commercialInvoceValue' ) && (hasValue("paidPercent") && hasValue('commercialInvoceValue') ))
			multiplyAndSet("paidPercent",'commercialInvoceValue',"commercialInvoceValueNet");
// commercialInvoceValueNet sumUpMolybdenumAndSet
		if (fld=="commercialInvoceValueNet"  )
		   sumUpCathodesAndSet() ;
// invoiceValue=rate2dollar*invoiceValueD
		if ((fld=="rate2dollar" || fld=='invoiceValueD' ) && (hasValue("rate2dollar") && hasValue('invoiceValueD') )){
			multiplyAndSet("rate2dollar",'invoiceValueD',"invoiceValueUp");
		}
		if ((fld=="invoiceValueUp" ) && ( hasValue('invoiceValueUp') )){
            sumdownCathodesAndSet() ;
		}
	}
//-----------------------------------------------------------------------------------------------------------------------------------
   var RestDataSource_ContactBySellerCathodes = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "code", title: "<spring:message code='contact.code'/>"},
                {name: "nameFA", title: "<spring:message code='contact.nameFa'/>"},
                {name: "nameEN", title: "<spring:message code='contact.nameEn'/>"},
                {name: "commertialRole"},
            ],
        fetchDataURL: "${contextPath}/api/contact/spec-list"
    });
    var RestDataSource_ContactByBuyerCathodes = isc.MyRestDataSource.create({
        fields:
            [
                {name: "id", primaryKey: true, canEdit: false, hidden: true},
                {name: "code", title: "<spring:message code='contact.code'/>"},
                {name: "nameFA", title: "<spring:message code='contact.nameFa'/>"},
                {name: "nameEN", title: "<spring:message code='contact.nameEn'/>"},
                {name: "commertialRole"},
            ],
        fetchDataURL: "${contextPath}/api/contact/spec-list"
    });
    var RestDataSource_Contact_optionCriteria_seller  = {
        _constructor: "AdvancedCriteria",
        operator: "or",
        criteria: [{fieldName: "seller", operator: "equals", value: true},{fieldName: "agentSeller", operator: "equals", value: true}]
    };
    var RestDataSource_Contact_optionCriteria_buyer = {
        _constructor: "AdvancedCriteria",
        operator: "or",
        criteria: [{fieldName: "buyer", operator: "equals", value: true},{fieldName: "agentBuyer", operator: "equals", value: true}]
    };
//-----------------------------------------------------------------------------------------------------------------------------------
    var DynamicForm_Invoice_Cathodes = isc.DynamicForm.create({
        width: "100%",
        height: "100%",
        setMethod: 'POST',
        align: "center",
        canSubmit: true,
        showInlineErrors: true,
        showErrorText: true,
        showErrorStyle: true,
        errorOrientation: "right",
        titleWidth: "100", margin: '0px', wrapTitle: true,
        titleAlign: "right",
        requiredMessage: "<spring:message code='validator.field.is.required'/>",
        numCols: 12, backgroundImage: "backgrounds/leaves.jpg",
        fields:
            [
                {name: "id", hidden: true},
                {name: "shipmentId", hidden: true},
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
                    wrapTitle: true,colSpan:2,titleColSpan:2
                },
                {
                    name: "invoiceDateDumy",
                    title: "<spring:message code='invoice.invoiceDate'/>",
                    defaultValue: "<%=dateUtil.todayDate()%>",
                    type: 'date',
                    format: 'DD-MM-YYYY',
                    required: true,
                    width: "100%",colSpan:1,titleColSpan:2
                },
                 {
                    name: "sellerId",
                    title: "Seller",
                    type: 'long',
                    width: "100%",
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_ContactBySellerCathodes,
                    optionCriteria: RestDataSource_Contact_optionCriteria_seller,
                    displayField: "nameFA",
                    valueField: "id",
                    pickListWidth: "500",
                    pickListHeight: "500",colSpan:2,titleColSpan:2,
                    pickListProperties: {showFilterEditor: true},
                    pickListFields: [
                        {name: "nameFA", align: "center"},
                        {name: "nameEN", align: "center"}
                    ]
                },
                 {
                    name: "buyerId",
                    title: "Buyer",
                    type: 'long',
                    width: "100%",
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_ContactByBuyerCathodes,
                    optionCriteria: RestDataSource_Contact_optionCriteria_buyer,
                    displayField: "nameFA",
                    valueField: "id",
                    pickListWidth: "500",
                    pickListHeight: "500",colSpan:2,titleColSpan:2,
                    pickListProperties: {showFilterEditor: true},
                    pickListFields: [{name: "nameFA", align: "center"}, {
                        name: "nameEN",
                        align: "center"
                    }]
                },
               {
                    type: "Header",
                    defaultValue: " - - - - - - - - - - - - - - Pricing - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
                },
                 {
                    name: "priceBase",
                    title: "<spring:message code='invoice.priceBase'/>",titleOrientation:'top',
                    type: 'text',
                    required: true,
                    width: "100%",colSpan:5,titleColSpan:1,
                },
                {name: "priceReference",title:"Reference", titleOrientation:'top',type: 'text', required: false, width: "100%",colSpan:1 ,valueMap: {"LME":"LME","PLATTS":"PLATTS","SHFG":"SHFG"} },
                {name: "priceFunction",title:"function", titleOrientation:'top',type: 'text', required: false, width: "100%",colSpan:1,valueMap: {"Avg":"Avg","Min":"Min","Max":"Max"} },
                {name: "priceFromDate",title:"From Date", titleOrientation:'top',type: 'text', useTextField:true, required: false, width: "100%",colSpan:1,mask:"####/##/##",
                       hint: "yyyy/mm/dd", showHintInField: true, blur: function(form, item){value=item.getValue();if (!validatedate(value))	item.setValue("");}  },
                 {name: "priceToDate",title:"To Date", titleOrientation:'top',type: 'text', useTextField:true, required: false, width: "100%",colSpan:1,mask:"####/##/##",
                       hint: "yyyy/mm/dd", showHintInField: true, blur: function(form, item){value=item.getValue();if (value==null || typeof (value)=='undefined' || value=="" )	return; validatedate(value);}  },
               {
                    name: "copperUnitPrice", title: "<spring:message code='invoice.copperUnitPrice'/>",
                    type: 'currencyFloat2',
                    width: "100%",
                    colSpan:1,titleColSpan:1,titleAlign:"right",titleOrientation:'top',
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }],
                    changed	: function(form, item, value){
		   			  	DynamicForm_Invoice_Cathodes_setValue("unitPrice",value+<%=premium %>);

		   			}

                },
                 {
                    name: "premium",
                    title: "<spring:message code='contract.premium'/>",titleOrientation:'top',
                    type: 'currencyFloat3',
                    canEdit: false,
                    width: "100%",
                    keyPressFilter: "[0-9.]",colSpan:1,titleColSpan:1,titleAlign:"left",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "unitPrice",
                    title: "<spring:message code='invoice.unitPriceCathode'/>",
                    type: 'currencyFloat2',
                    canEdit:false,
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
                    title: "<spring:message code='invoice.grassCathode'/>",
                    type: 'currencyFloat3',
                    required: true,
                    width: "100%",
                    keyPressFilter: "[0-9.]",colSpan:2,titleColSpan:1,titleAlign:"left",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "net",
                    title: "<spring:message code='invoice.netCathode'/>",
                    type: 'currencyFloat3',
                    required: true,
                    width: "100%",
                    keyPressFilter: "[0-9.]",colSpan:2,titleColSpan:2,titleAlign:"center",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }],
                    changed	: function(form, item, value){
		   			  	multiplyAndSet("net","unitPrice","commercialInvoceValue");
		   			}

                },
                {
                    name: "commercialInvoceValue",
                    title: "<spring:message code='invoice.commercialInvoceValue'/>",
                    type: 'currencyFloat2',
                    canEdit:false,
                    width: "100%",colSpan:2,titleColSpan:3,titleAlign:"right",
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
                    type: 'currencyFloat2', required: true, width: "100%",colSpan:1,titleColSpan:5,titleAlign:"right",
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
		   			  	multiplyAndSet("paidPercent","commercialInvoceValue","commercialInvoceValueNet");
		   			}

                },
                {
                    name: "commercialInvoceValueNet",
                    title: "<spring:message code='invoice.commercialInvoceValueNet'/>",
                    type: 'currencyFloat2',
                    canEdit:false,
                    width: "100%",colSpan:2,titleColSpan:4,titleAlign:"right",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
   <%		for (int i=0;i<(loopUp==0 ? 3 : loopUp+2 );i++){ %>
                {name: "up<%=i %>.id", hidden: true},
                {name: "up<%=i %>.invoiceId",defaultValue:<%=invoiceId %> , hidden: true},
                {name: "up<%=i %>.version", hidden: true},
                {name: "up<%=i %>.targetValueCurrency",defaultValue:"USD" , hidden: true},
                {name: "up<%=i %>.upDown",defaultValue:"up", hidden: true},
                {name: "up<%=i %>.description",title:"Description", <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %> ,type : 'text', required: false, width: "100%",colSpan:4},
                {name: "up<%=i %>.originValue",title:"OriginValue",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'currencyFloat2', required: false, width: "100%",keyPressFilter: "[0-9.]",colSpan:1,
                    validators: [{type: "isFloat",validateOnExit: true,stopOnError: true,errorMessage: "<spring:message code='global.form.correctType'/>" }],
                    changed	: function(form, item, value){ sumUpCathodesAndSet();	} },
                {name: "up<%=i %>.originValueCurrency",title:"Currency",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'text', required: false, width: "100%",colSpan:1,valueMap: dollar },
                {name: "up<%=i %>.conversionRate",title:"Rate 2 USD",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'currencyFloat5', required: false, width: "100%",keyPressFilter: "[0-9.]",colSpan:1,
                    validators: [{type: "isFloat",validateOnExit: true,stopOnError: true,errorMessage: "<spring:message code='global.form.correctType'/>" }],
                    changed	: function(form, item, value){ sumUpCathodesAndSet();	} },
                {name: "up<%=i %>.dateRate",title:"RateDate",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'text', useTextField:true, required: false, width: "100%",colSpan:1,mask:"####/##/##",
                       hint: "yyyy/mm/dd", showHintInField: true, blur: function(form, item){value=DynamicForm_Invoice_Cathodes.getValue("down<%=i %>.dateRate");if (value==null || typeof (value)=='undefined' || value=="" )	return; validatedate(value);}  },
                {name: "up<%=i %>.rateReference",title:"Refere",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'text', required: false, width: "100%",colSpan:1 },
                {name: "up<%=i %>.lessPlus",title:"+/-",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'text', required: false, width: "100%",colSpan:1,valueMap: {"PLUS":"PLUS","MINUS":"MINUS"} ,
                    changed	: function(form, item, value){ sumUpCathodesAndSet();	} },
                {name: "up<%=i %>.targetValue",title:"Value",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'currencyFloat2Sign', required: false, width: "100%",colSpan:2,canEdit:false },
   <% } %>
                {
                    name: "invoiceValueD", title: "<spring:message code='invoice.invoiceValueD'/>",
                    type: 'currencyFloat2Sign', width: "100%",colSpan:2,titleColSpan:10,titleAlign:"right",canEdit:false,
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
                    type: 'text',
                    required: true,
                    width: "100%",colSpan:4,titleColSpan:1,
                },
                 {
                    name: "rate2dollar", title: "<spring:message code='invoice.rate2dollar'/>",keyPressFilter: "[0-9.]",
                    type: 'currencyFloat2', required: true, width: "100%",colSpan:1,titleColSpan:1,titleAlign:"right",
                    validators: [
                        {
                            type: "isFloat",
                            validateOnExit: true,
                            stopOnError: true,
                            errorMessage: "<spring:message code='global.form.correctType'/>"
                        },
                    ],
                    changed	: function(form, item, value){
		   			  	multiplyAndSet("rate2dollar","invoiceValueD","invoiceValueUp");
		   			}

                },
                {
                    name: "invoiceValueCurrency",
                    title: "<spring:message code='invoice.invoiceValueCur'/>",
                    type: 'text',
                    width: "100%",colSpan:1,titleColSpan:1,titleAlign:"center",
                    defaultValue: "USD",
                    valueMap: dollar
                },
                {
                    name: "invoiceValueUp",
                    title: "<spring:message code='invoice.invoiceValue'/>",
                    type: 'currencyFloat2Sign',canEdit:false,
                    width: "100%",colSpan:2,titleColSpan:1,titleAlign:"right",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
   <%		for (int i=0;i<(loopDown==0 ? 3 : loopDown+2 );i++){ %>
                {name: "down<%=i %>.id", hidden: true},
                {name: "down<%=i %>.invoiceId",defaultValue:<%=invoiceId %> ,hidden: true},
                {name: "down<%=i %>.version", hidden: true},
                {name: "down<%=i %>.upDown",defaultValue:"down", hidden: true},
                {name: "down<%=i %>.description",title:"Description", <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %> ,type : 'text', required: false, width: "100%",colSpan:4},
                {name: "down<%=i %>.originValue",title:"OriginValue",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'currencyFloat2', required: false, width: "100%",keyPressFilter: "[0-9.]",colSpan:1,
                    validators: [{type: "isFloat",validateOnExit: true,stopOnError: true,errorMessage: "<spring:message code='global.form.correctType'/>" }],
                    changed	: function(form, item, value){ sumdownCathodesAndSet();	} },
                {name: "down<%=i %>.originValueCurrency",title:"Currency",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'text', required: false, width: "100%",colSpan:1,valueMap: dollar },
                {name: "down<%=i %>.conversionRate",title:"Rate2Invoice",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'currencyFloat5', required: false, width: "100%",keyPressFilter: "[0-9.]",colSpan:1,
                    validators: [{type: "isFloat",validateOnExit: true,stopOnError: true,errorMessage: "<spring:message code='global.form.correctType'/>" }],
                    changed	: function(form, item, value){ sumdownCathodesAndSet();	} },
                 {name: "down<%=i %>.dateRate",title:"RateDate",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'text', useTextField:true, required: false, width: "100%",colSpan:1,mask:"####/##/##",
                       hint: "yyyy/mm/dd", showHintInField: true, blur: function(form, item){value=DynamicForm_Invoice_Cathodes.getValue("up<%=i %>.dateRate");if (value==null || typeof (value)=='undefined' || value=="" )	return; validatedate(value);}  },
                {name: "down<%=i %>.rateReference",title:"Refere",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'text', required: false, width: "100%",colSpan:1 },
                {name: "down<%=i %>.lessPlus",title:"+/-",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'text', required: false, width: "100%",colSpan:1,valueMap: {"PLUS":"PLUS","MINUS":"MINUS"},
                    changed	: function(form, item, value){ sumdownCathodesAndSet();	} },
                {name: "down<%=i %>.targetValue",title:"Value",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'currencyFloat2Sign', required: false, width: "100%",colSpan:2,canEdit:false },
   <% } %>
                {
                    name: "invoiceValue",
                    title: "<spring:message code='invoice.invoiceValue'/>",
                    type: 'currencyFloat2Sign',canEdit:false,
                    required: true,
                    width: "100%",colSpan:2,titleColSpan:10,titleAlign:"right",
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
 <% if (invoiceId.equalsIgnoreCase("0")) { %>
   DynamicForm_Invoice_Cathodes.clearValues();
		DynamicForm_Invoice_Cathodes.clearValues();
 <% } else { %>
   DynamicForm_Invoice_Cathodes.editRecord(record);
 <% } %>

    if (!(record == null || record.id == null))
       DynamicForm_Invoice_Cathodes.setValue("invoiceDateDumy", new Date(record.invoiceDate));
   var record = ListGrid_Shipment_InvoiceHeader.getSelectedRecord();
   DynamicForm_Invoice_Cathodes.setValue("shipmentId", record.id);
   DynamicForm_Invoice_Cathodes.setValue("premium",<%=premium %>);
<%		loopUp=0;
		loopDown=0;
		for(InvoiceItemDTO.Info info : listItem)
		    if (info.getUpDown().equalsIgnoreCase("up")) { %>
		        DynamicForm_Invoice_Cathodes.setValue("up<%=loopUp %>.id" , <%=info.getId() %>);
		        DynamicForm_Invoice_Cathodes.setValue("up<%=loopUp %>.invoiceId" , <%=info.getInvoiceId() %>);
		        DynamicForm_Invoice_Cathodes.setValue("up<%=loopUp %>.version" , <%=info.getVersion() %>);
		        DynamicForm_Invoice_Cathodes.setValue("up<%=loopUp %>.upDown" , "<%=info.getUpDown() %>");
<%  	        if (info.getDescription()!=null) { %>
                   DynamicForm_Invoice_Cathodes.setValue("up<%=loopUp %>.description", "<%= info.getDescription() %>");
<%  	        } if (info.getOriginValue()!=null) { %>
                   DynamicForm_Invoice_Cathodes.setValue("up<%=loopUp %>.originValue", <%= info.getOriginValue() %>);
<%  	        } if (info.getOriginValueCurrency()!=null) { %>
                   DynamicForm_Invoice_Cathodes.setValue("up<%=loopUp %>.originValueCurrency", "<%= info.getOriginValueCurrency() %>");
<%  	        } if (info.getConversionRate()!=null) { %>
                   DynamicForm_Invoice_Cathodes.setValue("up<%=loopUp %>.conversionRate", <%= info.getConversionRate() %>);
<%  	        } if (info.getDateRate()!=null) { %>
                   DynamicForm_Invoice_Cathodes.setValue("up<%=loopUp %>.dateRate", "<%= info.getDateRate() %>");
<%  	        } if (info.getRateReference()!=null) { %>
                   DynamicForm_Invoice_Cathodes.setValue("up<%=loopUp %>.rateReference", "<%= info.getRateReference() %>");
<%  	        } if (info.getLessPlus()!=null) { %>
                   DynamicForm_Invoice_Cathodes.setValue("up<%=loopUp %>.lessPlus", "<%= info.getLessPlus() %>");
<%  	        } if (info.getTargetValue()!=null) { %>
                   DynamicForm_Invoice_Cathodes.setValue("up<%=loopUp %>.targetValue", <%= info.getTargetValue() %>);
               <% }
               loopUp++;
               }
		    else { %>
		        DynamicForm_Invoice_Cathodes.setValue("down<%=loopDown %>.id" , <%=info.getId() %>);
		        DynamicForm_Invoice_Cathodes.setValue("down<%=loopDown %>.invoiceId" , <%=info.getInvoiceId() %>);
		        DynamicForm_Invoice_Cathodes.setValue("down<%=loopDown %>.version" , <%=info.getVersion() %>);
		        DynamicForm_Invoice_Cathodes.setValue("down<%=loopDown %>.downDown" , "<%=info.getUpDown() %>");
<%  	        if (info.getDescription()!=null) { %>
                   DynamicForm_Invoice_Cathodes.setValue("down<%=loopDown %>.description", "<%= info.getDescription() %>");
<%  	        }if (info.getOriginValue()!=null) { %>
                   DynamicForm_Invoice_Cathodes.setValue("down<%=loopDown %>.originValue", <%= info.getOriginValue() %>);
<%  	        }if (info.getOriginValueCurrency()!=null) { %>
                   DynamicForm_Invoice_Cathodes.setValue("down<%=loopDown %>.originValueCurrency", "<%= info.getOriginValueCurrency() %>");
<%  	        }if (info.getConversionRate()!=null) { %>
                   DynamicForm_Invoice_Cathodes.setValue("down<%=loopDown %>.conversionRate", <%= info.getConversionRate() %>);
<%  	        }if (info.getDateRate()!=null) { %>
                   DynamicForm_Invoice_Cathodes.setValue("down<%=loopDown %>.dateRate", "<%= info.getDateRate() %>");
<%  	        }if (info.getRateReference()!=null) { %>
                   DynamicForm_Invoice_Cathodes.setValue("down<%=loopDown %>.rateReference", "<%= info.getRateReference() %>");
<%  	        }if (info.getLessPlus()!=null) { %>
                   DynamicForm_Invoice_Cathodes.setValue("down<%=loopDown %>.lessPlus", "<%= info.getLessPlus() %>");
<%  	        }if (info.getTargetValue()!=null) { %>
                   DynamicForm_Invoice_Cathodes.setValue("down<%=loopDown %>.targetValue", <%= info.getTargetValue() %>);
               <% }
                loopDown++;
            }
     %>
     var IButton_Invoice_Cathodes_Save = isc.IButton.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
            /*ValuesManager_GoodsUnit.validate();*/
            DynamicForm_Invoice_Cathodes.validate();
            if (DynamicForm_Invoice_Cathodes.hasErrors())
                return;
            var drs = DynamicForm_Invoice_Cathodes.getValue("invoiceDateDumy");
            var datestringRs = (drs.getFullYear() + "/" + ("0" + (drs.getMonth() + 1)).slice(-2) + "/" + ("0" + drs.getDate()).slice(-2));
            DynamicForm_Invoice_Cathodes.setValue("invoiceDate", datestringRs);
            DynamicForm_Invoice_Cathodes.setValue("shipmentId", ListGrid_Shipment_InvoiceHeader.getSelectedRecord().id);

            var data = DynamicForm_Invoice_Cathodes.getValues();
            var up=[];
          <%	for (int i=0;i<(loopUp==0 ? 3 : loopUp+2 );i++){ %>
                if ( data.up<%=i %>.description!=null || data.up<%=i %>.originValue!=null || data.up<%=i %>.conversionRate!=null || data.up<%=i %>.rateReference!=null  ){
                    data.up<%=i %>.targetValueCurrency="USD";
                    data.up<%=i %>.upDown="up";
                    data.up<%=i %>.invoiceId=<%=invoiceId %>;
                    if (data.up<%=i %>.lessPlus==null || data.up<%=i %>.lessPlus=="" ) {
                    	isc.warn("less or Plus  Required  (up<%=i %>)", {title: "<spring:message code='dialog_WarnTitle'/>"});
                    	return;
                    }
                    if (data.up<%=i %>.description==null || data.up<%=i %>.description=="" ) {
                    	isc.warn("description  Required  (up<%=i %>)", {title: "<spring:message code='dialog_WarnTitle'/>"});
                    	return;
                    }
                    if (data.up<%=i %>.originValue==null || data.up<%=i %>.originValue<=0 ) {
                    	isc.warn("Origin Value  Required  (up<%=i %>)", {title: "<spring:message code='dialog_WarnTitle'/>"});
                    	return;
                    }
                    if (data.up<%=i %>.originValueCurrency==null || data.up<%=i %>.originValueCurrency=="" ) {
                        data.up<%=i %>.originValueCurrency='USD';
                    	// isc.warn("Origin Value Currency  Required", {title: 'هشدار'});
                    	// return;
                    }
                    if (data.up<%=i %>.conversionRate==null || data.up<%=i %>.conversionRate<=0 ) {
                    	isc.warn("conversionRate  Required  (up<%=i %>)", {title:"<spring:message code='dialog_WarnTitle'/>"});
                    	return;
                    }
                    if (data.up<%=i %>.originValueCurrency=='USD' && data.up<%=i %>.conversionRate!=1){
                    	isc.warn("conversionRate  Must be One  (up<%=i %>)", {title:"<spring:message code='dialog_WarnTitle'/>"});
                    	return;
                    }
                    if (data.up<%=i %>.originValueCurrency!='USD')
                    if (data.up<%=i %>.dateRate==null || data.up<%=i %>.dateRate=="")  {
                    		isc.warn("Date Rate  Required  (up<%=i %>)", {title:"<spring:message code='dialog_WarnTitle'/>"});
                    		return;
                    }
                   if (data.up<%=i %>.dateRate!=null && data.up<%=i %>.dateRate!="" &&  !validatedate(data.up<%=i %>.dateRate)) {
                    		isc.warn("Date Rate  is rong  (up<%=i %>)", {title:"<spring:message code='dialog_WarnTitle'/>"});
                    		return;
                   }

                     if (data.up<%=i %>.lessPlus==null || data.up<%=i %>.lessPlus=="" ) {
                    	isc.warn("less or Plus  Required  (up<%=i %>)", {title:"<spring:message code='dialog_WarnTitle'/>"});
                    	return;
                    }
                    if ((data.up<%=i %>.rateReference==null || data.up<%=i %>.rateReference=="" )&& (data.up<%=i %>.originValueCurrency!='USD')) {
                    	isc.warn("Rate Reference  Required  (up<%=i %>)", {title:"<spring:message code='dialog_WarnTitle'/>"});
                    	return;
                    }
                    up.add(data.up<%=i %>);
                }
                else if ( data.up<%=i %>.id!=null)   up.add(data.up<%=i %>);

                // data.up<%=i %> ='';
          <% } %>
            var down=[];
            <%	for (int i=0;i<(loopDown==0 ? 3 : loopDown+2 );i++){ %>
                if ( data.down<%=i %>.description!=null || data.down<%=i %>.originValue!=null || data.down<%=i %>.conversionRate!=null || data.down<%=i %>.rateReference!=null  ){
                    // data.down<%=i %>.targetValueCurrency=DynamicForm_Invoice_Concentrate.getValue("invoiceValueCurrency") ;
                    data.down<%=i %>.upDown="down";
                    data.down<%=i %>.invoiceId=<%=invoiceId %>;
                    if (data.down<%=i %>.lessPlus==null || data.down<%=i %>.lessPlus=="" ) {
                    	isc.warn("less or Plus  Required  (down<%=i %>)", {title:"<spring:message code='dialog_WarnTitle'/>"});
                    	return;
                    }
                    if (data.down<%=i %>.description==null || data.down<%=i %>.description=="" ) {
                    	isc.warn("description  Required  (down<%=i %>)", {title:"<spring:message code='dialog_WarnTitle'/>"});
                    	return;
                    }
                    if (data.down<%=i %>.originValue==null || data.down<%=i %>.originValue<=0 ) {
                    	isc.warn("Origin Value  Required  (down<%=i %>)", {title:"<spring:message code='dialog_WarnTitle'/>"});
                    	return;
                    }
                     if (data.down<%=i %>.originValueCurrency==null || data.down<%=i %>.originValueCurrency=="" ) {
                        data.down<%=i %>.originValueCurrency=data.invoiceValueCurrency;
                    	// isc.warn("Origin Value Currency  Required", {title: 'هشدار'});
                    	// return;
                    }
                    if (data.down<%=i %>.conversionRate==null || data.down<%=i %>.conversionRate<=0 ) {
                    	isc.warn("conversionRate  Required  (down<%=i %>)", {title:"<spring:message code='dialog_WarnTitle'/>"});
                    	return;
                    }
                    if (data.down<%=i %>.originValueCurrency==data.invoiceValueCurrency && data.down<%=i %>.conversionRate!=1){
                    	isc.warn("conversionRate  Must be One  (down<%=i %>)", {title:"<spring:message code='dialog_WarnTitle'/>"});
                    	return;
                    }
                    if (data.down<%=i %>.originValueCurrency!= data.invoiceValueCurrency)
                    if (data.down<%=i %>.dateRate==null || data.down<%=i %>.dateRate=="")  {
                    		isc.warn("Date Rate  Required  (down<%=i %>)", {title:"<spring:message code='dialog_WarnTitle'/>"});
                    		return;
                    }
                   if (data.down<%=i %>.dateRate!=null && data.down<%=i %>.dateRate!="" &&  !validatedate(data.down<%=i %>.dateRate)) {
                    		isc.warn("Date Rate  is rong  (down<%=i %>)", {title:"<spring:message code='dialog_WarnTitle'/>"});
                    		return;
                   }
                     <%--if (data.down<%=i %>.lessPlus==null || data.down<%=i %>.lessPlus=="" ) {--%>
                    	<%--isc.warn("less or Plus  Required", {title: 'هشدار'});--%>
                    	<%--return;--%>
                    <%--}--%>
                    if ((data.down<%=i %>.rateReference==null || data.down<%=i %>.rateReference=="" )&& (data.down<%=i %>.originValueCurrency!=data.invoiceValueCurrency)) {
                    	isc.warn("Rate Reference  Required (down<%=i %>)", {title:"<spring:message code='dialog_WarnTitle'/>"});
                    	return;
                    }
                    up.add(data.down<%=i %>);
                }
                else if ( data.down<%=i %>.id!=null)   up.add(data.down<%=i %>);
                // data.down<%=i %> ='';
            <% } %>
            var mo=[];
            dataOut=JSON.stringify(mo)+'@abaspour@'+JSON.stringify(up)+'@abaspour@'+JSON.stringify(down)+'@abaspour@'+JSON.stringify(data);
            var method = "PUT";
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest,{
                actionURL: "${contextPath}/api/invoice/molybdenum",
                httpMethod: method,
                data: dataOut,
                callback: function (resp) {
                    if (resp.httpResponseCode == 200 || resp.httpResponseCode == 201) {
                        isc.say("<spring:message code='global.form.request.successful'/>.");
                        ListGrid_Invoice_refresh();
                        Window_Cathodes.close();
                    } else
                        isc.say(RpcResponse_o.data);
                }
            }));
        }
    });
    var VLayout_Invoice_Cathodes_Body = isc.VLayout.create({
        width: "100%",
        height: "100%",
        showScrollbar: true,
         overflow :'scroll',
               // autoSize: true,

        members: [
                DynamicForm_Invoice_Cathodes,
                isc.HLayout.create({
                    width: "100%", align: "center", height: "20",
                    members:
                        [
                            IButton_Invoice_Cathodes_Save,
                            isc.Label.create({
                                width: 5,
                            }),
                            isc.IButton.create({
                                title: "<spring:message code='global.cancel'/>",
                                width: 100,
                                icon: "pieces/16/icon_delete.png",
                                orientation: "vertical",
                                click: function () {
                                    Window_Cathodes.close();
                                }
                            })
                        ]
                })
       ]
    });

