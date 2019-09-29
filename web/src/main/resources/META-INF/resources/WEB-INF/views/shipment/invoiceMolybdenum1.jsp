<%@ page import="com.nicico.copper.common.dto.grid.GridResponse" %>
<%@ page import="com.nicico.copper.common.util.date.DateUtil" %>
<%@ page import="com.nicico.sales.dto.InvoiceItemDTO" %>
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
		int loop=(list==null ? 4 : list.size()+2);

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
    var loop=<%=loop %>;
    <spring:eval var="contextPath" expression="pageContext.servletContext.contextPath" />

     var DynamicForm_Invoice_Molybdenum ;
	function hasValue(fld){
	 // return isc.isA.Number(DynamicForm_Invoice_Molybdenum.getValue(fld));
	 valueTmp=DynamicForm_Invoice_Molybdenum.getValue(fld);
	 return !(valueTmp==null || typeof (valueTmp)=='undefined' || valueTmp=="" );
	}
    function sumMolybdenumAndSet(value00,fld00,sumfld00,ii00,precise){
        if (ii00 > -1)
           DynamicForm_Invoice_Molybdenum.setValue("mo"+ii00+"."+fld00,precise_round(value00, precise));
       else {
           DynamicForm_Invoice_Molybdenum.setValue(fld00,precise_round(value00, precise));
           }
    	gr=0;
       	if (fld00=='grass'){
			for (i=0;i<loop;i++)
          		gr+=DynamicForm_Invoice_Molybdenum_getValue("mo"+i+".grass");
          	DynamicForm_Invoice_Molybdenum.setValue('grass',gr)	;
          	return;
       }
       nt=0;moCnt=0;am=0;
       for (i=0;i<loop;i++) {
          nt+=DynamicForm_Invoice_Molybdenum_getValue("mo"+i+".net");
          DynamicForm_Invoice_Molybdenum.setValue("mo"+i+".molybdenumContent",
          		precise_round(DynamicForm_Invoice_Molybdenum_getValue("mo"+i+".molybdenumPercent")*DynamicForm_Invoice_Molybdenum_getValue("mo"+i+".net")/100,3));
          DynamicForm_Invoice_Molybdenum.setValue("mo"+i+".priceFee",
          		precise_round(DynamicForm_Invoice_Molybdenum_getValue('molybdJenumUnitPrice')*(1-DynamicForm_Invoice_Molybdenum_getValue("mo"+i+".discountPercent")/100),5));
          DynamicForm_Invoice_Molybdenum.setValue("mo"+i+".price",
          		precise_round(DynamicForm_Invoice_Molybdenum_getValue("mo"+i+".priceFee")*(DynamicForm_Invoice_Molybdenum_getValue("mo"+i+".molybdenumContent")*2.20462),2));
          am+=DynamicForm_Invoice_Molybdenum_getValue("mo"+i+".price");
          moCnt+=DynamicForm_Invoice_Molybdenum_getValue("mo"+i+".molybdenumContent");
       }
       DynamicForm_Invoice_Molybdenum.setValue('net',nt)	;
       DynamicForm_Invoice_Molybdenum.setValue('molybdenumContent',moCnt)	;
       DynamicForm_Invoice_Molybdenum_setValue('commercialInvoceValue',am,2)	; // calling to compute invoice
	}
	function precise_round(value, dec){
    	// return isc.isA.Number(value) ? value.toFixed(dec) : value;
    	console.log('precise_round(value='+value)
        if ((typeof value !== 'number') || (typeof dec !== 'number'))
            return 0;
        return   value.toFixed(dec);
        // var num_sign = num >= 0 ? 1 : -1;
        // return (Math.round((num*Math.pow(10,dec))+(num_sign*0.0001))/Math.pow(10,dec)).toFixed(dec);
    }

    function sumUpMolybdenumAndSet(){
       sumUp=0;
       for (i=0;i< <%= (loopUp==0 ? 3 : loopUp+2 ) %>;i++) {
          nt=0;
          if (DynamicForm_Invoice_Molybdenum_getValue("up"+i+".lessPlus")=="PLUS") nt=1;
          else if (DynamicForm_Invoice_Molybdenum_getValue("up"+i+".lessPlus")=="MINUS") nt=-1;
            DynamicForm_Invoice_Molybdenum.setValue("up"+i+".targetValue",
                    precise_round(DynamicForm_Invoice_Molybdenum_getValue("up"+i+".conversionRate")*DynamicForm_Invoice_Molybdenum_getValue("up"+i+".originValue")*nt,2));
            sumUp+=  DynamicForm_Invoice_Molybdenum_getValue("up"+i+".targetValue");
       }
        DynamicForm_Invoice_Molybdenum_setValue('invoiceValueD',DynamicForm_Invoice_Molybdenum_getValue("commercialInvoceValueNet")+sumUp,2)	; // calling to compute invoice
	}
    function sumdownMolybdenumAndSet(){
       sumUp=0;
       for (i=0;i< <%= (loopUp==0 ? 3 : loopUp+2 ) %>;i++) {
          nt=0;
          if (DynamicForm_Invoice_Molybdenum_getValue("down"+i+".lessPlus")=="PLUS") nt=1;
          else if (DynamicForm_Invoice_Molybdenum_getValue("down"+i+".lessPlus")=="MINUS") nt=-1;
            DynamicForm_Invoice_Molybdenum.setValue("down"+i+".targetValue",
                    precise_round(DynamicForm_Invoice_Molybdenum_getValue("down"+i+".conversionRate")*DynamicForm_Invoice_Molybdenum_getValue("down"+i+".originValue")*nt,2));
            sumUp+=  DynamicForm_Invoice_Molybdenum_getValue("down"+i+".targetValue");
       }
        DynamicForm_Invoice_Molybdenum_setValue('invoiceValue',DynamicForm_Invoice_Molybdenum_getValue("invoiceValueUp")+sumUp,2)	; // calling to compute invoice
	}
    function multiplyMolybdenum (fld1,value) {
		if (value==null || typeof (value)=='undefined' || fld1==null || typeof (fld1) =='undefined')
		   return 0;
		return fld1 * value;
	}
	function multiplyMolybdenumAndSet (name1,name2,setName0,pers) {
	  val1=DynamicForm_Invoice_Molybdenum.getValue(name1);
	  val2=DynamicForm_Invoice_Molybdenum.getValue(name2);
	  m=multiplyMolybdenum(val1,val2)/((name1=="paidPercent" || name2=="paidPercent") ? 100 : 1);
	  DynamicForm_Invoice_Molybdenum_setValue(setName0,m,pers);
	}
	function DynamicForm_Invoice_Molybdenum_getValue(fld){
	 valueTmp=DynamicForm_Invoice_Molybdenum.getValue(fld);
     return isc.isA.Number(valueTmp) ? valueTmp : 0;
//	  return (valueTmp==null || typeof (valueTmp)=='undefined' || valueTmp=="" ) ? 0 : valueTmp;
	}
	function DynamicForm_Invoice_Molybdenum_setValue(fld,value,pers){
		DynamicForm_Invoice_Molybdenum.setValue(fld,precise_round(value,pers));

// commercialInvoceValueNet=paidPercent*commercialInvoceValue
		if ((fld=="paidPercent" || fld=='commercialInvoceValue' ) && (hasValue("paidPercent") && hasValue('commercialInvoceValue') ))
			multiplyMolybdenumAndSet("paidPercent",'commercialInvoceValue',"commercialInvoceValueNet",2);

// commercialInvoceValueNet sumUpMolybdenumAndSet
		if (fld=="commercialInvoceValueNet"  )
		   sumUpMolybdenumAndSet() ;
// invoiceValue=rate2dollar*invoiceValueD
		if ((fld=="rate2dollar" || fld=='invoiceValueD' ) && (hasValue("rate2dollar") && hasValue('invoiceValueD') )){
			multiplyMolybdenumAndSet("rate2dollar",'invoiceValueD',"invoiceValueUp",2);
		}
		if ((fld=="invoiceValueUp" ) && ( hasValue('invoiceValueUp') )){
            sumdownMolybdenumAndSet() ;
		}

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
        titleWidth: "100", margin: '0px', wrapTitle: true,
        titleAlign: "center",
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
                    wrapTitle: false,colSpan:2,titleColSpan:2
                },
                {
                    name: "invoiceDateDumy",
                    title: "<spring:message code='invoice.invoiceDate'/>",
                    defaultValue: "<%=dateUtil.todayDate()%>",
                    type: 'date',// useTextField:true,
                    format: 'YYYY-MM-DD',
                    required: true,
                    width: "100%",colSpan:3,titleColSpan:1
                },
                  {
                    name: "priceBase",
                    title: "<spring:message code='invoice.priceBase'/>",
                    type: 'text',
                    required: true,
                    width: "100%",colSpan:8,titleColSpan:1,
                },
                {name: "molybdJenumUnitPrice", title: "MO/Oz USD",type: 'float', required: true, width: "100%",keyPressFilter: "[0-9.]",colSpan:2,mask:"####c##",editorType: "TextItem",
                    validators: [{type: "isFloat",validateOnExit: true,stopOnError: true,errorMessage: "<spring:message code='global.form.correctType'/>" }],
                    blur	: function(form, item){ value=DynamicForm_Invoice_Molybdenum.getValue("molybdJenumUnitPrice");sumMolybdenumAndSet(value,"molybdJenumUnitPrice","none",-1,3);	} },
              // {
              //       type: "Header",
              //       defaultValue: " - - - LotNo. - - - - - - - Grass- - - - - - - - - - - -Net - - - - - - -  - MO%- - - - CU%- MolybdenumContent- Discount%- - -  Fee - - - - -  Price"
              //   },
