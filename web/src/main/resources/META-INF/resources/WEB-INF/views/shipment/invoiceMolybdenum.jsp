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
	 valueTmp=DynamicForm_Invoice_Molybdenum.getValue(fld);
	 return !(valueTmp==null || typeof (valueTmp)=='undefined' || valueTmp=="" );
	}
    function sumMolybdenumAndSet(value00,fld00,sumfld00,ii00){
    	gr=0;
       	if (fld00=='grass'){
			for (i=0;i<loop;i++)
          		gr+=DynamicForm_Invoice_Molybdenum_getValue("grass"+i);
          	DynamicForm_Invoice_Molybdenum.setValue('grass',gr)	;
          	return;
       }
       nt=0;moCnt=0;am=0;
       for (i=0;i<loop;i++) {
          nt+=DynamicForm_Invoice_Molybdenum_getValue("net"+i);
          DynamicForm_Invoice_Molybdenum.setValue('molybdenumContent'+i,
          		DynamicForm_Invoice_Molybdenum_getValue('molybdenumPercent'+i)*DynamicForm_Invoice_Molybdenum_getValue("net"+i)/100);
          DynamicForm_Invoice_Molybdenum.setValue('priceFee'+i,
          		DynamicForm_Invoice_Molybdenum_getValue('molybdJenumUnitPrice')*(1-DynamicForm_Invoice_Molybdenum_getValue("discountPercent"+i)/100));
          DynamicForm_Invoice_Molybdenum.setValue('price'+i,
          		DynamicForm_Invoice_Molybdenum_getValue('priceFee'+i)*(DynamicForm_Invoice_Molybdenum_getValue("molybdenumContent"+i)*2.20462));
          am+=DynamicForm_Invoice_Molybdenum_getValue("price"+i);
          moCnt+=DynamicForm_Invoice_Molybdenum_getValue("molybdenumContent"+i);
       }
       DynamicForm_Invoice_Molybdenum.setValue('net',nt)	;
       DynamicForm_Invoice_Molybdenum.setValue('molybdenumContent',moCnt)	;
       DynamicForm_Invoice_Molybdenum_setValue('commercialInvoceValue',am)	; // calling to compute invoice
	}
    function sumUpMolybdenumAndSet(value00,fld00,sumfld00,ii00){
       sumUp=0;
       for (i=0;i< <%= (loopUp==0 ? 3 : loopUp+2 ) %>;i++) {
          nt=0;
          if (DynamicForm_Invoice_Molybdenum_getValue("up.lessPlus"+i)=="PLUS") nt=1;
          else if (DynamicForm_Invoice_Molybdenum_getValue("up.lessPlus"+i)=="MINUS") nt=-1;
            DynamicForm_Invoice_Molybdenum.setValue('up.targetValue'+i,
                    DynamicForm_Invoice_Molybdenum_getValue('up.conversionRate'+i)*DynamicForm_Invoice_Molybdenum_getValue("up.originValue"+i)*nt);
            sumUp+=  DynamicForm_Invoice_Molybdenum_getValue('up.targetValue'+i);
       }
        DynamicForm_Invoice_Molybdenum_setValue('invoiceValueD',DynamicForm_Invoice_Molybdenum_getValue("commercialInvoceValueNet")+sumUp)	; // calling to compute invoice
	}
    function sumdownMolybdenumAndSet(value00,fld00,sumfld00,ii00){
       sumUp=0;
       for (i=0;i< <%= (loopUp==0 ? 3 : loopUp+2 ) %>;i++) {
          nt=0;
          if (DynamicForm_Invoice_Molybdenum_getValue("down.lessPlus"+i)=="PLUS") nt=1;
          else if (DynamicForm_Invoice_Molybdenum_getValue("down.lessPlus"+i)=="MINUS") nt=-1;
            DynamicForm_Invoice_Molybdenum.setValue("down.targetValue"+i,
                    DynamicForm_Invoice_Molybdenum_getValue('down.conversionRate'+i)*DynamicForm_Invoice_Molybdenum_getValue("down.originValue"+i)*nt);
            sumUp+=  DynamicForm_Invoice_Molybdenum_getValue('down.targetValue'+i);
       }
        DynamicForm_Invoice_Molybdenum_setValue('invoiceValue',DynamicForm_Invoice_Molybdenum_getValue("invoiceValueUp")+sumUp)	; // calling to compute invoice
	}
    function multiplyMolybdenum (fld1,value) {
		if (value==null || typeof (value)=='undefined' || fld1==null || typeof (fld1) =='undefined')
		   return 0;
		return fld1 * value;
	}
	function multiplyMolybdenumAndSet (name1,name2,setName0) {
	  val1=DynamicForm_Invoice_Molybdenum.getValue(name1);
	  val2=DynamicForm_Invoice_Molybdenum.getValue(name2);
	  m=multiplyMolybdenum(val1,val2)/((name1=="paidPercent" || name2=="paidPercent") ? 100 : 1);
	  // console.log('name1= '+name1+' name2= '+name2+ ' setname= '+setName0+' mult='+m);
	  DynamicForm_Invoice_Molybdenum_setValue(setName0,m,-1);
	}
	function DynamicForm_Invoice_Molybdenum_getValue(fld){
	 valueTmp=DynamicForm_Invoice_Molybdenum.getValue(fld);
	 return (valueTmp==null || typeof (valueTmp)=='undefined' || valueTmp=="" ) ? 0 : valueTmp;
	}
	function DynamicForm_Invoice_Molybdenum_setValue(fld,value,iii){
		DynamicForm_Invoice_Molybdenum.setValue(fld,value);

// commercialInvoceValueNet=paidPercent*commercialInvoceValue
		if ((fld=="paidPercent" || fld=='commercialInvoceValue' ) && (hasValue("paidPercent") && hasValue('commercialInvoceValue') ))
			multiplyMolybdenumAndSet("paidPercent",'commercialInvoceValue',"commercialInvoceValueNet");

// commercialInvoceValueNet sumUpMolybdenumAndSet
		if (fld=="commercialInvoceValueNet"  )
		   sumUpMolybdenumAndSet(1,"aa","ff",1) ;
// invoiceValue=rate2dollar*invoiceValueD
		if ((fld=="rate2dollar" || fld=='invoiceValueD' ) && (hasValue("rate2dollar") && hasValue('invoiceValueD') )){
			multiplyMolybdenumAndSet("rate2dollar",'invoiceValueD',"invoiceValueUp");
		}
		if ((fld=="invoiceValueUp" ) && ( hasValue('invoiceValueUp') )){
            sumdownMolybdenumAndSet(1,"aa","ff",1) ;
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
                    format: 'DD-MM-YYYY',
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
                {name: "molybdJenumUnitPrice", title: "<spring:message code='invoice.molybdJenumUnitPrice'/>",type: 'float', required: true, width: "100%",keyPressFilter: "[0-9.]",colSpan:2,
                    validators: [{type: "isFloat",validateOnExit: true,stopOnError: true,errorMessage: "<spring:message code='global.form.correctType'/>" }],
                    changed	: function(form, item, value){ sumMolybdenumAndSet(value,"molybdJenumUnitPrice","none",-1);	} },
              // {
              //       type: "Header",
              //       defaultValue: " - - - LotNo. - - - - - - - Grass- - - - - - - - - - - -Net - - - - - - -  - MO%- - - - CU%- MolybdenumContent- Discount%- - -  Fee - - - - -  Price"
              //   },
<%		for (int i=0;i<loop;i++){ %>
                {name: "id<%=i %>", hidden: true},
                {name: "invoiceId<%=i %>", hidden: true},
                {name: "version<%=i %>", hidden: true},
                {name: "lotNo<%=i %>",title:"lotNo",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'text', required: false, width: "100%"},
                {name: "grass<%=i %>",title:"Grass",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'float', required: false, width: "100%",keyPressFilter: "[0-9.]",colSpan:2,
                    validators: [{type: "isFloat",validateOnExit: true,stopOnError: true,errorMessage: "<spring:message code='global.form.correctType'/>" }],
                    changed	: function(form, item, value){ sumMolybdenumAndSet(value,"grass","grass","<%=i %>");	} },
                {name: "net<%=i %>",title:"Net",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'float', required: false, width: "100%",keyPressFilter: "[0-9.]",colSpan:2,
                    validators: [{type: "isFloat",validateOnExit: true,stopOnError: true,errorMessage: "<spring:message code='global.form.correctType'/>" }],
                    changed	: function(form, item, value){ sumMolybdenumAndSet(value,"net","net","<%=i %>");	} },
                {name: "molybdenumPercent<%=i %>",title:"MO%",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'float', required: false, width: "100%",keyPressFilter: "[0-9.]",
                    validators: [{type: "isFloat",validateOnExit: true,stopOnError: true,errorMessage: "<spring:message code='global.form.correctType'/>" }] ,
                    changed	: function(form, item, value){ sumMolybdenumAndSet(value,"molybdenumPercent","none","<%=i %>");	} },
                {name: "copperPercent<%=i %>",title:"CU%",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'float', required: false, width: "100%",keyPressFilter: "[0-9.]",
                    validators: [{type: "isFloat",validateOnExit: true,stopOnError: true,errorMessage: "<spring:message code='global.form.correctType'/>" }]} ,
                {name: "molybdenumContent<%=i %>",title:"MO content",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'float', required: false, width: "100%",canEdit:false},
                {name: "discountPercent<%=i %>",title:"Discount%",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'float', required: false, width: "100%",keyPressFilter: "[0-9.]",
                    validators: [{type: "isFloat",validateOnExit: true,stopOnError: true,errorMessage: "<spring:message code='global.form.correctType'/>" }] ,
                    changed	: function(form, item, value){ sumMolybdenumAndSet(value,"discountPercent","none","<%=i %>");	} },
                {name: "priceFee<%=i %>",title:"Fee",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'float', required: false, width: "100%",canEdit:false, },
                {name: "price<%=i %>",title:"Price",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'float', required: false, width: "100%",keyPressFilter: "[0-9.]",colSpan:2,canEdit:false },
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
   <%		for (int i=0;i<(loopUp==0 ? 3 : loopUp+2 );i++){ %>
                {name: "up.id<%=i %>", hidden: true},
                {name: "up.invoiceId<%=i %>", hidden: true},
                {name: "up.version<%=i %>", hidden: true},
                {name: "up.upDown<%=i %>",defaultValue:"up", hidden: true},
                {name: "up.description<%=i %>",title:"Description", <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %> ,type : 'text', required: false, width: "100%",colSpan:4},
                {name: "up.originValue<%=i %>",title:"OriginValue",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'float', required: false, width: "100%",keyPressFilter: "[0-9.]",colSpan:1,
                    validators: [{type: "isFloat",validateOnExit: true,stopOnError: true,errorMessage: "<spring:message code='global.form.correctType'/>" }],
                    changed	: function(form, item, value){ sumUpMolybdenumAndSet(value,"up.originValue","up.originValue","<%=i %>");	} },
                {name: "up.originValueCurrency<%=i %>",title:"Currency",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'text', required: false, width: "100%",colSpan:1,valueMap: dollar },
                {name: "up.conversionRate<%=i %>",title:"Rate",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'float', required: false, width: "100%",keyPressFilter: "[0-9.]",colSpan:1,
                    validators: [{type: "isFloat",validateOnExit: true,stopOnError: true,errorMessage: "<spring:message code='global.form.correctType'/>" }],
                    changed	: function(form, item, value){ sumUpMolybdenumAndSet(value,"up.originValue","up.originValue","<%=i %>");	} },
                {name: "up.dateRate<%=i %>",title:"RateDate",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'date', useTextField:true, required: false, width: "100%",colSpan:1 },
                {name: "up.rateReference<%=i %>",title:"Refere",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'text', required: false, width: "100%",colSpan:1 },
                {name: "up.lessPlus<%=i %>",title:"+/-",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'text', required: false, width: "100%",colSpan:1,valueMap: {"PLUS":"PLUS","MINUS":"MINUS"} ,
                    changed	: function(form, item, value){ sumUpMolybdenumAndSet(value,"up.originValue","up.originValue","<%=i %>");	} },
                {name: "up.targetValue<%=i %>",title:"Value",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'float', required: false, width: "100%",colSpan:2,canEdit:false },
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
		   			  	multiplyMolybdenumAndSet("rate2dollar",'invoiceValueD',"invoiceValueUp");

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
                {name: "down.id<%=i %>", hidden: true},
                {name: "down.invoiceId<%=i %>", hidden: true},
                {name: "down.version<%=i %>", hidden: true},
                {name: "down.upDown<%=i %>",defaultValue:"down", hidden: true},
                {name: "down.description<%=i %>",title:"Description", <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %> ,type : 'text', required: false, width: "100%",colSpan:4},
                {name: "down.originValue<%=i %>",title:"OriginValue",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'float', required: false, width: "100%",keyPressFilter: "[0-9.]",colSpan:1,
                    validators: [{type: "isFloat",validateOnExit: true,stopOnError: true,errorMessage: "<spring:message code='global.form.correctType'/>" }],
                    changed	: function(form, item, value){ sumdownMolybdenumAndSet(value,"down.originValue","down.originValue","<%=i %>");	} },
                {name: "down.originValueCurrency<%=i %>",title:"Currency",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'text', required: false, width: "100%",colSpan:1,valueMap: dollar },
                {name: "down.conversionRate<%=i %>",title:"Rate",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'float', required: false, width: "100%",keyPressFilter: "[0-9.]",colSpan:1,
                    validators: [{type: "isFloat",validateOnExit: true,stopOnError: true,errorMessage: "<spring:message code='global.form.correctType'/>" }],
                    changed	: function(form, item, value){ sumdownMolybdenumAndSet(value,"down.originValue","down.originValue","<%=i %>");	} },
                {name: "down.dateRate<%=i %>",title:"RateDate",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'date', useTextField:true, required: false, width: "100%",colSpan:1 },
                {name: "down.rateReference<%=i %>",title:"Refere",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'text', required: false, width: "100%",colSpan:1 },
                {name: "down.lessPlus<%=i %>",title:"+/-",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'text', required: false, width: "100%",colSpan:1,valueMap: {"PLUS":"PLUS","MINUS":"MINUS"},
                    changed	: function(form, item, value){ sumdownMolybdenumAndSet(value,"down.originValue","down.originValue","<%=i %>");	} },
                {name: "down.targetValue<%=i %>",title:"Value",  <%= (i==0) ? "titleOrientation:'top'":"showTitle: false" %>,type: 'float', required: false, width: "100%",colSpan:2,canEdit:false },
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
               DynamicForm_Invoice_Molybdenum.setValue("invoiceId<%=i %>", "<%= invoiceId %>");
            <% if (i<list.size()) {
                  if (list.get(i).getId()!=null) { %>
               DynamicForm_Invoice_Molybdenum.setValue("id<%=i %>", <%=list.get(i).getId() %>);
               DynamicForm_Invoice_Molybdenum.setValue("version<%=i %>", <%= list.get(i).getVersion() %>);
               <% }
                  if (list.get(i).getLotNo()!=null) { %>
               DynamicForm_Invoice_Molybdenum.setValue("lotNo<%=i %>", "<%= list.get(i).getLotNo() %>");
               <% }
                  if (list.get(i).getGrass()!=null) { %>
               DynamicForm_Invoice_Molybdenum.setValue("grass<%=i %>", <%= list.get(i).getGrass() %>);
               <% }
                  if (list.get(i).getNet()!=null) { %>
               DynamicForm_Invoice_Molybdenum.setValue("net<%=i %>", <%= list.get(i).getNet() %>);
               <% }
                  if (list.get(i).getMolybdenumPercent()!=null) { %>
               DynamicForm_Invoice_Molybdenum.setValue("molybdenumPercent<%=i %>", <%= list.get(i).getMolybdenumPercent() %>);
               <% }
                  if (list.get(i).getCopperPercent()!=null) { %>
               DynamicForm_Invoice_Molybdenum.setValue("copperPercent<%=i %>", <%= list.get(i).getCopperPercent() %>);
               <% }
                  if (list.get(i).getMolybdenumContent()!=null) { %>
               DynamicForm_Invoice_Molybdenum.setValue("molybdenumContent<%=i %>", <%= list.get(i).getMolybdenumContent() %>);
               <% }
                  if (list.get(i).getDiscountPercent()!=null) { %>
               DynamicForm_Invoice_Molybdenum.setValue("discountPercent<%=i %>", <%= list.get(i).getDiscountPercent() %>);
               <% }
                  if (list.get(i).getPriceFee()!=null) { %>
               DynamicForm_Invoice_Molybdenum.setValue("priceFee<%=i %>", <%= list.get(i).getPriceFee() %>);
               <% }
                  if (list.get(i).getPrice()!=null) { %>
               DynamicForm_Invoice_Molybdenum.setValue("price<%=i %>", <%= list.get(i).getPrice() %>);
 			<% }
 			}
  } %>


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
            isc.RPCManager.sendRequest(Object.assign(BaseRPCRequest,{
                actionURL: "${contextPath}/api/invoice/molybdenum",
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

