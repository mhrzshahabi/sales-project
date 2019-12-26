<%@ page import="com.nicico.copper.common.dto.grid.GridResponse" %>
<%@ page import="com.nicico.copper.common.util.date.DateUtil" %>
<%@ page import="com.nicico.sales.dto.InvoiceItemDTO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

//<script>

    <% DateUtil dateUtil = new DateUtil();
    	Float treatCost= new Float(request.getSession().getAttribute("treatCost").toString());
    	Float refinaryCost= new Float(request.getSession().getAttribute("refinaryCost").toString());
    	Float copper= new Float(request.getSession().getAttribute("copper").toString());
    	Float silver= new Float(request.getSession().getAttribute("silver").toString());
    	Float gold= new Float(request.getSession().getAttribute("gold").toString());

		String shipmentId= request.getSession().getAttribute("shipmentId").toString();
		String invoiceId=request.getSession().getAttribute("invoiceId").toString();

		GridResponse<InvoiceItemDTO.Info> gridResponseItem= (GridResponse<InvoiceItemDTO.Info> )request.getSession().getAttribute("gridResponseItem");
		List<InvoiceItemDTO.Info> listItem=gridResponseItem.getData();
		int loopUp=0;
		int loopDown=0;
		for(int i=0;i<listItem.size();i++)
		    if (listItem.get(i).getUpDown().equalsIgnoreCase("up"))
		        loopUp++;
		    else
		        loopDown++;
    %>

    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />


     var DynamicForm_Invoice_Concentrate ;
    function sumUpConcentrateAndSet(){
       sumUp=0;
       for (i=0;i< <%= (loopUp==0 ? 3 : loopUp+2 ) %>;i++) {
          nt=0;
          if (DynamicForm_Invoice_Concentrate_getValue("up"+i+".lessPlus")=="PLUS") nt=1;
          else if (DynamicForm_Invoice_Concentrate_getValue("up"+i+".lessPlus")=="MINUS") nt=-1;
            DynamicForm_Invoice_Concentrate.setValue("up"+i+".targetValue",
                    DynamicForm_Invoice_Concentrate_getValue("up"+i+".conversionRate")*DynamicForm_Invoice_Concentrate_getValue("up"+i+".originValue")*nt);
            sumUp+=  DynamicForm_Invoice_Concentrate_getValue("up"+i+".targetValue");
       }
        DynamicForm_Invoice_Concentrate_setValue('invoiceValueD',DynamicForm_Invoice_Concentrate_getValue("commercialInvoceValueNet")+sumUp)	; // calling to compute invoice
	}
    function sumdownConcentrateAndSet(){
       sumUp=0;
       for (i=0;i< <%= (loopDown==0 ? 3 : loopDown+2 ) %>;i++) {
          nt=0;
          if (DynamicForm_Invoice_Concentrate_getValue("down"+i+".lessPlus")=="PLUS") nt=1;
          else if (DynamicForm_Invoice_Concentrate_getValue("down"+i+".lessPlus")=="MINUS") nt=-1;
            DynamicForm_Invoice_Concentrate.setValue("down"+i+".targetValue",
                    DynamicForm_Invoice_Concentrate_getValue("down"+i+".conversionRate")*DynamicForm_Invoice_Concentrate_getValue("down"+i+".originValue")*nt);
            sumUp+=  DynamicForm_Invoice_Concentrate_getValue("down"+i+".targetValue");
       }
        DynamicForm_Invoice_Concentrate_setValue('invoiceValue',DynamicForm_Invoice_Concentrate_getValue("invoiceValueUp")+sumUp)	; // calling to compute invoice
	}

	function hasValue(fld){
	 valueTmp=DynamicForm_Invoice_Concentrate.getValue(fld);
	 return !(valueTmp==null || typeof (valueTmp)=='undefined' || valueTmp=="" );
	}
    function multiply (fld1,value) {
		if (value==null || typeof (value)=='undefined' || fld1==null || typeof (fld1) =='undefined')
		   return 0;
		return fld1 * value;
	}
	function multiplyAndSet (name1,name2,setName0) {
	  val1=DynamicForm_Invoice_Concentrate.getValue(name1);
	  val2=DynamicForm_Invoice_Concentrate.getValue(name2);
	  m=multiply(val1,val2)/((name1=="paidPercent" || name2=="paidPercent" || name1=="copper" || name2=="copper") ? 100 : 1);
	  DynamicForm_Invoice_Concentrate_setValue(setName0,m);
	}
	function multiplyAndSet3 (name1,name2,setName0,number1) {
	  val1=DynamicForm_Invoice_Concentrate.getValue(name1);
	  val2=DynamicForm_Invoice_Concentrate.getValue(name2);
	  m=multiply(val1,val2)*number1;
	  DynamicForm_Invoice_Concentrate_setValue(setName0,m);
	}
	function DynamicForm_Invoice_Concentrate_getValue(fld){
	 valueTmp=DynamicForm_Invoice_Concentrate.getValue(fld);
	 return (valueTmp==null || typeof (valueTmp)=='undefined' || valueTmp=="" ) ? 0 : valueTmp;
	}
	function DynamicForm_Invoice_Concentrate_setValue(fld,value){
		DynamicForm_Invoice_Concentrate.setValue(fld,value);
		if ( fld=="copperCal" || fld=='goldCal' || fld=='silverCal' )
		   DynamicForm_Invoice_Concentrate_setValue("subTotal", DynamicForm_Invoice_Concentrate_getValue("copperCal") +
		                                                        DynamicForm_Invoice_Concentrate_getValue('goldCal') +
		                                                        DynamicForm_Invoice_Concentrate_getValue('silverCal'));
        if (fld=="copper")
        	DynamicForm_Invoice_Concentrate_setValue("refinaryCostCUPer",DynamicForm_Invoice_Concentrate.getValue(fld));
        if (fld=="silverOun")
        	DynamicForm_Invoice_Concentrate_setValue("refinaryCostAGPer",DynamicForm_Invoice_Concentrate.getValue(fld));
        if (fld=="goldOun")
        	DynamicForm_Invoice_Concentrate_setValue("refinaryCostAUPer",DynamicForm_Invoice_Concentrate.getValue(fld));
        if (fld=="refinaryCostCUPer" || fld=="refinaryCostCU")
        	multiplyAndSet3("refinaryCostCUCal","refinaryCostCU","refinaryCostCUTot",DynamicForm_Invoice_Concentrate.getValue("refinaryCostCUPer")/100);
        if (fld=="refinaryCostAGPer" || fld=="refinaryCostAG")
        	multiplyAndSet("refinaryCostAGPer","refinaryCostAG","refinaryCostAGTot");
        if (fld=="refinaryCostAUPer" || fld=="refinaryCostAU")
        	multiplyAndSet("refinaryCostAUPer","refinaryCostAU","refinaryCostAUTot");
		if (fld=="treatCost" || fld=="refinaryCostCUTot" || fld=='refinaryCostAGTot' || fld=='refinaryCostAUTot' )
		   DynamicForm_Invoice_Concentrate_setValue("subTotalDeduction", DynamicForm_Invoice_Concentrate_getValue("refinaryCostCUTot") +
		                                                        DynamicForm_Invoice_Concentrate_getValue('treatCost') +
		                                                        DynamicForm_Invoice_Concentrate_getValue('refinaryCostAGTot') +
		                                                        DynamicForm_Invoice_Concentrate_getValue('refinaryCostAUTot'));
		if ((fld=="subTotal" || fld=='subTotalDeduction' ) )
		   DynamicForm_Invoice_Concentrate_setValue("unitPrice", DynamicForm_Invoice_Concentrate_getValue("subTotal") -
		                                                        DynamicForm_Invoice_Concentrate_getValue('subTotalDeduction')) ;
// commercialInvoceValue=net*unitPrice
		if ((fld=="net" || fld=='unitPrice' ) && (hasValue("net") && hasValue('unitPrice') ))
			multiplyAndSet("net",'unitPrice',"commercialInvoceValue");
// commercialInvoceValueNet=paidPercent*commercialInvoceValue
		if ((fld=="paidPercent" || fld=='commercialInvoceValue' ) && (hasValue("paidPercent") && hasValue('commercialInvoceValue') ))
			multiplyAndSet("paidPercent",'commercialInvoceValue',"commercialInvoceValueNet");
// commercialInvoceValueNet sumUpMolybdenumAndSet
		if (fld=="commercialInvoceValueNet"  )
		   sumUpConcentrateAndSet() ;
// invoiceValue=rate2dollar*invoiceValueD
		if ((fld=="rate2dollar" || fld=='invoiceValueD' ) && (hasValue("rate2dollar") && hasValue('invoiceValueD') )){
			multiplyAndSet("rate2dollar",'invoiceValueD',"invoiceValueUp");
		}
		if ((fld=="invoiceValueUp" ) && ( hasValue('invoiceValueUp') )){
            sumdownConcentrateAndSet() ;
		}
	}

   var RestDataSource_ContactBySellerConcentrate = isc.MyRestDataSource.create({
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
    var RestDataSource_ContactByBuyerConcentrate = isc.MyRestDataSource.create({
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
    var RestDataSource_Contact_optionCriteria_seller_Concentrate  = {
        _constructor: "AdvancedCriteria",
        operator: "or",
        criteria: [{fieldName: "seller", operator: "equals", value: true},{fieldName: "agentSeller", operator: "equals", value: true}]
    };
    var RestDataSource_Contact_optionCriteria_buyer_Concentrate = {
        _constructor: "AdvancedCriteria",
        operator: "or",
        criteria: [{fieldName: "buyer", operator: "equals", value: true},{fieldName: "agentBuyer", operator: "equals", value: true}]
    };

    var DynamicForm_Invoice_Concentrate = isc.DynamicForm.create({
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
                    width: "100%",colSpan:3,titleColSpan:1
                },
                 {
                    name: "sellerId",
                    title: "Seller",
                    type: 'long',
                    width: "100%",
                    editorType: "SelectItem",
                    optionDataSource: RestDataSource_ContactBySellerConcentrate,
                    optionCriteria: RestDataSource_Contact_optionCriteria_seller_Concentrate,
                    displayField: "nameFA",
                    valueField: "id",
                    pickListWidth: "500",
                    pickListHeight: "500",colSpan:3,titleColSpan:1,
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
                    optionDataSource: RestDataSource_ContactByBuyerConcentrate,
                    optionCriteria: RestDataSource_Contact_optionCriteria_buyer_Concentrate,
                    displayField: "nameFA",
                    valueField: "id",
                    pickListWidth: "500",
                    pickListHeight: "500",colSpan:3,titleColSpan:1,
                    pickListProperties: {showFilterEditor: true},
                    pickListFields: [{name: "nameFA", align: "center"}, {
                        name: "nameEN",
                        align: "center"
                    }]
                },
                {
                    type: "Header",
                    defaultValue: " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - Assay calculation in one DMT- - - - - - - - - - - - - - - - - - - - - - - - -"
                },
                {
                    name: "copperIns",
                    title: "<spring:message code='invoice.copperIns'/>",
                    type: 'currencyFloat3',
                    required: false,
                    width: "100%",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }],
                    changed	: function(form, item, value){
					  if (value!=null && typeof (value)!='undefined'){
                    	var tmp=DynamicForm_Invoice_Concentrate.getValue("copperDed");
                    	if (tmp!=null && typeof (tmp)!='undefined')
                    	    if (value<0)
		   						DynamicForm_Invoice_Concentrate_setValue("copper",(tmp * value));
		   					else
		   						DynamicForm_Invoice_Concentrate_setValue("copper", (value - tmp));
		   			  }
		   			    else DynamicForm_Invoice_Concentrate_setValue("copper","0");
		   			  multiplyAndSet("copper","copperUnitPrice","copperCal");
		   			}
                },
                {
                    name: "copperDed",
                    title: "<spring:message code='invoice.copperDed'/>",
                    type: 'currencyFloat3',
                    required: false,
                    width: "100%",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }],
                    changed	: function(form, item, value){
					  if (value!=null && typeof (value)!='undefined'){
                    	var tmp=DynamicForm_Invoice_Concentrate.getValue("copperIns");
                    	if (tmp!=null && typeof (tmp)!='undefined')
                    	    if (value<0)
		   						DynamicForm_Invoice_Concentrate_setValue("copper",(tmp * value));
		   					else
		   						DynamicForm_Invoice_Concentrate_setValue("copper",(tmp - value));
		   			  }
		   			    else DynamicForm_Invoice_Concentrate_setValue("copper","0")
					  multiplyAndSet("copper","copperUnitPrice","copperCal");

		   			}

                },
                {
                    name: "copper",
                    title: "<spring:message code='invoice.copper'/>",
                    type: 'currencyFloat3',
                    required: false,canEdit:false,
                    width: "100%",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }],
                },
                {
                    name: "copperUnitPrice", title: "<spring:message code='invoice.copperUnitPrice'/>",
                    type: 'currencyFloat2', required: false, width: "100%",colSpan:2,titleColSpan:1,
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }],
                    changed	: function(form, item, value){
		   			  	multiplyAndSet("copper","copperUnitPrice","copperCal");

		   			}
                },
                 {
                    name: "copperCal",
                    title: "<spring:message code='invoice.copperCal'/>",
                    type: 'currencyFloat2',
                    required: false,canEdit:false,
                    width: 204,colSpan:2,titleColSpan:1,
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "silverIns",
                    title: "<spring:message code='invoice.silverIns'/>",
                    type: 'currencyFloat3',
                    required: false,
                    width: "100%",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }],
                    changed	: function(form, item, value){
		   			  	multiplyAndSet("silverIns","silverDed","silver");
		   			  	DynamicForm_Invoice_Concentrate_setValue("silverOun",DynamicForm_Invoice_Concentrate.getValue("silver")/31.1034);
		   			  	multiplyAndSet("silverOun","silverUnitPrice","silverCal");
		   			}

                },
                {
                    name: "silverDed",
                    title: "<spring:message code='invoice.silverDed'/>",
                    type: 'currencyFloat3',
                    required: false,
                    width: "100%",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }],
                    changed	: function(form, item, value){
		   			  	multiplyAndSet("silverIns","silverDed","silver");
		   			  	DynamicForm_Invoice_Concentrate_setValue("silverOun",DynamicForm_Invoice_Concentrate.getValue("silver")/31.1034);
		   			  	multiplyAndSet("silverOun","silverUnitPrice","silverCal");
		   			}

                },
                {
                    name: "silver",
                    title: "<spring:message code='invoice.silver'/>",
                    type: 'currencyFloat3',
                    required: false,canEdit:false,
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
                    name: "silverOun",
                    title: "<spring:message code='invoice.silverOun'/>",
                    type: 'currencyFloat5',
                    required: false,canEdit:false,
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
                    name: "silverUnitPrice", title: "<spring:message code='invoice.silverUnitPrice'/>",
                    type: 'currencyFloat3', required: false, width: "100%",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }],
                    changed	: function(form, item, value){
		   			  	multiplyAndSet("silverIns","silverDed","silver");
		   			  	DynamicForm_Invoice_Concentrate_setValue("silverOun",DynamicForm_Invoice_Concentrate_getValue("silver")/31.1034);
		   			  	multiplyAndSet("silverOun","silverUnitPrice","silverCal");
		   			}

                },
                 {
                    name: "silverCal",
                    title: "<spring:message code='invoice.silverCal'/>",
                    type: 'currencyFloat2',
                    required: false,canEdit:false,
                    width: 95,
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "goldIns",
                    title: "<spring:message code='invoice.goldIns'/>",
                    type: 'currencyFloat3',
                    required: false,
                    width: "100%",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }],
                    changed	: function(form, item, value){
		   			  	multiplyAndSet("goldIns","goldDed","gold");
		   			  	DynamicForm_Invoice_Concentrate_setValue("goldOun",DynamicForm_Invoice_Concentrate_getValue("gold")/31.1034);
		   			  	multiplyAndSet("goldOun","goldUnitPrice","goldCal");
		   			}

                },
                {
                    name: "goldDed",
                    title: "<spring:message code='invoice.goldDed'/>",
                    type: 'currencyFloat3',
                    required: false,
                    width: "100%",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }],
                    changed	: function(form, item, value){
		   			  	multiplyAndSet("goldIns","goldDed","gold");
		   			  	DynamicForm_Invoice_Concentrate_setValue("goldOun",DynamicForm_Invoice_Concentrate_getValue("gold")/31.1034);
		   			  	multiplyAndSet("goldOun","goldUnitPrice","goldCal");
		   			}
                },
                {
                    name: "gold",
                    title: "<spring:message code='invoice.gold'/>",
                    type: 'currencyFloat3',
                    required: false,canEdit:false,
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
                    name: "goldOun",
                    title: "<spring:message code='invoice.goldOun'/>",
                    type: 'currencyFloat5',
                    required: false,canEdit:false,
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
                    name: "goldUnitPrice", title: "<spring:message code='invoice.goldUnitPrice'/>",
                    type: 'currencyFloat3', required: false, width: "100%",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }],
                    changed	: function(form, item, value){
		   			  	multiplyAndSet("goldIns","goldDed","gold");
		   			  	DynamicForm_Invoice_Concentrate_setValue("goldOun",DynamicForm_Invoice_Concentrate_getValue("gold")/31.1034);
		   			  	multiplyAndSet("goldOun","goldUnitPrice","goldCal");
		   			}

                },
                 {
                    name: "goldCal",
                    title: "<spring:message code='invoice.goldCal'/>",
                    type: 'currencyFloat2',
                    canEdit:false,
                    width: 95,
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                  {
                    name: "priceBase",
                    title: "<spring:message code='invoice.priceBase'/>",titleOrientation:'top',
                    type: 'text',
                    required: true,
                    width: "100%",colSpan:4,titleColSpan:1,
                },
                {name: "priceReference",title:"Reference", titleOrientation:'top',type: 'text', required: false, width: "100%",colSpan:1 ,valueMap: {"LME":"LME","PLATTS":"PLATTS","SHFG":"SHFG"} },
                {name: "priceFunction",title:"function", titleOrientation:'top',type: 'text', required: false, width: "100%",colSpan:1,valueMap: {"Avg":"Avg","Min":"Min","Max":"Max"} },
                {name: "priceFromDate",title:"From Date", titleOrientation:'top',type: 'text', useTextField:true, required: false, width: "100%",colSpan:2,mask:"####/##/##",
                       hint: "yyyy/mm/dd", showHintInField: true, blur: function(form, item){value=item.getValue();if (!validatedate(value))	item.setValue("");}  },
                 {name: "priceToDate",title:"To Date", titleOrientation:'top',type: 'text', useTextField:true, required: false, width: "100%",colSpan:2,mask:"####/##/##",
                       hint: "yyyy/mm/dd", showHintInField: true, blur: function(form, item){value=item.getValue();if (value==null || typeof (value)=='undefined' || value=="" )	return; validatedate(value);}  },
               {
                    name: "subTotal",
                    title: "<spring:message code='invoice.subTotal'/>",titleOrientation:'top',
                    type: 'currencyFloat2',
                    canEdit:false,
                    width: 95,colSpan:1,titleColSpan:1,
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    type: "Header",
                    defaultValue: " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - DEDUCTION  per one DMT- - - - - - - - - - - - - - - - - - - - - - - - -"
                },
                {
                    name: "treatCost",
                    title: "<spring:message code='invoice.TC'/>",
                    type: 'currencyFloat2',
                    required: true,// canEdit:false,
                    width: 204,colSpan:2,titleColSpan:10,titleAlign:"left",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {

                    name: "refinaryCostCU",
                    title: "<spring:message code='invoice.RCCU'/>",
                    type: 'currencyFloat5',
                    required: true,// canEdit:false,
                    width: "100%",colSpan:1,titleColSpan:2,titleAlign:"left",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }],
                    changed	: function(form, item, value){
		   			  	DynamicForm_Invoice_Concentrate_setValue("refinaryCostCU",value);
		   			}

                },
                {
                    name: "refinaryCostCUPer",
                    title: "<spring:message code='invoice.RCCUPerc'/>",
                    type: 'currencyFloat5',
                    canEdit:false,
                    width: "100%",colSpan:1,titleColSpan:2,titleAlign:"center",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "refinaryCostCUCal",
                    title: "<spring:message code='invoice.RCCUCal'/>",
                    type: 'currencyFloat2',
                    canEdit:false,
                    width: "100%",colSpan:1,titleColSpan:2,titleAlign:"center",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "refinaryCostCUTot",
                    title: "<spring:message code='invoice.RCCUTot'/>",
                    type: 'currencyFloat2',
                    canEdit:false,
                    width: 204,colSpan:2,titleColSpan:1,titleAlign:"right",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "refinaryCostAG",
                    title: "<spring:message code='invoice.RCAG'/>",
                    type: 'currencyFloat5',
                    required : true,// canEdit:false,
                    width: "100%",colSpan:1,titleColSpan:2,titleAlign:"left",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }],
                    changed	: function(form, item, value){
		   			  	DynamicForm_Invoice_Concentrate_setValue("refinaryCostAG",value);
		   			}

                },
                {
                    name: "refinaryCostAGPer",
                    title: "<spring:message code='invoice.RCCUPerc'/>",
                    type: 'currencyFloat5',
                    canEdit:false,
                    width: "100%",colSpan:1,titleColSpan:2,titleAlign:"center",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "refinaryCostAGTot",
                    title: "<spring:message code='invoice.RCCUTot'/>",
                    type: 'currencyFloat2',
                    canEdit:false,
                    width: 204,colSpan:2,titleColSpan:4,titleAlign:"right",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "refinaryCostAU",
                    title: "<spring:message code='invoice.RCAU'/>",
                    type: 'currencyFloat5',
                    required : true,// canEdit:false,
                    width: "100%",colSpan:1,titleColSpan:2,titleAlign:"left",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }],
                    changed	: function(form, item, value){
		   			  	DynamicForm_Invoice_Concentrate_setValue("refinaryCostAU",value);
		   			}

                },
                {
                    name: "refinaryCostAUPer",
                    title: "<spring:message code='invoice.RCCUPerc'/>",
                    type: 'currencyFloat5',
                    canEdit:false,
                    width: "100%",colSpan:1,titleColSpan:2,titleAlign:"center",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                {
                    name: "refinaryCostAUTot",
                    title: "<spring:message code='invoice.RCCUTot'/>",
                    type: 'currencyFloat2',
                    canEdit:false,
                    width: 204,colSpan:2,titleColSpan:4,titleAlign:"right",
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
                 {
                    name: "subTotalDeduction",
                    title: "<spring:message code='invoice.subTotalDed'/>",
                    type: 'currencyFloat2',
                    canEdit:false,
                    width: 204,colSpan:2,titleColSpan:10,
                    keyPressFilter: "[0-9.]",
                    validators: [{
                        type: "isFloat",
                        validateOnExit: true,
                        stopOnError: true,
                        errorMessage: "<spring:message code='global.form.correctType'/>"
                    }]
                },
               {
                    type: "Header",
                    defaultValue: " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - INVOICE - - - - - - - - - - - - - - - - - - - - - - - - -"
                },
                {
                    name: "unitPrice",
                    title: "<spring:message code='invoice.unitPrice'/>",
                    type: 'currencyFloat2',
                    canEdit:false,
                    width: 204,colSpan:2,titleColSpan:10,titleAlign:"right",
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
                    type: 'currencyFloat3',
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
                    width: 204,colSpan:2,titleColSpan:3,titleAlign:"right",
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
                    type: 'currencyFloat2', required: true, width: "100%",colSpan:1
                    ,titleColSpan:5,
                    titleAlign:"right",
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
                    width: 204,colSpan:2,titleColSpan:4,titleAlign:"right",
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
                    changed	: function(form, item, value){ sumUpConcentrateAndSet();	} },
                {name: "up<%=i %>.originValueCurrency",title:"Currency",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'text', required: false, width: "100%",colSpan:1,valueMap: dollar },
                {name: "up<%=i %>.conversionRate",title:"Rate 2 USD",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'currencyFloat5', required: false, width: "100%",keyPressFilter: "[0-9.]",colSpan:1,
                    validators: [{type: "isFloat",validateOnExit: true,stopOnError: true,errorMessage: "<spring:message code='global.form.correctType'/>" }],
                    changed	: function(form, item, value){ sumUpConcentrateAndSet();	} },
                {name: "up<%=i %>.dateRate",title:"RateDate",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'text', useTextField:true, required: false, width: "100%",colSpan:1,mask:"####/##/##",
                       hint: "yyyy/mm/dd", showHintInField: true, blur: function(form, item){value=DynamicForm_Invoice_Concentrate.getValue("up<%=i %>.dateRate");if (value==null || typeof (value)=='undefined' || value=="" )	return; validatedate(value);}  },
                {name: "up<%=i %>.rateReference",title:"Refere",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'text', required: false, width: "100%",colSpan:1 },
                {name: "up<%=i %>.lessPlus",title:"+/-",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'text', required: false, width: "100%",colSpan:1,valueMap: {"PLUS":"PLUS","MINUS":"MINUS"} ,
                    changed	: function(form, item, value){ sumUpConcentrateAndSet();	} },
                {name: "up<%=i %>.targetValue",title:"Value",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'currencyFloat2Sign', required: false, width: "204",colSpan:2,canEdit:false },
   <% } %>
                {
                    name: "invoiceValueD", title: "<spring:message code='invoice.invoiceValueD'/>",
                    type: 'currencyFloat2Sign', width: "204",colSpan:2,titleColSpan:10,titleAlign:"right",canEdit:false,
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
                    width: "204",colSpan:2,titleColSpan:1,titleAlign:"right",
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
                {name: "down<%=i %>.description",title:"Description", <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %> ,type : 'text', required: false, width: "204",colSpan:4},
                {name: "down<%=i %>.originValue",title:"OriginValue",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'currencyFloat2', required: false, width: "100%",keyPressFilter: "[0-9.]",colSpan:1,
                    validators: [{type: "isFloat",validateOnExit: true,stopOnError: true,errorMessage: "<spring:message code='global.form.correctType'/>" }],
                    changed	: function(form, item, value){ sumdownConcentrateAndSet();	} },
                {name: "down<%=i %>.originValueCurrency",title:"Currency",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'text', required: false, width: "100%",colSpan:1,valueMap: dollar },
                {name: "down<%=i %>.conversionRate",title:"Rate2Invoice",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'currencyFloat5', required: false, width: "100%",keyPressFilter: "[0-9.]",colSpan:1,
                    validators: [{type: "isFloat",validateOnExit: true,stopOnError: true,errorMessage: "<spring:message code='global.form.correctType'/>" }],
                    changed	: function(form, item, value){ sumdownConcentrateAndSet();	} },
                 {name: "down<%=i %>.dateRate",title:"RateDate",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'text', useTextField:true, required: false, width: "100%",colSpan:1,mask:"####/##/##",
                       hint: "yyyy/mm/dd", showHintInField: true, blur: function(form, item){value=DynamicForm_Invoice_Concentrate.getValue("down<%=i %>.dateRate");if (value==null || typeof (value)=='undefined' || value=="" )	return; validatedate(value);}  },
                {name: "down<%=i %>.rateReference",title:"Refere",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'text', required: false, width: "100%",colSpan:1 },
                {name: "down<%=i %>.lessPlus",title:"+/-",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'text', required: false, width: "100%",colSpan:1,valueMap: {"PLUS":"PLUS","MINUS":"MINUS"},
                    changed	: function(form, item, value){ sumdownConcentrateAndSet();	} },
                {name: "down<%=i %>.targetValue",title:"Value",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'currencyFloat2Sign', required: false, width: "204",colSpan:2,canEdit:false },
   <% } %>
                {
                    name: "invoiceValue",
                    title: "<spring:message code='invoice.invoiceValue'/>",
                    type: 'currencyFloat2Sign',canEdit:false,
                    required: true,
                    width: "204",colSpan:2,titleColSpan:10,titleAlign:"right",
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
   DynamicForm_Invoice_Concentrate.clearValues();

		DynamicForm_Invoice_Concentrate.clearValues();
		DynamicForm_Invoice_Concentrate.setValue("treatCost",<%=treatCost %>);
		DynamicForm_Invoice_Concentrate.setValue("refinaryCostCU",<%=refinaryCost %>);
		DynamicForm_Invoice_Concentrate.setValue("refinaryCostCUCal",2204.62);
		DynamicForm_Invoice_Concentrate.setValue("refinaryCostAG",0.35);
		DynamicForm_Invoice_Concentrate.setValue("refinaryCostAU",5);
		DynamicForm_Invoice_Concentrate.setValue("copperIns",<%=copper %>);
		DynamicForm_Invoice_Concentrate.setValue("silverIns",<%=silver %>);
		DynamicForm_Invoice_Concentrate.setValue("goldIns",<%=gold %>);
 <% } else { %>
   DynamicForm_Invoice_Concentrate.editRecord(record);
		if (DynamicForm_Invoice_Concentrate.getValue("treatCost")==null )
			DynamicForm_Invoice_Concentrate.setValue("treatCost",<%=treatCost %>);
		if (DynamicForm_Invoice_Concentrate.getValue("refinaryCostCU")==null )
			DynamicForm_Invoice_Concentrate.setValue("refinaryCostCU",<%=refinaryCost %>);
		if (DynamicForm_Invoice_Concentrate.getValue("refinaryCostCUCal")==null )
			DynamicForm_Invoice_Concentrate.setValue("refinaryCostCUCal",2204.62);
		if (DynamicForm_Invoice_Concentrate.getValue("refinaryCostAG")==null )
			DynamicForm_Invoice_Concentrate.setValue("refinaryCostAG",0.35);
		if (DynamicForm_Invoice_Concentrate.getValue("refinaryCostAU")==null )
			DynamicForm_Invoice_Concentrate.setValue("refinaryCostAU",5);
		if (DynamicForm_Invoice_Concentrate.getValue("copperIns")==null )
			DynamicForm_Invoice_Concentrate.setValue("copperIns",<%=copper %>);
		if (DynamicForm_Invoice_Concentrate.getValue("silverIns")==null )
			DynamicForm_Invoice_Concentrate.setValue("silverIns",<%=silver %>);
		if (DynamicForm_Invoice_Concentrate.getValue("goldIns")==null )
			DynamicForm_Invoice_Concentrate.setValue("goldIns",<%=gold %>);
 <% } %>

    if (!(record == null || record.id == null))
       DynamicForm_Invoice_Concentrate.setValue("invoiceDateDumy", new Date(record.invoiceDate));
   DynamicForm_Invoice_Concentrate.setValue("refinaryCostCUCal",2204.62);
   var record = ListGrid_Shipment_InvoiceHeader.getSelectedRecord();
   DynamicForm_Invoice_Concentrate.setValue("shipmentId", record.id);

<%		loopUp=0;
		loopDown=0;
		for(InvoiceItemDTO.Info info : listItem)
		    if (info.getUpDown().equalsIgnoreCase("up")) { %>
		        DynamicForm_Invoice_Concentrate.setValue("up<%=loopUp %>.id" , <%=info.getId() %>);
		        DynamicForm_Invoice_Concentrate.setValue("up<%=loopUp %>.invoiceId" , <%=info.getInvoiceId() %>);
		        DynamicForm_Invoice_Concentrate.setValue("up<%=loopUp %>.version" , <%=info.getVersion() %>);
		        DynamicForm_Invoice_Concentrate.setValue("up<%=loopUp %>.upDown" , "<%=info.getUpDown() %>");
<%  	        if (info.getDescription()!=null) { %>
                   DynamicForm_Invoice_Concentrate.setValue("up<%=loopUp %>.description", "<%= info.getDescription() %>");
<%  	        } if (info.getOriginValue()!=null) { %>
                   DynamicForm_Invoice_Concentrate.setValue("up<%=loopUp %>.originValue", <%= info.getOriginValue() %>);
<%  	        } if (info.getOriginValueCurrency()!=null) { %>
                   DynamicForm_Invoice_Concentrate.setValue("up<%=loopUp %>.originValueCurrency", "<%= info.getOriginValueCurrency() %>");
<%  	        } if (info.getConversionRate()!=null) { %>
                   DynamicForm_Invoice_Concentrate.setValue("up<%=loopUp %>.conversionRate", <%= info.getConversionRate() %>);
<%  	        } if (info.getDateRate()!=null) { %>
                   DynamicForm_Invoice_Concentrate.setValue("up<%=loopUp %>.dateRate", "<%= info.getDateRate() %>");
<%  	        } if (info.getRateReference()!=null) { %>
                   DynamicForm_Invoice_Concentrate.setValue("up<%=loopUp %>.rateReference", "<%= info.getRateReference() %>");
<%  	        } if (info.getLessPlus()!=null) { %>
                   DynamicForm_Invoice_Concentrate.setValue("up<%=loopUp %>.lessPlus", "<%= info.getLessPlus() %>");
<%  	        } if (info.getTargetValue()!=null) { %>
                   DynamicForm_Invoice_Concentrate.setValue("up<%=loopUp %>.targetValue", <%= info.getTargetValue() %>);
               <% }
               loopUp++;
               }
		    else { %>
		        DynamicForm_Invoice_Concentrate.setValue("down<%=loopDown %>.id" , <%=info.getId() %>);
		        DynamicForm_Invoice_Concentrate.setValue("down<%=loopDown %>.invoiceId" , <%=info.getInvoiceId() %>);
		        DynamicForm_Invoice_Concentrate.setValue("down<%=loopDown %>.version" , <%=info.getVersion() %>);
		        DynamicForm_Invoice_Concentrate.setValue("down<%=loopDown %>.downDown" , "<%=info.getUpDown() %>");
<%  	        if (info.getDescription()!=null) { %>
                   DynamicForm_Invoice_Concentrate.setValue("down<%=loopDown %>.description", "<%= info.getDescription() %>");
<%  	        }if (info.getOriginValue()!=null) { %>
                   DynamicForm_Invoice_Concentrate.setValue("down<%=loopDown %>.originValue", <%= info.getOriginValue() %>);
<%  	        }if (info.getOriginValueCurrency()!=null) { %>
                   DynamicForm_Invoice_Concentrate.setValue("down<%=loopDown %>.originValueCurrency", "<%= info.getOriginValueCurrency() %>");
<%  	        }if (info.getConversionRate()!=null) { %>
                   DynamicForm_Invoice_Concentrate.setValue("down<%=loopDown %>.conversionRate", <%= info.getConversionRate() %>);
<%  	        }if (info.getDateRate()!=null) { %>
                   DynamicForm_Invoice_Concentrate.setValue("down<%=loopDown %>.dateRate", "<%= info.getDateRate() %>");
<%  	        }if (info.getRateReference()!=null) { %>
                   DynamicForm_Invoice_Concentrate.setValue("down<%=loopDown %>.rateReference", "<%= info.getRateReference() %>");
<%  	        }if (info.getLessPlus()!=null) { %>
                   DynamicForm_Invoice_Concentrate.setValue("down<%=loopDown %>.lessPlus", "<%= info.getLessPlus() %>");
<%  	        }if (info.getTargetValue()!=null) { %>
                   DynamicForm_Invoice_Concentrate.setValue("down<%=loopDown %>.targetValue", <%= info.getTargetValue() %>);
               <% }
                loopDown++;
            }
     %>
     var IButton_Invoice_Concentrate_Save = isc.IButtonSave.create({
        top: 260,
        title: "<spring:message code='global.form.save'/>",
        icon: "pieces/16/save.png",
        click: function () {
            /*ValuesManager_GoodsUnit.validate();*/
            DynamicForm_Invoice_Concentrate.validate();
            if (DynamicForm_Invoice_Concentrate.hasErrors())
                return;
            var drs = DynamicForm_Invoice_Concentrate.getValue("invoiceDateDumy");
            var datestringRs = (drs.getFullYear() + "/" + ("0" + (drs.getMonth() + 1)).slice(-2) + "/" + ("0" + drs.getDate()).slice(-2));
            DynamicForm_Invoice_Concentrate.setValue("invoiceDate", datestringRs);
            DynamicForm_Invoice_Concentrate.setValue("shipmentId", ListGrid_Shipment_InvoiceHeader.getSelectedRecord().id);

            var data = DynamicForm_Invoice_Concentrate.getValues();
            var up=[];
          <%	for (int i=0;i<(loopUp==0 ? 3 : loopUp+2 );i++){ %>
                if ( data.up<%=i %>.description!=null || data.up<%=i %>.originValue!=null || data.up<%=i %>.conversionRate!=null || data.up<%=i %>.rateReference!=null  ){
                    data.up<%=i %>.targetValueCurrency="USD";
                    data.up<%=i %>.upDown="up";
                    data.up<%=i %>.invoiceId=<%=invoiceId %>;
                    if (data.up<%=i %>.lessPlus==null || data.up<%=i %>.lessPlus=="" ) {
                    	isc.warn("less or Plus  Required  (up<%=i %>)", {title:"<spring:message code='dialog_WarnTitle'/>"});
                    	return;
                    }
                    if (data.up<%=i %>.description==null || data.up<%=i %>.description=="" ) {
                    	isc.warn("description  Required  (up<%=i %>)", {title:"<spring:message code='dialog_WarnTitle'/>"});
                    	return;
                    }
                    if (data.up<%=i %>.originValue==null || data.up<%=i %>.originValue<=0 ) {
                    	isc.warn("Origin Value  Required  (up<%=i %>)", {title:"<spring:message code='dialog_WarnTitle'/>"});
                    	return;
                    }
                    if (data.up<%=i %>.originValueCurrency==null || data.up<%=i %>.originValueCurrency=="" ) {
                        data.up<%=i %>.originValueCurrency='USD';
                    	<%--// isc.warn("Origin Value Currency  Required", {"<spring:message code='dialog_WarnTitle'/>"});--%>
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
                    	<%--// isc.warn("Origin Value Currency  Required", {title:"<spring:message code='dialog_WarnTitle'/>"});--%>
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
                    	<%--isc.warn("less or Plus  Required", {title:"<spring:message code='dialog_WarnTitle'/>"});--%>
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
                    if (resp.httpResponseCode === 200 || resp.httpResponseCode === 201) {
                        isc.say("<spring:message code='global.form.request.successful'/>");
                        ListGrid_Invoice_refresh();
                        Window_Invoice_Concentrate.close();
                    } else
                        isc.say(RpcResponse_o.data);
                }
            }));
        }
    });
    var VLayout_Invoice_Concentrate_Body = isc.VLayout.create({
        width: "100%",
        height: "100%",
        showScrollbar: true,
        overflow :'hidden', //Fix bug (Width)
                // autoSize: true,

        members: [
                DynamicForm_Invoice_Concentrate,
                isc.HLayout.create({
                    width: 1600, align: "center", height: "20px", //
                    members:
                        [
                            IButton_Invoice_Concentrate_Save,
                            isc.Label.create({
                                width: 5,
                            }),
                            isc.IButtonCancel.create({
                                title: "<spring:message code='global.cancel'/>",
                                width: 100,
                                icon: "pieces/16/icon_delete.png",
                                orientation: "vertical",
                                click: function () {
                                    Window_Invoice_Concentrate.close();
                                }
                            })
                        ]
                })
       ]
    });