<%		for (int i=0;i<loop;i++){ %>
                {name: "mo<%=i %>.id", hidden: true},
                {name: "mo<%=i %>.invoiceId", hidden: true},
                {name: "mo<%=i %>.version", hidden: true},
                {name: "mo<%=i %>.lotNo",title:"lotNo",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'text', required: false, width: "100%"},
                {name: "mo<%=i %>.grass",title:"Grass Weight",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'float', required: false, width: "100%",keyPressFilter: "[0-9.]",colSpan:2,
                    validators: [{type: "isFloat",validateOnExit: true,stopOnError: true,errorMessage: "<spring:message code='global.form.correctType'/>" }],
                    changed	: function(form, item, value){ sumMolybdenumAndSet(value,"grass","grass",<%=i %>,3);	} },
                {name: "mo<%=i %>.net",title:"Net Wet Weight",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'float', required: false, width: "100%",keyPressFilter: "[0-9.]",colSpan:2,
                    validators: [{type: "isFloat",validateOnExit: true,stopOnError: true,errorMessage: "<spring:message code='global.form.correctType'/>" }],
                    changed	: function(form, item, value){ sumMolybdenumAndSet(value,"net","net",<%=i %>,3);	} },
                {name: "mo<%=i %>.molybdenumPercent",title:"MO%",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'float', required: false, width: "100%",keyPressFilter: "[0-9.]",
                    validators: [{type: "isFloat",validateOnExit: true,stopOnError: true,errorMessage: "<spring:message code='global.form.correctType'/>" }] ,
                    changed	: function(form, item, value){ sumMolybdenumAndSet(value,"molybdenumPercent","none",<%=i %>,2);	} },
                {name: "mo<%=i %>.copperPercent",title:"CU%",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'float', required: false, width: "100%",keyPressFilter: "[0-9.]",
                    validators: [{type: "isFloat",validateOnExit: true,stopOnError: true,errorMessage: "<spring:message code='global.form.correctType'/>" }]} ,
                {name: "mo<%=i %>.molybdenumContent",title:"MO content",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'float', required: false, width: "100%",canEdit:false},
                {name: "mo<%=i %>.discountPercent",title:"Discount%",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'float', required: false, width: "100%",keyPressFilter: "[0-9.]",
                    validators: [{type: "isFloat",validateOnExit: true,stopOnError: true,errorMessage: "<spring:message code='global.form.correctType'/>" }] ,
                    changed	: function(form, item, value){ sumMolybdenumAndSet(value,"discountPercent","none",<%=i %>,2);	} },
                {name: "mo<%=i %>.priceFee",title:"USD/OZ",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'float', required: false, width: "100%",canEdit:false, },
                {name: "mo<%=i %>.price",title:"Price  USD",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'float', required: false, width: "100%",keyPressFilter: "[0-9.]",colSpan:2,canEdit:false },
 <% } %>
                {
                    type: "Header",
                    defaultValue: " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
                },
                {name: "lotNo",defaultValue:"Total:", showTitle: false,type: 'text', required: false, width: "100%",canEdit:false,},
                {name: "grass", showTitle: false,type: 'float', required: false, width: "100%",keyPressFilter: "[0-9.]",colSpan:2,canEdit:false,
                    validators: [{type: "isFloat",validateOnExit: true,stopOnError: true,errorMessage: "<spring:message code='global.form.correctType'/>" }] },
                {name: "net", showTitle: false,type: 'float', required: false, width: "100%",colSpan:2,canEdit:false,
                    validators: [{type: "isFloat",validateOnExit: true,stopOnError: true,errorMessage: "<spring:message code='global.form.correctType'/>" }] },
                {name: "tmpmolybdenumPercent", showTitle: false,type: 'text', required: false, width: "100%",defaultValue:"--",canEdit:false },
                {name: "tmpcopperPercent", showTitle: false,type: 'text', required: false, width: "100%",defaultValue:"--",canEdit:false },
                {name: "molybdenumContent", showTitle: false,type: 'float', required: false, width: "100%",colSpan:1,canEdit:false },
                <%--{name: "discountPercent<%=i %>", showTitle: false,type: 'float', required: false, width: "100%",keyPressFilter: "[0-9.]",--%>
                    <%--validators: [{type: "isFloat",validateOnExit: true,stopOnError: true,errorMessage: "<spring:message code='global.form.correctType'/>" }] },--%>
                {name: "tmppriceFee", showTitle: false,type: 'text', required: false, width: "100%",defaultValue:"--",canEdit:false,colSpan:2},
                {name: "commercialInvoceValue", showTitle: false,type: 'float', required: false, width: "100%",keyPressFilter: "[0-9.]",colSpan:2,canEdit:false,align:"right" },
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
		   			  	multiplyMolybdenumAndSet("paidPercent","commercialInvoceValue","commercialInvoceValueNet",2);
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
   <%		for (int i=0;i<(loopUp==0 ? 3 : loopUp+2 );i++){ %>
                {name: "up<%=i %>.id", hidden: true},
                {name: "up<%=i %>.invoiceId",defaultValue:<%=invoiceId %> , hidden: true},
                {name: "up<%=i %>.version", hidden: true},
                {name: "up<%=i %>.targetValueCurrency",defaultValue:"USD" , hidden: true},
                {name: "up<%=i %>.upDown",defaultValue:"up", hidden: true},
                {name: "up<%=i %>.description",title:"Description", <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %> ,type : 'text', required: false, width: "100%",colSpan:4},
                {name: "up<%=i %>.originValue",title:"OriginValue",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'float', required: false, width: "100%",keyPressFilter: "[0-9.]",colSpan:1,
                    validators: [{type: "isFloat",validateOnExit: true,stopOnError: true,errorMessage: "<spring:message code='global.form.correctType'/>" }],
                    changed	: function(form, item, value){ sumUpMolybdenumAndSet();	} },
                {name: "up<%=i %>.originValueCurrency",title:"Currency",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'text', required: false, width: "100%",colSpan:1,valueMap: dollar },
                {name: "up<%=i %>.conversionRate",title:"Rate 2 USD",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'float', required: false, width: "100%",keyPressFilter: "[0-9.]",colSpan:1,
                    validators: [{type: "isFloat",validateOnExit: true,stopOnError: true,errorMessage: "<spring:message code='global.form.correctType'/>" }],
                    changed	: function(form, item, value){ sumUpMolybdenumAndSet();	} },
                {name: "up<%=i %>.dateRate",title:"RateDate",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'date', useTextField:true, required: false, width: "100%",colSpan:1 },
                {name: "up<%=i %>.rateReference",title:"Refere",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'text', required: false, width: "100%",colSpan:1 },
                {name: "up<%=i %>.lessPlus",title:"+/-",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'text', required: false, width: "100%",colSpan:1,valueMap: {"PLUS":"PLUS","MINUS":"MINUS"} ,
                    changed	: function(form, item, value){ sumUpMolybdenumAndSet();	} },
                {name: "up<%=i %>.targetValue",title:"Value",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'float', required: false, width: "100%",colSpan:2,canEdit:false },
   <% } %>
                {
                    name: "invoiceValueD", title: "<spring:message code='invoice.invoiceValueD'/>",
                    type: 'float', required: true, width: "100%",colSpan:2,titleColSpan:10,titleAlign:"right",canEdit:false,
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
		   			  	multiplyMolybdenumAndSet("rate2dollar",'invoiceValueD',"invoiceValueUp",2);

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
   <%		for (int i=0;i<(loopDown==0 ? 3 : loopDown+2 );i++){ %>
                {name: "down<%=i %>.id", hidden: true},
                {name: "down<%=i %>.invoiceId",defaultValue:<%=invoiceId %> ,hidden: true},
                {name: "down<%=i %>.version", hidden: true},
                {name: "down<%=i %>.upDown",defaultValue:"down", hidden: true},
                {name: "down<%=i %>.description",title:"Description", <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %> ,type : 'text', required: false, width: "100%",colSpan:4},
                {name: "down<%=i %>.originValue",title:"OriginValue",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'float', required: false, width: "100%",keyPressFilter: "[0-9.]",colSpan:1,
                    validators: [{type: "isFloat",validateOnExit: true,stopOnError: true,errorMessage: "<spring:message code='global.form.correctType'/>" }],
                    changed	: function(form, item, value){ sumdownMolybdenumAndSet();	} },
                {name: "down<%=i %>.originValueCurrency",title:"Currency",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'text', required: false, width: "100%",colSpan:1,valueMap: dollar },
                {name: "down<%=i %>.conversionRate",title:"Rate2Invoice",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'float', required: false, width: "100%",keyPressFilter: "[0-9.]",colSpan:1,
                    validators: [{type: "isFloat",validateOnExit: true,stopOnError: true,errorMessage: "<spring:message code='global.form.correctType'/>" }],
                    changed	: function(form, item, value){ sumdownMolybdenumAndSet();	} },
                {name: "down<%=i %>.dateRate",title:"RateDate",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'date', useTextField:true, required: false, width: "100%",colSpan:1 },
                {name: "down<%=i %>.rateReference",title:"Refere",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'text', required: false, width: "100%",colSpan:1 },
                {name: "down<%=i %>.lessPlus",title:"+/-",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'text', required: false, width: "100%",colSpan:1,valueMap: {"PLUS":"PLUS","MINUS":"MINUS"},
                    changed	: function(form, item, value){ sumdownMolybdenumAndSet();	} },
                {name: "down<%=i %>.targetValue",title:"Value",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'float', required: false, width: "100%",colSpan:2,canEdit:false },
   <% } %>
                {
                    name: "invoiceValue",
                    title: "<spring:message code='invoice.invoiceValue'/>",
                    type: 'float',canEdit:false,
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
   DynamicForm_Invoice_Molybdenum.clearValues();
 <% } else { %>
   DynamicForm_Invoice_Molybdenum.editRecord(record);
 <% } %>

    if (!(record == null || record.id == null))
       DynamicForm_Invoice_Molybdenum.setValue("invoiceDateDumy", new Date(record.invoiceDate));

   var record = ListGrid_Shipment_InvoiceHeader.getSelectedRecord();
   DynamicForm_Invoice_Molybdenum.setValue("shipmentId", record.id);
<%		for (int i=0;i<loop;i++){ %>
               DynamicForm_Invoice_Molybdenum.setValue("mo<%=i %>.invoiceId", <%= invoiceId %>);
            <% if (i < list.size()) {
                  if (list.get(i).getId()!=null) { %>
               DynamicForm_Invoice_Molybdenum.setValue("mo<%=i %>.id", <%=list.get(i).getId() %>);
               DynamicForm_Invoice_Molybdenum.setValue("mo<%=i %>.version", <%= list.get(i).getVersion() %>);
               <% }
                  if (list.get(i).getLotNo()!=null) { %>
               DynamicForm_Invoice_Molybdenum.setValue("mo<%=i %>.lotNo", "<%= list.get(i).getLotNo() %>");
               <% }
                  if (list.get(i).getGrass()!=null) { %>
               DynamicForm_Invoice_Molybdenum.setValue("mo<%=i %>.grass", <%= list.get(i).getGrass() %>);
               <% }
                  if (list.get(i).getNet()!=null) { %>
               DynamicForm_Invoice_Molybdenum.setValue("mo<%=i %>.net", <%= list.get(i).getNet() %>);
               <% }
                  if (list.get(i).getMolybdenumPercent()!=null) { %>
               DynamicForm_Invoice_Molybdenum.setValue("mo<%=i %>.molybdenumPercent", <%= list.get(i).getMolybdenumPercent() %>);
               <% }
                  if (list.get(i).getCopperPercent()!=null) { %>
               DynamicForm_Invoice_Molybdenum.setValue("mo<%=i %>.copperPercent", <%= list.get(i).getCopperPercent() %>);
               <% }
                  if (list.get(i).getMolybdenumContent()!=null) { %>
               DynamicForm_Invoice_Molybdenum.setValue("mo<%=i %>.molybdenumContent", <%= list.get(i).getMolybdenumContent() %>);
               <% }
                  if (list.get(i).getDiscountPercent()!=null) { %>
               DynamicForm_Invoice_Molybdenum.setValue("mo<%=i %>.discountPercent", <%= list.get(i).getDiscountPercent() %>);
               <% }
                  if (list.get(i).getPriceFee()!=null) { %>
               DynamicForm_Invoice_Molybdenum.setValue("mo<%=i %>.priceFee", <%= list.get(i).getPriceFee() %>);
               <% }
                  if (list.get(i).getPrice()!=null) { %>
               DynamicForm_Invoice_Molybdenum.setValue("mo<%=i %>.price", <%= list.get(i).getPrice() %>);
 			<% }
 			}
        }
		loopUp=0;
		loopDown=0;
		for(int i=0;i<listItem.size();i++)
		    if (listItem.get(i).getUpDown().equalsIgnoreCase("up")) { %>
		        DynamicForm_Invoice_Molybdenum.setValue("up<%=loopUp %>.id" , <%=listItem.get(loopUp).getId() %>);
		        DynamicForm_Invoice_Molybdenum.setValue("up<%=loopUp %>.invoiceId" , <%=listItem.get(loopUp).getInvoiceId() %>);
		        DynamicForm_Invoice_Molybdenum.setValue("up<%=loopUp %>.version" , <%=listItem.get(loopUp).getVersion() %>);
		        DynamicForm_Invoice_Molybdenum.setValue("up<%=loopUp %>.upDown" , "<%=listItem.get(loopUp).getUpDown() %>");
<%  	        if (listItem.get(loopUp).getDescription()!=null) { %>
                   DynamicForm_Invoice_Molybdenum.setValue("up<%=loopUp %>.description", "<%= listItem.get(loopUp).getDescription() %>");
<%  	        } if (listItem.get(loopUp).getOriginValue()!=null) { %>
                   DynamicForm_Invoice_Molybdenum.setValue("up<%=loopUp %>.originValue", <%= listItem.get(loopUp).getOriginValue() %>);
<%  	        } if (listItem.get(loopUp).getOriginValueCurrency()!=null) { %>
                   DynamicForm_Invoice_Molybdenum.setValue("up<%=loopUp %>.originValueCurrency", "<%= listItem.get(loopUp).getOriginValueCurrency() %>");
<%  	        } if (listItem.get(loopUp).getConversionRate()!=null) { %>
                   DynamicForm_Invoice_Molybdenum.setValue("up<%=loopUp %>.conversionRate", <%= listItem.get(loopUp).getConversionRate() %>);
<%  	        } if (listItem.get(loopUp).getDateRate()!=null) { %>
                   DynamicForm_Invoice_Molybdenum.setValue("up<%=loopUp %>.dateRate", "<%= listItem.get(loopUp).getDateRate() %>");
<%  	        } if (listItem.get(loopUp).getRateReference()!=null) { %>
                   DynamicForm_Invoice_Molybdenum.setValue("up<%=loopUp %>.rateReference", "<%= listItem.get(loopUp).getRateReference() %>");
<%  	        } if (listItem.get(loopUp).getLessPlus()!=null) { %>
                   DynamicForm_Invoice_Molybdenum.setValue("up<%=loopUp %>.lessPlus", "<%= listItem.get(loopUp).getLessPlus() %>");
<%  	        } if (listItem.get(loopUp).getTargetValue()!=null) { %>
                   DynamicForm_Invoice_Molybdenum.setValue("up<%=loopUp %>.targetValue", <%= listItem.get(loopUp).getTargetValue() %>);
               <% }
               loopUp++;
               }
		    else { %>
		        DynamicForm_Invoice_Molybdenum.setValue("down<%=loopDown %>.id" , <%=listItem.get(loopUp).getId() %>);
		        DynamicForm_Invoice_Molybdenum.setValue("down<%=loopDown %>.invoiceId" , <%=listItem.get(loopUp).getInvoiceId() %>);
		        DynamicForm_Invoice_Molybdenum.setValue("down<%=loopDown %>.version" , <%=listItem.get(loopUp).getVersion() %>);
		        DynamicForm_Invoice_Molybdenum.setValue("down<%=loopDown %>.downDown" , "<%=listItem.get(loopUp).getUpDown() %>");
<%  	        if (listItem.get(loopUp).getDescription()!=null) { %>
                   DynamicForm_Invoice_Molybdenum.setValue("down<%=loopDown %>.description", "<%= listItem.get(loopUp).getDescription() %>");
<%  	        }if (listItem.get(loopUp).getOriginValue()!=null) { %>
                   DynamicForm_Invoice_Molybdenum.setValue("down<%=loopDown %>.originValue", <%= listItem.get(loopUp).getOriginValue() %>);
<%  	        }if (listItem.get(loopUp).getOriginValueCurrency()!=null) { %>
                   DynamicForm_Invoice_Molybdenum.setValue("down<%=loopDown %>.originValueCurrency", "<%= listItem.get(loopUp).getOriginValueCurrency() %>");
<%  	        }if (listItem.get(loopUp).getConversionRate()!=null) { %>
                   DynamicForm_Invoice_Molybdenum.setValue("down<%=loopDown %>.conversionRate", <%= listItem.get(loopUp).getConversionRate() %>);
<%  	        }if (listItem.get(loopUp).getDateRate()!=null) { %>
                   DynamicForm_Invoice_Molybdenum.setValue("down<%=loopDown %>.dateRate", "<%= listItem.get(loopUp).getDateRate() %>");
<%  	        }if (listItem.get(loopUp).getRateReference()!=null) { %>
                   DynamicForm_Invoice_Molybdenum.setValue("down<%=loopDown %>.rateReference", "<%= listItem.get(loopUp).getRateReference() %>");
<%  	        }if (listItem.get(loopUp).getLessPlus()!=null) { %>
                   DynamicForm_Invoice_Molybdenum.setValue("down<%=loopDown %>.lessPlus", "<%= listItem.get(loopUp).getLessPlus() %>");
<%  	        }if (listItem.get(loopUp).getTargetValue()!=null) { %>
                   DynamicForm_Invoice_Molybdenum.setValue("down<%=loopDown %>.targetValue", <%= listItem.get(loopUp).getTargetValue() %>);
               <% }
                loopDown++;
            }
     %>
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
            var mo=[];
            <%	for (int i=0;i<loop;i++){ %>
                if (data.mo<%=i %>.lotNo!=null || data.mo<%=i %>.net!=null || data.mo<%=i %>.grass!=null || data.mo<%=i %>.molybdenumPercent!=null  ){
                    if (data.mo<%=i %>.lotNo==null || data.mo<%=i %>.lotNo=="" ) {
                    	isc.warn("Lot Number Required", {title: 'هشدار'});
                    	return;
                    }
                    if (data.mo<%=i %>.net==null || data.mo<%=i %>.net<=0 ) {
                    	isc.warn("Net Weight Required", {title: 'هشدار'});
                    	return;
                    }
                    if (data.mo<%=i %>.grass==null || data.mo<%=i %>.grass<=0 ) {
                    	isc.warn("Grass Weight Required", {title: 'هشدار'});
                    	return;
                    }
                    if (data.mo<%=i %>.molybdenumPercent==null || data.mo<%=i %>.molybdenumPercent<=0 ) {
                    	isc.warn("Molybdenum Percent Required", {title: 'هشدار'});
                    	return;
                    }
                    if (data.mo<%=i %>.copperPercent==null || data.mo<%=i %>.copperPercent<=0 ) {
                    	isc.warn("Copper Percent Required", {title: 'هشدار'});
                    	return;
                    }
                    mo.add(data.mo<%=i %>);
                }
                // data.mo<%=i %>='';
             <% } %>
            var up=[];
          <%	for (int i=0;i<(loopUp==0 ? 3 : loopUp+2 );i++){ %>
                if ( data.up<%=i %>.description!=null || data.up<%=i %>.originValue!=null || data.up<%=i %>.conversionRate!=null || data.up<%=i %>.rateReference!=null  ){
                    data.up<%=i %>.targetValueCurrency="USD";
                    data.up<%=i %>.upDown="up";
                    data.up<%=i %>.invoiceId=<%=invoiceId %>;
                    if (data.up<%=i %>.lessPlus==null || data.up<%=i %>.lessPlus=="" ) {
                    	isc.warn("less or Plus  Required", {title: 'هشدار'});
                    	return;
                    }
                    if (data.up<%=i %>.description==null || data.up<%=i %>.description=="" ) {
                    	isc.warn("description  Required", {title: 'هشدار'});
                    	return;
                    }
                    if (data.up<%=i %>.originValue==null || data.up<%=i %>.originValue<=0 ) {
                    	isc.warn("Origin Value  Required", {title: 'هشدار'});
                    	return;
                    }
                    if (data.up<%=i %>.originValueCurrency==null || data.up<%=i %>.originValueCurrency=="" ) {
                    	isc.warn("Origin Value Currency  Required", {title: 'هشدار'});
                    	return;
                    }
                    if (data.up<%=i %>.conversionRate==null || data.up<%=i %>.conversionRate<=0 ) {
                    	isc.warn("conversionRate  Required", {title: 'هشدار'});
                    	return;
                    }
                    <%--if (data.up<%=i %>.dateRate==null || data.up<%=i %>.dateRate=="" ) {--%>
                    	<%--isc.warn("Date Rate  Required", {title: 'هشدار'});--%>
                    	<%--return;--%>
                    <%--}--%>
                    if (data.up<%=i %>.lessPlus==null || data.up<%=i %>.lessPlus=="" ) {
                    	isc.warn("less or Plus  Required", {title: 'هشدار'});
                    	return;
                    }
                    if (data.up<%=i %>.rateReference==null || data.up<%=i %>.rateReference=="" ) {
                    	isc.warn("Rate Reference  Required", {title: 'هشدار'});
                    	return;
                    }
                    up.add(data.up<%=i %>);
                }
                // data.up<%=i %> ='';
          <% } %>
            var down=[];
            <%	for (int i=0;i<(loopDown==0 ? 3 : loopUp+2 );i++){ %>
                if ( data.down<%=i %>.description!=null || data.down<%=i %>.originValue!=null || data.down<%=i %>.conversionRate!=null || data.down<%=i %>.rateReference!=null  ){
                    data.down<%=i %>.targetValueCurrency=DynamicForm_Invoice_Molybdenum.getValue("invoiceValueCurrency") ;
                    data.down<%=i %>.upDown="down";
                    data.down<%=i %>.invoiceId=<%=invoiceId %>;
                    if (data.down<%=i %>.lessPlus==null || data.down<%=i %>.lessPlus=="" ) {
                    	isc.warn("less or Plus  Required", {title: 'هشدار'});
                    	return;
                    }
                    if (data.down<%=i %>.description==null || data.down<%=i %>.description=="" ) {
                    	isc.warn("description  Required", {title: 'هشدار'});
                    	return;
                    }
                    if (data.down<%=i %>.originValue==null || data.down<%=i %>.originValue<=0 ) {
                    	isc.warn("Origin Value  Required", {title: 'هشدار'});
                    	return;
                    }
                    if (data.down<%=i %>.originValueCurrency==null || data.down<%=i %>.originValueCurrency=="" ) {
                    	isc.warn("Origin Value Currency  Required", {title: 'هشدار'});
                    	return;
                    }
                    if (data.down<%=i %>.conversionRate==null || data.down<%=i %>.conversionRate<=0 ) {
                    	isc.warn("conversionRate  Required", {title: 'هشدار'});
                    	return;
                    }
                    <%--if (data.down<%=i %>.dateRate==null || data.down<%=i %>.dateRate=="" ) {--%>
                    	<%--isc.warn("Date Rate  Required", {title: 'هشدار'});--%>
                    	<%--return;--%>
                    <%--}--%>
                    <%--if (data.down<%=i %>.lessPlus==null || data.down<%=i %>.lessPlus=="" ) {--%>
                    	<%--isc.warn("less or Plus  Required", {title: 'هشدار'});--%>
                    	<%--return;--%>
                    <%--}--%>
                    if (data.down<%=i %>.rateReference==null || data.down<%=i %>.rateReference=="" ) {
                    	isc.warn("Rate Reference  Required", {title: 'هشدار'});
                    	return;
                    }
                    up.add(data.down<%=i %>);
                }
                // data.down<%=i %> ='';
            <% } %>
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
                        Window_Molybdenum.close();
                    } else
                        isc.say(RpcResponse_o.data);
                }
            }));
        }
    });
    var VLayout_Invoice_Molybdenum_Body = isc.VLayout.create({
        width: "100%",
        height: "*",
                autoSize: true,

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

